//
//  AccountHandle.m
//  微博
//
//  Created by 阿喵 on 16/1/18.
//  Copyright © 2016年 河南青云. All rights reserved.
//

#import "AccountHandle.h"
#import "Common.h"

@interface AccountHandle ()<NSCoding>

@property (nonatomic, strong) NSString *token;//令牌
@property (nonatomic, strong) NSString *uid;//用户ID
@property (nonatomic, strong) NSDate *exprisionDate;//过期时间

@end

@implementation AccountHandle

+ (instancetype)shareAccount
{
    static AccountHandle *account;
    
    //在应用程序执行的过程中只执行一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //解档
        NSString *filePath = [NSString documentsFilePath:kFileName];
        account = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
        //如果 第一次运行，文件为空，则解档的对象也是空的
        if (!account) {
            account = [[AccountHandle alloc] init];
        }
        
    });
    
    return account;
}

- (void)saveAccountInfo:(NSDictionary *)dict
{
    self.token = dict[kAccessToken];
    self.uid = dict[kUid];
    double expiresIn = [dict[kExpiresIn] doubleValue];
    self.exprisionDate = [[NSDate date] dateByAddingTimeInterval:expiresIn];
    
    //归档
    NSString *filePath = [NSString documentsFilePath:kFileName];
    
    [NSKeyedArchiver archiveRootObject:self toFile:filePath];
    
}

- (BOOL)isLogin
{
    //token有效且有token -> 登录状态
    if (self.token && [self.exprisionDate compare:[NSDate date]] == NSOrderedDescending) {
        //过期时间与当前的时间比较，如果大于过期时间则为yes
        return YES;
    }
    return NO;
}

- (void)logout
{
    //清除本地数据
    self.token = nil;
    self.uid = nil;
    self.exprisionDate = nil;
    
    //删除归档的文件
    NSError *error;
    [[NSFileManager defaultManager] removeItemAtPath:[NSString documentsFilePath:kFileName] error:&error];
    
    
}

- (NSMutableDictionary *)requestParams
{
    //保存token信息
    if ([self isLogin]) {
        return [NSMutableDictionary dictionaryWithObject:self.token forKey:kAccessToken];
    }
    return nil;
}

#pragma mark - NSCoding protocol

//解码
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.token = [aDecoder decodeObjectForKey:kAccessToken];
        self.uid = [aDecoder decodeObjectForKey:kUid];
        self.exprisionDate = [aDecoder decodeObjectForKey:kExpiresIn];
    }
    return self;
}

//编码
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.token forKey:kAccessToken];
    [aCoder encodeObject:self.uid forKey:kUid];
    [aCoder encodeObject:self.exprisionDate forKey:kExpiresIn];
}

@end
