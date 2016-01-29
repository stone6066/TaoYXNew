//
//  MarketPriceViewController.m
//  TaoYXNew
//
//  Created by tianan-apple on 15/12/17.
//  Copyright © 2015年 tianan-apple. All rights reserved.
//

#import "MarketPriceViewController.h"
#import "PublicDefine.h"
#import "DPAPI.h"
#import "MJRefresh.h"
#import "NavTableViewCell.h"
#import "MarkectDeal.h"
#import "MarketPriceTableViewCell.h"
#import "PopViewController.h"
#import "DetailMarketViewController.h"
#import "TimeSelectViewController.h"
@interface MarketPriceViewController ()<DPRequestDelegate,MJRefreshBaseViewDelegate>
{
    UIScrollView *topNavScrollView;
    NSMutableArray *lblArr;
    NSMutableArray *viewArr;
    NSMutableArray *btnArr;
    
    NSMutableArray *_tableDataSource;
    NSString *_selectedCityName;
    NSString *_selectedCategory;
    NSInteger _pageindex;//显示数据的页码，每次刷新+1
    NSString *_newsAllwaysFlash;//是否强制刷新 1强制刷新 其他先取缓存
    
    MJRefreshFooterView *_footer;//上拉刷新
    MJRefreshHeaderView *_header;//下拉刷新
    NSInteger refreshFlag;//下拉刷新，1的时候清空数据
}

@end

