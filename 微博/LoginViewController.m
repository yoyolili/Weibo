//
//  LoginViewController.m
//  微博
//
//  Created by 阿喵 on 16/1/16.
//  Copyright © 2016年 河南青云. All rights reserved.
//

#import "LoginViewController.h"
#import "Common.h"

@interface LoginViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self webViewLoadURL];
    // Do any additional setup after loading the view.
}
- (IBAction)cancel:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)webViewLoadURL
{
    //OAuth认证
    NSString *url = [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@&response_type=code",kAppKey,kRedirectURI];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [self.webView loadRequest:request];
    
    self.webView.delegate = self;
}

#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    //取出请求的url地址
    NSString *urlString = request.URL.absoluteString;
    NSLog(@"[---urlString---] >>> %@",urlString);
    
    //以回调地址开头的url
    if ([urlString hasPrefix:kRedirectURI]) {
        NSArray *result = [urlString componentsSeparatedByString:@"code="];
        //code->取出的授权码->accessToken
        //取出服务器返回的code
        NSString *code = result.lastObject;
        NSString *urlString = @"https://api.weibo.com/oauth2/access_token";
        //请求的参数
        NSDictionary *para = @{@"client_id":kAppKey,
                               @"client_secret":kAppSecret,
                               @"grant_type":@"authorization_code",
                               @"code":code,
                               @"redirect_uri":kRedirectURI};
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", nil];
        [manager POST:urlString parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"[---responseObject---] >>> %@",responseObject);
            //单例 保存信息
            [[AccountHandle shareAccount] saveAccountInfo:responseObject];
            [self dismissViewControllerAnimated:YES completion:nil];
            
            //发通知
            [[NSNotificationCenter defaultCenter]postNotificationName:kLoginSuccess object:nil];
            
            //清除webView的缓存
            NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
            NSArray *cookies = storage.cookies;
            [cookies enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [storage deleteCookie:obj];
            }];
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"[---error---] >>> %@",error);
        }];
    }
    
    return YES;
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
