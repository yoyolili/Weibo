//
//  MainTabViewController.m
//  微博
//
//  Created by 阿喵 on 16/1/18.
//  Copyright © 2016年 河南青云. All rights reserved.
//

#import "MainTabViewController.h"
#import "Common.h"

@interface MainTabViewController ()

@end

@implementation MainTabViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setSelfView];
}

- (void)setSelfView
{
    //设置tabBar的选中颜色
    self.tabBar.tintColor = [UIColor orangeColor];
    //设置默认显示的控制器
    if (![[AccountHandle shareAccount] isLogin]) {
        self.selectedIndex = 3;
    }
    
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(login:) name:kLoginSuccess object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logout:) name:kLogoutSuccess object:nil];
}

- (void)login:(NSNotification *)notification
{
    self.selectedIndex = 0;
}

- (void)logout:(NSNotification *)notification
{
    self.selectedIndex = 3;
    
    //显示登录界面
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [story instantiateViewControllerWithIdentifier:@"mainTab"];
    [self presentViewController:vc animated:YES completion:nil];
}

@end
