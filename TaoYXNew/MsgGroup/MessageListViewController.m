//
//  MessageListViewController.m
//  TaoYXNew
//
//  Created by tianan-apple on 16/1/6.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "MessageListViewController.h"
#import "PublicDefine.h"
#import "DPAPI.h"
#import "MJRefresh.h"
#import "MessageListCellModel.h"
#import "MessageListTableViewCell.h"
#import "MsgSettingViewController.h"
#import "MsgSupplyViewController.h"
#import "MsgExpressViewController.h"
//#import "MesPriceViewController.h"
#import "MsgCommonViewController.h"
#import "MsgPriceViewController.h"

@interface MessageListViewController ()<DPRequestDelegate,MJRefreshBaseViewDelegate>
{
    NSMutableArray *_tableDataSource;
    NSString *_selectedCityName;
    NSString *_selectedCategory;
    NSInteger _pageindex;//显示数据的页码，每次刷新+1
    NSString *_newsAllwaysFlash;//是否强制刷新 1强制刷新 其他先取缓存
    
    MJRefreshFooterView *_footer;//上拉刷新
    MJRefreshHeaderView *_header;//下拉刷新
     NSInteger refreshFlag;
}
@end

@implementation MessageListViewController
@synthesize rightSwipeGestureRecognizer;
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
-(void)viewWillAppear:(BOOL)animated
{
    _pageindex=1;
    [self createRequest];
    //[self loadTableView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setTopTitle:(NSString *)topTitle{
    _topTitle=topTitle;
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
    //back.backgroundColor=[UIColor yellowColor];

    [topView addSubview:back];
    
    //标题
    UILabel *titleLbl=[[UILabel alloc]initWithFrame:CGRectMake(fDeviceWidth/2-40, 30, 80, 20)];
    [titleLbl setText:_topTitle];
    [titleLbl setTextColor:[UIColor whiteColor]];
    titleLbl.font=[UIFont systemFontOfSize:18];
    [topView addSubview:titleLbl];
    
    
    UIImageView *settingImg=[[UIImageView alloc]initWithFrame:CGRectMake(fDeviceWidth-40, 24, 24, 24)];
    settingImg.image=[UIImage imageNamed:@"Setting@2x"];
    [topView addSubview:settingImg];
    //设置按钮
    UIButton *settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [settingBtn setFrame:CGRectMake(fDeviceWidth-70,24 , 70, 30)];
    [settingBtn addTarget:self action:@selector(settingBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [topView addSubview:settingBtn];
    
    [self.view addSubview:topView];
    
    
}

-(void)settingBtnClick{
    
    MsgSettingViewController *componyView=[[MsgSettingViewController alloc]init];
    componyView.hidesBottomBarWhenPushed=YES;
    componyView.navigationItem.hidesBackButton=YES;
    [componyView setTopTitle:@"消息设置"];
    componyView.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:componyView animated:YES];
}
-(void)clickleftbtn{
    [self.navigationController popViewControllerAnimated:YES];
}


static NSString * const OrderListCellId = @"msgListCellId";
-(void)loadTableView{
    self.TableView=[[UITableView alloc]initWithFrame:CGRectMake(0, TopSeachHigh, fDeviceWidth, fDeviceHeight-TopSeachHigh)];
    self.TableView.delegate=self;
    self.TableView.dataSource=self;
    [self.view addSubview:self.TableView];
    
    self.TableView.backgroundColor=collectionBgdColor;
    [self.TableView registerClass:[MessageListTableViewCell class] forCellReuseIdentifier:OrderListCellId];
    
    
    _tableDataSource = [NSMutableArray array];//还要再搞一次，否则_dataSource装不进去数据
    _newsAllwaysFlash=@"0";
    _pageindex=1;
    
    
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
-(NSString*)getDevID{
    return [[UIDevice currentDevice].identifierForVendor UUIDString];
}

-(NSString *)getCityQryCode{
    NSUserDefaults *cityName = [NSUserDefaults standardUserDefaults];
    NSMutableArray * CName = [cityName objectForKey:NSUserDefaultsCityInfo];
    NSString *rtStr=@"";
    for (id obj in CName) {
        rtStr=[NSString stringWithFormat:@"%@%@%@",rtStr,obj,@","];
    }
    if (rtStr.length>1) {
        return [rtStr substringToIndex:rtStr.length-1];
    }
    else
        return @"";
}

-(NSString *)getTypeQryCode{
    NSUserDefaults *cityName = [NSUserDefaults standardUserDefaults];
    NSMutableArray * CName = [cityName objectForKey:NSUserDefaultsTypeInfo];
    NSString *rtStr=@"";
    for (id obj in CName) {
        rtStr=[NSString stringWithFormat:@"%@%@%@",rtStr,obj,@","];
    }
    if (rtStr.length>1) {
        return [rtStr substringToIndex:rtStr.length-1];
    }
    else
        return @"";
}

# pragma 网络请求
- (void)createRequest{
    DPAPI *api = [[DPAPI alloc]init];
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    _selectedCityName=@"pushlist";
    [params setValue:_selectedCityName forKey:@"ut"];
    NSString *qryStr=[self getTypeQryCode];
    if (qryStr.length>0) {
        [params setValue:qryStr forKey:@"type"];
    }
    
     qryStr=[self getCityQryCode];
    if (qryStr.length>0) {
        [params setValue:qryStr forKey:@"area"];
    }
    refreshFlag=1;
    [params setValue:[NSNumber numberWithInteger:15] forKey:@"pageSize"];
    [params setValue:[NSNumber numberWithInteger:_pageindex] forKey:@"pageNo"];
    [api setAllwaysFlash:_newsAllwaysFlash];
    [api requestWithURL:NetUrl params:params delegate:self];}

-(void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result
{
    // NSLog(@"响应：%@",result);
    MessageListCellModel *dm;
    NSArray *datatmp;
    NSDictionary *dict = result;
    dm= [[MessageListCellModel alloc]init];
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
    
    MessageListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:OrderListCellId forIndexPath:indexPath];
    
    // 将数据视图框架模型(该模型中包含了数据模型)赋值给Cell，
    MessageListCellModel *dm=_tableDataSource[indexPath.item];
    [cell showUiSupplyCell:dm];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;//餐企商超
}


-(void)popNavView:(NSString*)idStr{
    MsgSupplyViewController *componyView=[[MsgSupplyViewController alloc]init];
    componyView.hidesBottomBarWhenPushed=YES;
    componyView.navigationItem.hidesBackButton=YES;
    [componyView setMsgId:idStr];
    componyView.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:componyView animated:YES];
}

-(void)popExpressView:(NSString*)idStr{
    MsgExpressViewController *componyView=[[MsgExpressViewController alloc]init];
    componyView.hidesBottomBarWhenPushed=YES;
    componyView.navigationItem.hidesBackButton=YES;
    [componyView setMsgId:idStr];
    componyView.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:componyView animated:YES];
}

