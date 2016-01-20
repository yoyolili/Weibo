//
//  MainViewController.m
//  微博
//
//  Created by 阿喵 on 16/1/15.
//  Copyright © 2016年 河南青云. All rights reserved.
//

#import "HomeViewController.h"
#import "Common.h"

@interface HomeViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

//从storyboard中初始化时调用此方法
- (void)awakeFromNib
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadData) name:kLoginSuccess object:nil];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadData];
}

- (void)loadData
{
    NSString *url = [kBaseURL stringByAppendingPathComponent:@"statuses/home_timeline.json"];
    
    NSMutableDictionary *para = [[AccountHandle shareAccount] requestParams];
    
    if (!para) {
        return;
    }
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"object >>> %@",responseObject);
        self.dataArray = responseObject[@"statuses"];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error >>> %@",error);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"statusCell";
    HomeInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    [cell bindingData:self.dataArray[indexPath.row]];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
#if 0
    /*
     *method 1:使用NSString的方法手动计算text的内容从而设置cell的高度
     *通过取出content的文字信息，计算cell的高度
     */
    NSString *text = self.dataArray[indexPath.row][@"text"];
    CGFloat width = kScreenWidth - 8 - 8;
    CGSize size = [text stringSizeWithWidth:width Font:[UIFont systemFontOfSize:17]];
    //1：分隔线
    return 66 + size.height + 1;
#endif
    /*
     *method 2:自动计算cell的高度
     *①，要加向下的约束
     *②，label的preferredMaxLayoutWidth属性要设置
     */
    HomeInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"statusCell"];
    [cell bindingData:self.dataArray[indexPath.row]];
    
    //计算cell的contentView的整体高度
    return [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
