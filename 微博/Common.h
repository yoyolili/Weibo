//
//  Common.h
//  微博
//
//  Created by 阿喵 on 16/1/16.
//  Copyright © 2016年 河南青云. All rights reserved.
//

#ifndef Common_h
#define Common_h

#import "GuideViewController.h"
#import "HomeViewController.h"
#import "AFNetworking.h"
#import "NSString+Documents.h"
#import "AccountHandle.h"
#import "MainTabViewController.h"
#import "HomeInfoTableViewCell.h"
#import "NSString+StringSize.h"
#import "UINavigationController+notification.h"
#import "MJRefresh.h"
#import "StatusFooterView.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "SDPhotoBrowser.h"
#import "StatusModel.h"
#import "UserModel.h"

#define kScreenWidth       [UIScreen mainScreen].bounds.size.width
#define kScreenHeight      [UIScreen mainScreen].bounds.size.height

#define kAccessToken        @"access_token"
#define kUid                @"uid"
#define kExpiresIn          @"expires_in"
#define kFileName           @"accountFile"

#define kLoginSuccess       @"loginSuccess"
#define kLogoutSuccess      @"logoutSuccess"

#define kFirstLaunchKey     @"firstLaunch"
#define kAppRun             @"appRun"
#define kAppKey             @"1553925842"
#define kRedirectURI        @"https://api.weibo.com/oauth2/default.html"
#define kAppSecret          @"bd35e63766b7fa071bf1f96a941f19f9"
#define kBaseURL            @"https://api.weibo.com/2"

//解析微博所使用的关键字常量，也就是新浪服务器返回的数据由JSONKit解析后生成的字典关于微博信息的key值
static NSString * const kStatusCreateTime = @"created_at";
static NSString * const kStatusID = @"id";
static NSString * const kStatusMID = @"mid";
static NSString * const kStatusText = @"text";
static NSString * const kStatusSource = @"source";
static NSString * const kStatusThumbnailPic = @"thumbnail_pic";
static NSString * const kStatusOriginalPic = @"original_pic";
static NSString * const kStatusPicUrls = @"pic_urls";
static NSString * const kStatusRetweetStatus = @"retweeted_status";
static NSString * const kStatusUserInfo = @"user";
static NSString * const kStatusRetweetStatusID = @"retweeted_status_id";
static NSString * const kStatusRepostsCount = @"reposts_count";
static NSString * const kStatusCommentsCount = @"comments_count";
static NSString * const kStatusAttitudesCount = @"attitudes_count";
static NSString * const kstatusFavorited = @"favorited";

//解析微博用户数据所使用的关键字常量，也就是新浪服务器返回的数据由JSONKit解后生成的字典关于用户信息的Key值。
static NSString * const kUserInfoScreenName = @"screen_name";
static NSString * const kUserInfoName = @"name";
static NSString * const kUserAvatarLarge = @"avatar_large";
static NSString * const kUserAvatarHd = @"avatar_hd";
static NSString * const kUserID = @"id";
static NSString * const kUserDescription = @"description";
static NSString * const kUserVerifiedReson = @"verified_reason";
static NSString * const kUserFollowersCount = @"followers_count";
static NSString * const kUserStatusCount = @"statuses_count";
static NSString * const kUserFriendCount = @"friends_count";
static NSString * const kUserStatusInfo = @"status";
static NSString * const kUserStatuses = @"statuses";
static NSString * const kUserProfileImageURL = @"profile_image_url";

#endif /* Common_h */
