//
//  SettingTableViewController.m
//  微博
//
//  Created by 阿喵 on 16/1/18.
//  Copyright © 2016年 河南青云. All rights reserved.
//

#import "SettingTableViewController.h"
#import "Common.h"

@interface SettingTableViewController ()

@end

@implementation SettingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //退出登录
    //清除数据
    [[AccountHandle shareAccount] logout];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kLogoutSuccess object:nil];
    
    [self.navigationController popViewControllerAnimated:YES];
}


@end
