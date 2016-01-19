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

#define kScreenWidth        self.view.bounds.size.width
#define kScreenHeight       self.view.bounds.size.height

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

#endif /* Common_h */
