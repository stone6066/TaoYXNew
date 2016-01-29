//
//  MySupplyOrderViewController.m
//  TaoYXNew
//
//  Created by tianan-apple on 16/1/20.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "MySupplyOrderViewController.h"
#import "PublicDefine.h"
#import "DPAPI.h"
#import "MySupplyOrderDeal.h"
#import "MJRefresh.h"
#import "stdPubFunc.h"
#import "MySupplyOrderTableViewCell.h"
#import "GrapListViewController.h"

@interface MySupplyOrderViewController ()<DPRequestDelegate,MJRefreshBaseViewDelegate>
{
    NSMutableArray *_tableDataSource;
    NSInteger _pageindex;//显示数据的页码，每次刷新+1
    NSString *_newsAllwaysFlash;//是否强制刷新 1强制刷新 其他先取缓存
    NSInteger refreshFlag;
    MJRefreshFooterView *_footer;//上拉刷新
    MJRefreshHeaderView *_header;//下拉刷新
    NSInteger selectedTableIndex;
}


@end

@implementation MySupplyOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadNavTopView];
    [self loadTableView];
    [self stdRightGesture];
    // Do any additional setup after loading the view.
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

- (void)loadNavTopView
{
    UIView *topSearch=[[UIView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, TopSeachHigh)];
    topSearch.backgroundColor=topSearchBgdColor;
    
    UILabel *viewTitle=[[UILabel alloc]initWithFrame:CGRectMake(fDeviceWidth/2-60, -10, 120, 100)];
    viewTitle.text=@"我发布的抢单报价";
    [viewTitle setTextColor:[UIColor whiteColor]];
    [viewTitle setFont:[UIFont systemFontOfSize:15]];
    [topSearch addSubview:viewTitle];
    
    UIImageView *backimg=[[UIImageView alloc]initWithFrame:CGRectMake(8, 24, 60, 24)];
    backimg.image=[UIImage imageNamed:@"bar_back"];
    [topSearch addSubview:backimg];
    //返回按钮
    UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
    [back setFrame:CGRectMake(0, 22, 70, 42)];
    [back addTarget:self action:@selector(clickleftbtn) forControlEvents:UIControlEventTouchUpInside];
    [topSearch addSubview:back];
    
    [self.view addSubview:topSearch];
}

-(void)clickleftbtn{
    [self.navigationController popViewControllerAnimated:YES];
}

# pragma 网络请求
- (void)createRequest{
    DPAPI *api = [[DPAPI alloc]init];
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setValue:@"msupplyorderlist" forKey:@"ut"];
    [params setValue:[stdPubFunc readUserUid] forKey:@"pubId"];
    [params setValue:[NSNumber numberWithInteger:15] forKey:@"pageSize"];
    [params setValue:[NSNumber numberWithInteger:_pageindex] forKey:@"pageNo"];
    [api setAllwaysFlash:@"1"];
    [api requestWithURL:NetUrl params:params delegate:self];
}

-(void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result
{
    // NSLog(@"我的报价响应：%@",result);
    MySupplyOrderDeal *dm;
    NSArray *datatmp;
    NSDictionary *dict = result;
    dm= [[MySupplyOrderDeal alloc]init];
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

-(void)dealloc
{
    [_header removeFromSuperview];
    [_footer removeFromSuperview];
}

-(void)loadTableView{
    self.TableView=[[UITableView alloc]initWithFrame:CGRectMake(0, TopSeachHigh, fDeviceWidth, fDeviceHeight-TopSeachHigh)];
    self.TableView.delegate=self;
    self.TableView.dataSource=self;
    [self.view addSubview:self.TableView];
    
    self.TableView.backgroundColor=collectionBgdColor;
    [self.TableView registerClass:[MySupplyOrderTableViewCell class] forCellReuseIdentifier:@"myCellID"];
    
    
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

#pragma table delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _tableDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MySupplyOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCellID" forIndexPath:indexPath];
    
    // 将数据视图框架模型(该模型中包含了数据模型)赋值给Cell，
    MySupplyOrderDeal *dm=_tableDataSource[indexPath.item];
    [cell showUiSupplyCell:dm];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130;//餐企商超
}
-(void)popCommonView:(NSString*)idStr{
    GrapListViewController *componyView=[[GrapListViewController alloc]init];
    [componyView setShowType:1];
    [componyView setDetailId:idStr];
    componyView.hidesBottomBarWhenPushed=YES;
    componyView.navigationItem.hidesBackButton=YES;
    
    componyView.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:componyView animated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MySupplyOrderTableViewCell *svc =(MySupplyOrderTableViewCell*)[self.TableView cellForRowAtIndexPath:indexPath];
    [self popCommonView:svc.supplyOrderId];
    
}

//按钮显示的内容
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return @"删除";
    
}
//这里就是点击删除执行的方法
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    selectedTableIndex=indexPath.row;
    MySupplyOrderTableViewCell *svc =(MySupplyOrderTableViewCell*)[self.TableView cellForRowAtIndexPath:indexPath];
    [self createDelCarRequest:svc.supplyOrderId];
}


# pragma 网络请求
- (void)createDelCarRequest:(NSString*)delId{
    DPAPI *api = [[DPAPI alloc]init];
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setValue:@"mdelsupplyorder" forKey:@"ut"];
    [params setValue:delId forKey:@"id"];
    [api setAllwaysFlash:@"1"];
    NSString *myurl=NetUrl;
    [api loginRequestWithURL:myurl params:params delegate:self];
}

-(void)loginrequest:(DPRequest *)request didFinishLoadingWithResult:(id)result{
    NSDictionary *dict=result;
    //NSLog(@"删除返回：%@",dict);
    NSString *logstr=[dict objectForKey:@"msg"];
    if ([logstr isEqualToString:@"ok"]) {//删除成功成功
        [_tableDataSource removeObjectAtIndex:selectedTableIndex];
        [self.TableView reloadData];
        
    }
    
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
        
        DPAPI *api = [[DPAPI alloc]init];
        NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
        
        [params setValue:@"msupplyorderlist" forKey:@"ut"];
        [params setValue:[stdPubFunc readUserUid] forKey:@"pubId"];
        [params setValue:[NSNumber numberWithInteger:_pageindex] forKey:@"pageNo"];
        [params setValue:[NSNumber numberWithInteger:15] forKey:@"pageSize"];
        [api setAllwaysFlash:_newsAllwaysFlash];
        [api requestWithURL:NetUrl params:params delegate:self];
        
        // 2.2秒后刷新表格UI
        [self performSelector:@selector(doneWithView:) withObject:refreshView afterDelay:2.0];
    }
    else
    {
        DPAPI *api = [[DPAPI alloc]init];
        NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
        
        _pageindex+=1;
        refreshFlag=0;
        [params setValue:@"msupplyorderlist" forKey:@"ut"];
        [params setValue:[stdPubFunc readUserUid] forKey:@"pubId"];
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

@end
