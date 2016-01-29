//
//  MyGrapedViewController.m
//  TaoYXNew
//
//  Created by tianan-apple on 16/1/22.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "MyGrapedViewController.h"
#import "PublicDefine.h"
#import "DPAPI.h"
#import "MJRefresh.h"
#import "NavTableViewCell.h"
#import "NavModel.h"
#import "MyGrapTableViewCell.h"
#import "MyGrapDeal.h"

@interface MyGrapedViewController ()<DPRequestDelegate,MJRefreshBaseViewDelegate>
{
    NSMutableArray *_tableDataSource;
    NSString *_selectedCityName;
    NSString *_selectedCategory;
    NSInteger _pageindex;//显示数据的页码，每次刷新+1
    NSString *_newsAllwaysFlash;//是否强制刷新 1强制刷新 其他先取缓存
    
    MJRefreshFooterView *_footer;//上拉刷新
    MJRefreshHeaderView *_header;//下拉刷新
    NSInteger refreshFlag;
    NSInteger selectedTableIndex;
}
@end

@implementation MyGrapedViewController

- (instancetype)init:(NSString*)mid
{
    self = [super init];
    if (self) {
        self.supplyId=mid;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    refreshFlag=0;
    [self loadTopNavView];
    [self loadTableView];
    [self loadBackToTopBtn];
    [self stdRightGesture];
}

-(void)stdRightGesture{
    self.rightSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    self.rightSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:self.rightSwipeGestureRecognizer];
}
- (void)handleSwipes:(UISwipeGestureRecognizer *)sender
{
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

static NSString * const OrderListCellId = @"myGrapListCellId";
-(void)loadTableView{
    self.TableView=[[UITableView alloc]initWithFrame:CGRectMake(0, TopSeachHigh, fDeviceWidth, fDeviceHeight-TopSeachHigh)];
    self.TableView.delegate=self;
    self.TableView.dataSource=self;
    [self.view addSubview:self.TableView];
    
    self.TableView.backgroundColor=collectionBgdColor;
    [self.TableView registerClass:[MyGrapTableViewCell class] forCellReuseIdentifier:OrderListCellId];
    
    
    _tableDataSource = [NSMutableArray array];//还要再搞一次，否则_dataSource装不进去数据
    _newsAllwaysFlash=@"0";
    _pageindex=1;
    [self createRequest];
    
    // 3.集成刷新控件
    // 3.1.下拉刷新
    MJRefreshHeaderView *header = [MJRefreshHeaderView header];
    header.scrollView = self.TableView;
    header.delegate = self;
    // 自动刷新
    
    _header = header;
    //NSLog(@"%@",_header.lastUpdateTimeLabel.text);
    
    // 集成刷新控件
    // 上拉刷新
    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
    footer.scrollView = self.TableView;
    footer.delegate = self;
    _footer = footer;
    
}

-(void)setSupplyId:(NSString *)supplyId{
    _supplyId=supplyId;
}
# pragma 网络请求
- (void)createRequest{
    DPAPI *api = [[DPAPI alloc]init];
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    _selectedCityName=@"mgetordersbysupplyid";
    [params setValue:_selectedCityName forKey:@"ut"];
    [params setValue:_supplyId forKey:@"supplyId"];
    [api setAllwaysFlash:@"1"];
    refreshFlag=1;
    [params setValue:[NSNumber numberWithInteger:15] forKey:@"pageSize"];
    [params setValue:[NSNumber numberWithInteger:_pageindex] forKey:@"pageNo"];
    [api setAllwaysFlash:_newsAllwaysFlash];
    [api requestWithURL:NetUrl params:params delegate:self];}

-(void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result
{
    //NSLog(@"抢单响应：%@",result);
    MyGrapDeal *dm;
    NSArray *datatmp;
    NSDictionary *dict = result;
    dm= [[MyGrapDeal alloc]init];
    datatmp=[dm asignModelWithDict:dict];
    if (refreshFlag==1) {
        [_tableDataSource removeAllObjects];
    }
    
    [_tableDataSource addObjectsFromArray:datatmp];
    
    [self.TableView reloadData];
    
}
-(void)request:(DPRequest *)request didFailWithError:(NSError *)error
{
    NSLog(@"报错了：%@",error);
}

#pragma table delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _tableDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MyGrapTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:OrderListCellId forIndexPath:indexPath];
    
    // 将数据视图框架模型(该模型中包含了数据模型)赋值给Cell，
    MyGrapDeal *dm=_tableDataSource[indexPath.item];
    [cell showUiSupplyCell:dm];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 160;//餐企商超
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    
}


# pragma 网络请求
- (void)createDelCarRequest:(NSString*)delId{
    DPAPI *api = [[DPAPI alloc]init];
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setValue:@"mconfirmorder" forKey:@"ut"];
    [params setValue:delId forKey:@"orderId"];
    [api setAllwaysFlash:@"1"];
    NSString *myurl=NetUrl;
    [api loginRequestWithURL:myurl params:params delegate:self];
}

-(void)loginrequest:(DPRequest *)request didFinishLoadingWithResult:(id)result{
    NSDictionary *dict=result;
    //NSLog(@"删除返回：%@",dict);
    NSString *logstr=[dict objectForKey:@"msg"];
    if ([logstr isEqualToString:@"ok"]) {//成功
       
        refreshFlag=1;
        [self createRequest];
        
    }
    
}