-(void)popPriceView:(MarkectDeal *)MD{
    MsgPriceViewController *componyView=[[MsgPriceViewController alloc]init];
    componyView.hidesBottomBarWhenPushed=YES;
    componyView.navigationItem.hidesBackButton=YES;
    [componyView setMarkectData:MD];
    componyView.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:componyView animated:YES];
}

-(void)popCommonView:(NSString*)idStr{
    MsgCommonViewController *componyView=[[MsgCommonViewController alloc]init];
    componyView.hidesBottomBarWhenPushed=YES;
    componyView.navigationItem.hidesBackButton=YES;
    [componyView setMsgId:idStr];
    componyView.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:componyView animated:YES];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MessageListTableViewCell *svc =(MessageListTableViewCell*)[self.TableView cellForRowAtIndexPath:indexPath];
    MessageListCellModel *dm= [svc praseModelWithCell:svc];
    NSLog(@"%ld---%@--%@-cellUrl:",indexPath.item,dm.msgId,dm.msgType);
    if ([dm.msgType isEqualToString:@"3"]) {
        [self popNavView:dm.msgId];
    }
    if ([dm.msgType isEqualToString:@"2"]) {
        [self popExpressView:dm.msgId];
    }
    if ([dm.msgType isEqualToString:@"1"]) {
        MarkectDeal *MD=[svc prasePriceModelWithCell:svc];
        [self popPriceView:MD];
    }
    if ([dm.msgType isEqualToString:@"0"]) {
        [self popCommonView:dm.msgId];
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
        //[_tableDataSource removeAllObjects];
        DPAPI *api = [[DPAPI alloc]init];
        NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
        _selectedCityName=@"pushlist";
        NSString *qryStr=[self getTypeQryCode];
        if (qryStr.length>0) {
            [params setValue:qryStr forKey:@"type"];
        }
        
        qryStr=[self getCityQryCode];
        if (qryStr.length>0) {
            [params setValue:qryStr forKey:@"area"];
        }
        
        [params setValue:_selectedCityName forKey:@"ut"];
        //[params setValue:[self getDevID] forKey:@"imei"];
        [params setValue:[NSNumber numberWithInteger:15] forKey:@"pageSize"];
        [params setValue:[NSNumber numberWithInteger:_pageindex] forKey:@"pageNo"];
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
        _selectedCityName=@"pushlist";
        _pageindex+=1;
        NSString *qryStr=[self getTypeQryCode];
        if (qryStr.length>0) {
            [params setValue:qryStr forKey:@"type"];
        }
        
        qryStr=[self getCityQryCode];
        if (qryStr.length>0) {
            [params setValue:qryStr forKey:@"area"];
        }
        
        [params setValue:_selectedCityName forKey:@"ut"];
        //[params setValue:[self getDevID] forKey:@"imei"];
        [params setValue:[NSNumber numberWithInteger:15] forKey:@"pageSize"];
        [params setValue:[NSNumber numberWithInteger:_pageindex] forKey:@"pageNo"];
        [api setAllwaysFlash:_newsAllwaysFlash];
        [api requestWithURL:NetUrl params:params delegate:self];
        
        // 2.2秒后刷新表格UI
        [self performSelector:@selector(doneWithView:) withObject:refreshView afterDelay:2.0];
    }
}

-(void)dealloc
{
    [_header removeFromSuperview];
    [_footer removeFromSuperview];
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
