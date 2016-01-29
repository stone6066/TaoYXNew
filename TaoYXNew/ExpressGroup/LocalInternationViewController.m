//
//  LocalInternationViewController.m
//  TaoYXNew
//
//  Created by tianan-apple on 15/12/16.
//  Copyright © 2015年 tianan-apple. All rights reserved.
//

#import "LocalInternationViewController.h"
#import "PublicDefine.h"
#import "DPAPI.h"
#import "MJRefresh.h"
#import "NavTableViewCell.h"
#import "NavModel.h"

#import "LocalInternationTableViewCell.h"
#import "InternationExpDeal.h"

@interface LocalInternationViewController ()<DPRequestDelegate,MJRefreshBaseViewDelegate>
{
    NSMutableArray *_tableDataSource;
    NSString *_selectedCityName;
    NSString *_selectedCategory;
    NSInteger _pageindex;//显示数据的页码，每次刷新+1
    NSString *_newsAllwaysFlash;//是否强制刷新 1强制刷新 其他先取缓存
    NSInteger refreshFlag;
    MJRefreshFooterView *_footer;//上拉刷新
    MJRefreshHeaderView *_header;//下拉刷新
}

@end

@implementation LocalInternationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    refreshFlag=0;
    [self loadTableView];
    [self loadBackToTopBtn];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

static NSString * const InternationCellId = @"internationCellId";
-(void)loadTableView{
    self.TableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, fDeviceHeight-NavTopHight)];
    self.TableView.delegate=self;
    self.TableView.dataSource=self;
    [self.view addSubview:self.TableView];
    
    self.TableView.backgroundColor=collectionBgdColor;
    [self.TableView registerClass:[LocalInternationTableViewCell class] forCellReuseIdentifier:InternationCellId];
    
    
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


# pragma 网络请求
- (void)createRequest{
    DPAPI *api = [[DPAPI alloc]init];
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    _selectedCityName=@"loginternation";
    [params setValue:_selectedCityName forKey:@"ut"];
    [params setValue:[NSNumber numberWithInteger:15] forKey:@"pageSize"];
    [params setValue:[NSNumber numberWithInteger:_pageindex] forKey:@"pageNo"];
    [params setValue:@"0" forKey:@"logInfoType"];
    [api setAllwaysFlash:_newsAllwaysFlash];
    [api requestWithURL:NetUrl params:params delegate:self];
}

-(void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result
{
    // NSLog(@"响应：%@",result);
    InternationExpDeal *dm;
    NSArray *datatmp;
    NSDictionary *dict = result;
    dm= [[InternationExpDeal alloc]init];
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
    
    LocalInternationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:InternationCellId forIndexPath:indexPath];
    
    // 将数据视图框架模型(该模型中包含了数据模型)赋值给Cell，
    InternationExpDeal *dm=_tableDataSource[indexPath.item];
    [cell showUiSupplyCell:dm];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;//餐企商超
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    LocalInternationTableViewCell *svc =(LocalInternationTableViewCell*)[self.TableView cellForRowAtIndexPath:indexPath];
//    dealModel *dm= [svc praseModelWithCell:svc];
//    NSLog(@"%ld---%@---cellUrl:",indexPath.item,dm.deal_url);
//    
//    ShortCutViewController *shortCutView=[[ShortCutViewController alloc]init];
//    shortCutView.hidesBottomBarWhenPushed=YES;
//    shortCutView.navigationItem.hidesBackButton=YES;
//    
//    [shortCutView setWeburl:dm.deal_url];
//    [shortCutView setTopTitle:@"本地国际"];
//    [self.navigationController pushViewController:shortCutView animated:YES];
    
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
    [self.TableView reloadData];
    
    // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
    [refreshView endRefreshing];
    
}

-(void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    //下拉刷新第一页MJRefreshHeaderView MJRefreshFooterView
    NSString *myClass=refreshView.description;
    NSRange myRang=[myClass rangeOfString:@"MJRefreshHeaderView"];
    
    if (myRang.length>0) {//下拉强制刷新
        refreshFlag=1;
        _pageindex=1;
        _newsAllwaysFlash=@"1";//强制刷新
        DPAPI *api = [[DPAPI alloc]init];
        NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
        _selectedCityName=@"loginternation";
        [params setValue:_selectedCityName forKey:@"ut"];
        [params setValue:[NSNumber numberWithInteger:15] forKey:@"pageSize"];
        [params setValue:[NSNumber numberWithInteger:_pageindex] forKey:@"pageNo"];
        [params setValue:@"0" forKey:@"logInfoType"];
        [api setAllwaysFlash:_newsAllwaysFlash];
        [api requestWithURL:NetUrl params:params delegate:self];
        // 2.2秒后刷新表格UI
        [self performSelector:@selector(doneWithView:) withObject:refreshView afterDelay:2.0];
    }
    else
    {
        refreshFlag=0;
        _pageindex+=1;
        DPAPI *api = [[DPAPI alloc]init];
        NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
        _selectedCityName=@"loginternation";
        [params setValue:_selectedCityName forKey:@"ut"];
        [params setValue:[NSNumber numberWithInteger:15] forKey:@"pageSize"];
        [params setValue:[NSNumber numberWithInteger:_pageindex] forKey:@"pageNo"];
        [params setValue:@"0" forKey:@"logInfoType"];
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