@implementation MarketPriceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    refreshFlag=0;
    _TitleArr=[[NSMutableArray alloc]initWithObjects:@"区域",@"时间",nil];
    _qryCode=[[NSMutableArray alloc]initWithObjects:@"0",@"0",@"0",nil];
    lblArr=[[NSMutableArray alloc]init];
    viewArr=[[NSMutableArray alloc]init];
    btnArr=[[NSMutableArray alloc]init];
    _btnIndex=0;
    [self loadTopNavView:0 buttonArr:_TitleArr];
    [self loadTableView];
    [self loadBackToTopBtn];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSString*)getMyCityCode:(NSString *)cityName getType:(NSInteger)datatype
{
    NSString *file;
    if (0==datatype) {
        file = [[NSBundle mainBundle]pathForResource:@"cities.plist" ofType:nil];
    }
    else
        file = [[NSBundle mainBundle]pathForResource:@"categories.plist" ofType:nil];
    //加载plist为数组
    NSArray *plistArray = [NSArray arrayWithContentsOfFile:file];
    NSDictionary *citydict=[[NSDictionary alloc]init];
    NSString *city_code=nil;
    for (NSDictionary *dict in plistArray)
    {
        if (0==datatype) {
            citydict=[dict objectForKey:@"citycode"];
        }
        else
            citydict=[dict objectForKey:@"typecode"];
        city_code=[citydict objectForKey:cityName];
        if (city_code.length>0) {
            return city_code;
        }
    }
    
    return @"0";
}
-(void)clickleftbtn{
    [self.navigationController popViewControllerAnimated:YES];
}
//顶部导航条
-(void)loadTopNavView:(NSInteger)selectIndex buttonArr:(NSArray*)buttonList{
    if (topNavScrollView == nil)
    {
        topNavScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, fDeviceWidth, 30)];
        topNavScrollView.showsHorizontalScrollIndicator = NO;
    }
    topNavScrollView.backgroundColor=[UIColor whiteColor];
    UIView *topView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, 30)];
    topView.backgroundColor=topSearchBgdColor;
    
    
    
    //顶部按钮
    float btnWidth=0;
    float scrollWidth=0;
    //float selLineWidth=0;
    NSString *txtTmp=nil;
    for (int i=0; i<buttonList.count; i++) {
        txtTmp=[buttonList objectAtIndex:i];
       // btnWidth=txtTmp.length*22.5;
        if (txtTmp.length==1) {
            btnWidth=28;
        }
        else
            btnWidth=txtTmp.length*22.5;
        UIButton *navBtn=[[UIButton alloc]initWithFrame:CGRectMake(scrollWidth, 0, btnWidth+20, 30)];
        UILabel *navLbl=[[UILabel alloc]initWithFrame:CGRectMake(scrollWidth+5, 0, btnWidth, 30)];
        UIImageView *oneImg=[[UIImageView alloc]initWithFrame:CGRectMake(scrollWidth+btnWidth-5, 5, 15, 17)];
        oneImg.image=[UIImage imageNamed:@"sanjiao"];
        btnWidth+=20;
        scrollWidth+=btnWidth;
        navLbl.text=txtTmp;
        
        if (i==selectIndex)
        {
            [navLbl setTextColor:[UIColor redColor]];
        }
        else
        {
            [navLbl setTextColor:[UIColor lightGrayColor]];
        }
        [topNavScrollView addSubview:navLbl];
        [topNavScrollView addSubview:navBtn];
        [topNavScrollView addSubview:oneImg];
        navBtn.tag=i;
        [lblArr addObject:navLbl];
        [viewArr addObject:oneImg];
        [btnArr addObject:navBtn];
        
        [navBtn addTarget:self action:@selector(typeClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    [topNavScrollView setContentSize:CGSizeMake(fDeviceWidth, 30)];
    [topView addSubview:topNavScrollView];
    [self.view addSubview:topView];
    
}
-(void)typeClick:(UIButton*)sender{
    //NSLog(@"%ld",sender.tag);
    for (int i=0; i<_TitleArr.count; i++)
    {
        UILabel *lbl=(UILabel *)lblArr[i];
        
        if (i==sender.tag) {
            [lbl setTextColor:[UIColor redColor]];
            
        }
        else
        {
            [lbl setTextColor:[UIColor lightGrayColor]];
            
        }
    }
    _btnIndex=sender.tag;
    switch (sender.tag) {
        case 0://区域
            [self createPopver:_btnIndex];
            break;
        case 1://时间
            //NSLog(@"%@",[self getDayOfToday:-2]);
            [self timeListSelect];
            break;
        default:
            break;
    }
    
}

#pragma mark -时间选择完毕后返回
-(void)timeListSelect{
    TimeSelectViewController *timeView=[[TimeSelectViewController alloc]init];
    timeView.hidesBottomBarWhenPushed=YES;
    timeView.navigationItem.hidesBackButton=YES;
    //[timeView setCityType:_VersionType];
    timeView.TimeChangeBlock = ^(TimeSelectViewController *aqrvc,NSString *qrString){
        [aqrvc dismissViewControllerAnimated:NO completion:nil];
        [_TitleArr replaceObjectAtIndex:_btnIndex withObject:qrString];//导航条第二个按钮的laltxt替换成新的
        [_qryCode replaceObjectAtIndex:_btnIndex withObject:qrString];
        [self setBtnValue:_btnIndex];
        refreshFlag=1;
        [self createRequest];
        
        
    };
    timeView.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:timeView animated:YES];
}

#pragma mark - 区域选择完毕后返回
- (void)createPopver:(NSInteger)clickIndex{
    //    PopViewController *pvc = [[PopViewController alloc]init];
    //    [self.navigationController pushViewController:pvc animated:YES];
    
    PopViewController *pvc = [[PopViewController alloc]init];
    pvc.hidesBottomBarWhenPushed=YES;
    pvc.navigationItem.hidesBackButton=YES;
    [pvc setDataType:_btnIndex];
    pvc.TypeChangeBlock = ^(PopViewController *aqrvc,NSString *qrString,NSString *idString,NSInteger qtType){
        [aqrvc dismissViewControllerAnimated:NO completion:nil];
        [_TitleArr replaceObjectAtIndex:_btnIndex withObject:qrString];//导航条第二个按钮的laltxt替换成新的
        [_qryCode replaceObjectAtIndex:_btnIndex withObject:[self getMyCityCode:qrString getType:_btnIndex]];
        [_qryCode replaceObjectAtIndex:2 withObject:idString];
        [self setBtnValue:_btnIndex];
        [_tableDataSource removeAllObjects];
        [self createRequest];
        
    };
    pvc.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:pvc animated:YES];
}
//根据字符长度重新画顶部导航
-(void)setBtnValue:(NSInteger)index{
    float btnWidth=0;
    float scrollWidth=0;
    
    for (int i=0; i<_TitleArr.count; i++)
    {
        UILabel *lbl=(UILabel *)lblArr[i];
        UIImageView *img=(UIImageView *)viewArr[i];
        UIButton *btn=(UIButton *)btnArr[i];
        NSString *strtmp=_TitleArr[i];
        //btnWidth=strtmp.length*22.5;
        if (strtmp.length==1) {
            btnWidth=28;
        }
        else
            btnWidth=strtmp.length*22.5;
        
        [lbl setFrame:CGRectMake(scrollWidth+5, 0, btnWidth, 30)];
        [img setFrame:CGRectMake(scrollWidth+btnWidth-5, 5, 15, 17)];
        [btn setFrame:CGRectMake(scrollWidth, 0, btnWidth+20, 30)];
        btnWidth+=20;
        scrollWidth+=btnWidth;
        [lbl setText:strtmp];
        
        if (i==index) {
            [lbl setTextColor:[UIColor redColor]];
        }
        else
        {
            [lbl setTextColor:[UIColor lightGrayColor]];
        }
    }
}

#pragma mark -loadTableView