//按钮显示的内容
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
     MyGrapTableViewCell *svc =(MyGrapTableViewCell*)[self.TableView cellForRowAtIndexPath:indexPath];
    if ([svc.supplyOrderFlag.text isEqualToString:@"中单状态：抢单中"]) {
        return @"选定中单";
    }
    return nil;
    
}
//这里就是点击删除执行的方法
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    selectedTableIndex=indexPath.row;
    MyGrapTableViewCell *svc =(MyGrapTableViewCell*)[self.TableView cellForRowAtIndexPath:indexPath];
    if ([svc.supplyOrderFlag.text isEqualToString:@"中单状态：抢单中"])
    [self createDelCarRequest:svc.supplyOrderId];
}

-(void)loadBackToTopBtn{
    // 添加回到顶部按钮
    _topBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _topBtn.frame = CGRectMake(fDeviceWidth-50, fDeviceHeight-140, 40, 40);
    [_topBtn setBackgroundImage:[UIImage imageNamed:@"back2top.png"] forState:UIControlStateNormal];
    [_topBtn addTarget:self action:@selector(backToTopButton) forControlEvents:UIControlEventTouchUpInside];
    _topBtn.clipsToBounds = YES;
    _topBtn.hidden = YES;
    [self.view addSubview:_topBtn];
}
- (void)backToTopButton{
    [self.TableView setContentOffset:CGPointMake(0, 0) animated:YES];
}
// MARK:  计算偏移量
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //MARK:列表滑动偏移量计算
    CGPoint point = [self.TableView contentOffset];
    
    if (point.y >= self.TableView.frame.size.height) {
        self.topBtn.hidden = NO;
        [self.view bringSubviewToFront:self.topBtn];
    } else {
        self.topBtn.hidden = YES;
    }
}


#pragma mark - 刷新控件的代理方法
#pragma mark 开始进入刷新状态

- (void)doneWithView:(MJRefreshBaseView *)refreshView
{
    
    // 刷新表格
    //[self.TableView reloadData];
    
    // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
    [refreshView endRefreshing];
    
}

-(void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    //下拉刷新第一页MJRefreshHeaderView MJRefreshFooterView
    
    NSString *myClass=refreshView.description;
    NSRange myRang=[myClass rangeOfString:@"MJRefreshHeaderView"];
    
    if (myRang.length>0) {//下拉强制刷新
        _pageindex=1;
        _newsAllwaysFlash=@"1";//强制刷新
        refreshFlag=1;
        [_tableDataSource removeAllObjects];
        DPAPI *api = [[DPAPI alloc]init];
        NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
        _selectedCityName=@"mgetordersbysupplyid";
        [params setValue:_selectedCityName forKey:@"ut"];
        [params setValue:_supplyId forKey:@"supplyId"];

        
        [params setValue:_selectedCityName forKey:@"ut"];
        [params setValue:[NSNumber numberWithInteger:_pageindex] forKey:@"pageNo"];
        [params setValue:[NSNumber numberWithInteger:15] forKey:@"pageSize"];
        [api setAllwaysFlash:_newsAllwaysFlash];
        [api requestWithURL:NetUrl params:params delegate:self];
        
        // 2.2秒后刷新表格UI
        [self performSelector:@selector(doneWithView:) withObject:refreshView afterDelay:2.0];
    }
    else
    {
        refreshFlag=0;
        DPAPI *api = [[DPAPI alloc]init];
        NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
        _selectedCityName=@"mgetordersbysupplyid";
        _pageindex+=1;
        [params setValue:_selectedCityName forKey:@"ut"];
        [params setValue:_supplyId forKey:@"supplyId"];
        [params setValue:[NSNumber numberWithInteger:15] forKey:@"pageSize"];
        [params setValue:[NSNumber numberWithInteger:_pageindex] forKey:@"pageNo"];
        [api setAllwaysFlash:_newsAllwaysFlash];
        [api requestWithURL:NetUrl params:params delegate:self];
        
        // 2.2秒后刷新表格UI
        [self performSelector:@selector(doneWithView:) withObject:refreshView afterDelay:2.0];
    }
}

#pragma mark 刷新完毕
- (void)refreshViewEndRefreshing:(MJRefreshBaseView *)refreshView
{
    NSLog(@"%@----刷新完毕", refreshView.class);
}
-(void)dealloc
{
    [_header removeFromSuperview];
    [_footer removeFromSuperview];
}

//顶部导航条
-(void)loadTopNavView{
    UIView *topView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, TopSeachHigh)];
    topView.backgroundColor=topSearchBgdColor;
    
    UIImageView *backimg=[[UIImageView alloc]initWithFrame:CGRectMake(8, 24, 60, 24)];
    backimg.image=[UIImage imageNamed:@"bar_back"];
    [topView addSubview:backimg];
    //返回按钮
    UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
    [back setFrame:CGRectMake(0, 22, 70, 42)];
    [back addTarget:self action:@selector(clickleftbtn) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:back];
    
    //标题
    UILabel *titleLbl=[[UILabel alloc]initWithFrame:CGRectMake(fDeviceWidth/2-40, 30, 80, 20)];
    [titleLbl setText:@"抢单详情"];
    [titleLbl setTextColor:[UIColor whiteColor]];
    titleLbl.font=[UIFont systemFontOfSize:18];
    [topView addSubview:titleLbl];
    
    [self.view addSubview:topView];
    
}

-(void)clickleftbtn{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
