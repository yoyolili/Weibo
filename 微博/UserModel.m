//
//  UserModel.m
//  微博
//
//  Created by qingyun on 16/1/26.
//  Copyright © 2016年 河南青云. All rights reserved.
//

#import "UserModel.h"
#import "Common.h"

@implementation UserModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self == [super init]) {
        //设置属性
        self.userId = dict[kUserID];
        self.screen_name = dict[kUserInfoScreenName];
        self.userDescription = dict[kUserDescription];
        self.profile_image_url = dict[kUserProfileImageURL];
        self.avatar_hd = dict[kUserAvatarHd];}
    return self;
}

@end
