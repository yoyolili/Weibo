//
//  AccountHandle.h
//  微博
//
//  Created by 阿喵 on 16/1/18.
//  Copyright © 2016年 河南青云. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccountHandle : NSObject

+ (instancetype)shareAccount;

//保存登录信息
- (void)saveAccountInfo:(NSDictionary *)dict;

//判断是否登录
- (BOOL)isLogin;

//包含token的可变字典
- (NSMutableDictionary *)requestParams;

- (void)logout;

@end
