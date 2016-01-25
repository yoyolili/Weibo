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
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic) BOOL refreshing;

@end

@implementation HomeViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createRefreshControl];
    
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

- (void)createRefreshControl
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadNew:self.refreshControl];
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
    }];
}

#pragma mark - load data
//加载数据
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
//下拉刷新
- (void)loadNew:(UIRefreshControl *)refreshControl
{
    //触发加载更多
    NSString *url = [kBaseURL stringByAppendingPathComponent:@"statuses/home_timeline.json"];
    
    NSMutableDictionary *para = [[AccountHandle shareAccount] requestParams];
    [para setObject:self.dataArray.firstObject[@"id"] forKey:@"since_id"];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"new data >>> %@",responseObject[@"statuses"]);
        //将新的数据放在数组前面
        NSMutableArray *array = [NSMutableArray arrayWithArray:responseObject[@"statuses"]];
        [array addObjectsFromArray:self.dataArray];
        self.dataArray = array;
        
        [self.tableView reloadData];
        [self.navigationController showNotification:[NSString stringWithFormat:@"更新了%ld条微博",[responseObject[@"statuses"] count]]];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error >>> %@",error);
    }];
    
    if (self.refreshControl.isRefreshing) {
        [self.refreshControl endRefreshing];
    }
    if (self.tableView.mj_header.isRefreshing) {
        [self.tableView.mj_header endRefreshing];
    }
    if (self.tableView.mj_footer.isRefreshing) {
        [self.tableView.mj_footer endRefreshing];
    }
    
}

//加载更多
- (void)loadMore
{
    NSString *url = [kBaseURL stringByAppendingPathComponent:@"statuses/home_timeline.json"];
    
    NSMutableDictionary *para = [[AccountHandle shareAccount] requestParams];
    
    if (!para) {
        return;
    }
    
    [para setObject:self.dataArray.lastObject[@"id"] forKey:@"max_id"];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    if (self.refreshing) {
        return;
    }
    self.refreshing = YES;
    [manager GET:url parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSMutableArray *dict = responseObject[@"statuses"];
        NSMutableArray *array = [NSMutableArray arrayWithArray:self.dataArray];
        [array addObjectsFromArray:dict];
        self.dataArray = array;
        
        [self.tableView reloadData];
        self.refreshing = NO;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error >>> %@",error);
        self.refreshing = NO;
    }];
}

#pragma mark - UITableViewDataSource
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

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //在倒数第3条时，加载更多
    if (self.dataArray.count - 1 - indexPath.row == 3) {
        [self loadMore];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
