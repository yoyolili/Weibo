//
//  MainViewController.m
//  微博
//
//  Created by 阿喵 on 16/1/15.
//  Copyright © 2016年 河南青云. All rights reserved.
//

#import "MainViewController.h"
#import "Common.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //设置tabBar的选中颜色
    self.tabBarController.tabBar.tintColor = [UIColor orangeColor];
    //设置默认显示的控制器
    self.tabBarController.selectedIndex = 3;

    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(login:) name:kLoginSuccess object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logout:) name:kLogoutSuccess object:nil];
    
}

- (void)login:(NSNotification *)notification
{
    self.tabBarController.selectedIndex = 0;
}

- (void)logout:(NSNotification *)notification
{
    self.tabBarController.selectedIndex = 3;
    
    //显示登录界面
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [story instantiateViewControllerWithIdentifier:@"mainTab"];
    [self presentViewController:vc animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
