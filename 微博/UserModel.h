//
//  UserModel.h
//  微博
//
//  Created by qingyun on 16/1/26.
//  Copyright © 2016年 河南青云. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject

@property (nonatomic, strong) NSNumber *userId;//用户UID
@property (nonatomic, strong) NSString *screen_name;//用户昵称
@property (nonatomic, strong) NSString *userDescription;//用户个人描述
@property (nonatomic, strong) NSString  *profile_image_url;//用户头像地址（中图），50×50像素
@property (nonatomic, strong) NSString *avatar_hd;//用户头像地址（高清），高清头像原图

- (instancetype)initWithDict:(NSDictionary *)dict;

@end