static NSString * const MarketCellId = @"marketTableCell";
-(void)loadTableView{
    self.TableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 30, fDeviceWidth, fDeviceHeight-NavTopHight-40)];
    self.TableView.delegate=self;
    self.TableView.dataSource=self;
    [self.view addSubview:self.TableView];
    
    self.TableView.backgroundColor=collectionBgdColor;
    [self.TableView registerClass:[MarketPriceTableViewCell class] forCellReuseIdentifier:MarketCellId];
    
    
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
    _selectedCityName=@"priceinfolist";
    [params setValue:_selectedCityName forKey:@"ut"];
    [params setValue:@"0" forKey:@"priceInfoType"];
    [params setValue:[NSNumber numberWithInteger:15] forKey:@"pageSize"];
    [params setValue:[NSNumber numberWithInteger:_pageindex] forKey:@"pageNo"];
    if (_qryCode.count>2) {
        if (![_qryCode[0] isEqualToString:@"0"])
            [params setValue:_qryCode[0] forKey:@"areaId"];
        if (![_qryCode[1] isEqualToString:@"0"])
            [params setValue:_qryCode[1] forKey:@"createTime"];
        if (![_qryCode[2] isEqualToString:@"0"])
            [params setValue:_qryCode[2] forKey:@"level"];
        }
    [api setAllwaysFlash:_newsAllwaysFlash];
    [api requestWithURL:NetUrl params:params delegate:self];
}

-(void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result
{
   //  NSLog(@"响应：%@",result);
    MarkectDeal *dm;
    NSArray *datatmp;
    NSDictionary *dict = result;
    dm= [[MarkectDeal alloc]init];
    datatmp=[dm asignModelWithDict:dict];
    if (refreshFlag==1) {
        [_tableDataSource removeAllObjects];
    }
    [_tableDataSource addObjectsFromArray:datatmp];
    //if (_tableDataSource.count>0) {
    [self.TableView reloadData];
    //}
    
    
}
-(void)request:(DPRequest *)request didFailWithError:(NSError *)error
{
    NSLog(@"报错了：%@",error);
}

#pragma mark table delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _tableDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MarketPriceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MarketCellId forIndexPath:indexPath];
//    
//    // 将数据视图框架模型(该模型中包含了数据模型)赋值给Cell，
    MarkectDeal *dm=_tableDataSource[indexPath.item];
    [cell showUiSupplyCell:dm];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;//餐企商超
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MarketPriceTableViewCell *svc =(MarketPriceTableViewCell*)[self.TableView cellForRowAtIndexPath:indexPath];
    MarkectDeal *dm= [svc praseModelWithCell:svc];
    DetailMarketViewController *shortCutView=[[DetailMarketViewController alloc]init];
    shortCutView.hidesBottomBarWhenPushed=YES;
    shortCutView.navigationItem.hidesBackButton=YES;
    
    [shortCutView setMarkectData:dm];
    shortCutView.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:shortCutView animated:YES];
    
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
        _selectedCityName=@"priceinfolist";
        [params setValue:_selectedCityName forKey:@"ut"];
        [params setValue:@"0" forKey:@"priceInfoType"];
        [params setValue:[NSNumber numberWithInteger:15] forKey:@"pageSize"];
        [params setValue:[NSNumber numberWithInteger:_pageindex] forKey:@"pageNo"];
        if (_qryCode.count>2) {
            if (![_qryCode[0] isEqualToString:@"0"])
                [params setValue:_qryCode[0] forKey:@"areaId"];
            if (![_qryCode[1] isEqualToString:@"0"])
                [params setValue:_qryCode[1] forKey:@"createTime"];
            if (![_qryCode[2] isEqualToString:@"0"])
                [params setValue:_qryCode[2] forKey:@"level"];
        }
        [api setAllwaysFlash:_newsAllwaysFlash];
        [api requestWithURL:NetUrl params:params delegate:self];
        // 2.2秒后刷新表格UI
        [self performSelector:@selector(doneWithView:) withObject:refreshView afterDelay:2.0];
    }
    else
    {
        _pageindex+=1;
        refreshFlag=0;
        DPAPI *api = [[DPAPI alloc]init];
        NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
        _selectedCityName=@"priceinfolist";
        [params setValue:_selectedCityName forKey:@"ut"];
        [params setValue:@"0" forKey:@"priceInfoType"];
        [params setValue:[NSNumber numberWithInteger:15] forKey:@"pageSize"];
        [params setValue:[NSNumber numberWithInteger:_pageindex] forKey:@"pageNo"];
        if (_qryCode.count>2) {
            if (![_qryCode[0] isEqualToString:@"0"])
                [params setValue:_qryCode[0] forKey:@"areaId"];
            if (![_qryCode[1] isEqualToString:@"0"])
                [params setValue:_qryCode[1] forKey:@"createTime"];
            if (![_qryCode[2] isEqualToString:@"0"])
                [params setValue:_qryCode[2] forKey:@"level"];
        }
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
