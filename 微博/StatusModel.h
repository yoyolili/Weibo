//
//  StatusModel.h
//  微博
//
//  Created by qingyun on 16/1/26.
//  Copyright © 2016年 河南青云. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UserModel;

@interface StatusModel : NSObject

@property (nonatomic, strong) NSDate *created_at;//微博创建时间
@property (nonatomic, strong) NSNumber *statusID;//微博ID
@property (nonatomic, strong) NSString *text;//微博信息内容
@property (nonatomic, strong) NSString *source;//微博来源
@property (nonatomic, strong) UserModel *user;//微博作者的用户信息字段 详细
@property (nonatomic, strong) StatusModel *retweeted_status;//被转发的原微博信息字段，当该微博为转发微博时返回 详细
@property (nonatomic, strong) NSNumber *reposts_count;//转发数
@property (nonatomic, strong) NSNumber *comments_count;//评论数
@property (nonatomic, strong) NSNumber *attitudes_count;//表态数
@property (nonatomic, strong) NSArray *pic_urls;//微博配图的缩略图
@property (nonatomic) NSString *timeAgo;//显示时间

- (instancetype)initWithDict:(NSDictionary *)dict;

@end
