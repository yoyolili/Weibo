//
//  FIndViewController.m
//  微博
//
//  Created by 阿喵 on 16/1/18.
//  Copyright © 2016年 河南青云. All rights reserved.
//

#import "FindViewController.h"
#import "Common.h"

@interface FindViewController ()

//类型为strong强引用，保留登录按钮，不会被释放。
@property (nonatomic, strong)IBOutlet UIBarButtonItem *loginItem;

@end

@implementation FindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if ([[AccountHandle shareAccount] isLogin]) {
        self.navigationItem.rightBarButtonItem = nil;
    }else{
        //退出登录之后，还能再次显示登录按钮
        self.navigationItem.rightBarButtonItem = self.loginItem;
    }
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
