//
//  PlaceTypeViewController.m
//  TaoYXNew
//
//  Created by tianan-apple on 15/12/17.
//  Copyright © 2015年 tianan-apple. All rights reserved.
//

#import "PlaceTypeViewController.h"
#import "PublicDefine.h"
#import "DPAPI.h"
#import "MJRefresh.h"
#import "NavTableViewCell.h"
#import "NavModel.h"
#import "PlaceTypeTableViewCell.h"

#import "PopViewController.h"
#import "CategoriyModel.h"
#import "TimeSelectViewController.h"
#import "DetailPriceViewController.h"
#import "PricePlaceModel.h"
#import "CategoriyModel.h"

@interface PlaceTypeViewController ()<DPRequestDelegate,MJRefreshBaseViewDelegate>
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

@implementation PlaceTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    refreshFlag=0;
    lblArr=[[NSMutableArray alloc]init];
    viewArr=[[NSMutableArray alloc]init];
    btnArr=[[NSMutableArray alloc]init];
     _TitleArr=[[NSMutableArray alloc]initWithObjects:@"区域", @"类别",@"时间",nil];
    _btnIndex=0;
    _qryCode=[[NSMutableArray alloc]initWithObjects:@"0", @"0",@"0",@"0",@"0",nil];
    /*
     _qryCode[0]: areaId;
     _qryCode[1]: brandId;
     _qryCode[2]: createTime;
     _qryCode[3]: typeId;
     _qryCode[4]: level=2;如选择银川->全部
     */
    [self loadTopNavView:0 buttonArr:_TitleArr];
    [self loadTableView];
    [self loadBackToTopBtn];
    
    //self.view.backgroundColor=[UIColor blueColor];
    // Do any additional setup after loading the view.
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    DPAPI *api = [[DPAPI alloc]init];
    switch (sender.tag) {
        case 0://区域
            [self createPopver:_btnIndex];
            break;
        case 1://类别
            //[self createPopver:1];
           
            if ([api GetNetState]==0) {
                [self createPopver:1];//无网络，直接读取缓存
            }
            else
                [self typeCreateRequest];
            break;
        case 2://时间
            //NSLog(@"%@",[self getDayOfToday:-2]);
            [self timeListSelect];
            break;
        default:
            break;
    }
    
}
-(void)timeListSelect{
    TimeSelectViewController *timeView=[[TimeSelectViewController alloc]init];
    timeView.hidesBottomBarWhenPushed=YES;
    timeView.navigationItem.hidesBackButton=YES;
    //[timeView setCityType:_VersionType];
    timeView.TimeChangeBlock = ^(TimeSelectViewController *aqrvc,NSString *qrString){
        [aqrvc dismissViewControllerAnimated:NO completion:nil];
        [_TitleArr replaceObjectAtIndex:_btnIndex withObject:qrString];//导航条第二个按钮的laltxt替换成新的
        if ([qrString isEqualToString:@"全部"]) {
            [_qryCode replaceObjectAtIndex:_btnIndex withObject:@"0"];
        }
        else
        [_qryCode replaceObjectAtIndex:_btnIndex withObject:qrString];
        [self setBtnValue:_btnIndex];
        refreshFlag=1;
        [self createRequest];

        
    };
    timeView.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:timeView animated:YES];
}


-(NSString *)getCurrTime{
    NSDateFormatter *formater=[[NSDateFormatter alloc]init];
    [formater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *dd=[NSDate date];
    NSString *datetime=[formater stringFromDate:dd];
    return datetime;
}



#pragma mark - 第一个下拉菜单
- (void)createPopver:(NSInteger)clickIndex{
        PopViewController *pvc = [[PopViewController alloc]init];
    pvc.hidesBottomBarWhenPushed=YES;
    pvc.navigationItem.hidesBackButton=YES;
    [pvc setDataType:_btnIndex];
    pvc.TypeChangeBlock = ^(PopViewController *aqrvc,NSString *qrString,NSString *idString,NSInteger qtType){
        [aqrvc dismissViewControllerAnimated:NO completion:nil];
        [_TitleArr replaceObjectAtIndex:_btnIndex withObject:qrString];//导航条第二个按钮的laltxt替换成新的
        if (_btnIndex==1) {
            if (1==qtType) {//按类别typeId查询
                [_qryCode replaceObjectAtIndex:1 withObject:@"0"];
                [_qryCode replaceObjectAtIndex:3 withObject:idString];
            }
            else//按类别brandId查询
            {
                [_qryCode replaceObjectAtIndex:1 withObject:idString];
                [_qryCode replaceObjectAtIndex:3 withObject:@"0"];
            }
        }
        else if (_btnIndex==0)//区域
        {
            [_qryCode replaceObjectAtIndex:_btnIndex withObject:[self getMyCityCode:qrString getType:_btnIndex]];
            [_qryCode replaceObjectAtIndex:4 withObject:idString];
        }
        else
        {
            [_qryCode replaceObjectAtIndex:_btnIndex withObject:[self getMyCityCode:qrString getType:_btnIndex]];
        }
        [self setBtnValue:_btnIndex];
        refreshFlag=1;
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

//- (void)categoryChange:(NSNotification*)noti{
//    CategoriyModel *md = (CategoriyModel*)noti.userInfo[@"categoryModel"];
//    NSLog(@"左表：%@",md.name);
//    //发送网络请求
//    [self createRequest:@"银川"];
//}
//
//- (void)subCategoryChange:(NSNotification*)noti{
//    CategoriyModel *md = (CategoriyModel*)noti.userInfo[@"categoryModel"];
//    NSString *selectedSubName = noti.userInfo[@"subCategoryName"];
//    NSLog(@"表：%@",md.name);
//    if (!md.subcategories.count) {
//        _selectedCategory = md.name;
//    }else{
//        if ([selectedSubName isEqualToString:@"全部"]) {
//            _selectedCategory = md.name;
//        }else{
//            _selectedCategory = selectedSubName;
//        }
//    }
//    
//    //发送网络请求
//    [self createRequest:@"海口"];
//}
//
//- (void)cityChange:(NSNotification*)noti{
//    _selectedCityName = noti.userInfo[@"cityName"];
//    
//    //发送网络请求
//    [self createRequest:@"宜宾"];
//}
#pragma loadTableView

static NSString * const PlaceTypeCellId = @"placeTableCell";
-(void)loadTableView{
    self.TableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 30, fDeviceWidth, fDeviceHeight-NavTopHight-40)];
    self.TableView.delegate=self;
    self.TableView.dataSource=self;
    [self.view addSubview:self.TableView];
    
    self.TableView.backgroundColor=collectionBgdColor;
    [self.TableView registerClass:[PlaceTypeTableViewCell class] forCellReuseIdentifier:PlaceTypeCellId];
    
    
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
//下载分类数据
- (void)typeCreateRequest{
    DPAPI *api = [[DPAPI alloc]init];
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    _selectedCityName=@"typeandbrand";
    [params setValue:_selectedCityName forKey:@"ut"];
    
    [api setAllwaysFlash:@"1"];
    
    [api typeRequestWithURL: NetUrl params:params delegate:self];
}

-(void)typerequest:(DPRequest *)request didFinishLoadingWithResult:(id)result
{
    NSDictionary *dict = result;
    
    [self saveTypeInfo:dict];
    [self createPopver:1];
   
}
-(NSDictionary*)readTypeInfo{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSDictionary * NSUserDefaults = [user objectForKey:NSUserTypeData];
    return NSUserDefaults;
}

-(void)saveTypeInfo:(NSDictionary*)myData{
    
     if(![[myData objectForKey:@"data"] isEqual:[NSNull null]])
     {
         NSDictionary *dataTmp=[myData objectForKey:@"data"];
         NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
         [user setObject:dataTmp forKey:NSUserTypeData];
         [user synchronize];
     }
}
- (void)createRequest{
    DPAPI *api = [[DPAPI alloc]init];
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    _selectedCityName=@"pricelist";
    [params setValue:_selectedCityName forKey:@"ut"];
    [params setValue:[NSNumber numberWithInteger:15] forKey:@"pageSize"];
    [params setValue:[NSNumber numberWithInteger:_pageindex] forKey:@"pageNo"];
    //NSLog(@"_qryCode:%@",_qryCode);
    if (_qryCode.count>4) {
        if (![_qryCode[0] isEqualToString:@"0"])
            [params setValue:_qryCode[0] forKey:@"areaId"];//区域
        if (![_qryCode[1] isEqualToString:@"0"])
            [params setValue:_qryCode[1] forKey:@"brandId"];//类别
        if (![_qryCode[2] isEqualToString:@"0"])
            [params setValue:_qryCode[2] forKey:@"createTime"];//时间
        if (![_qryCode[3] isEqualToString:@"0"])
            [params setValue:_qryCode[3] forKey:@"typeId"];//类别typeId
        if (![_qryCode[4] isEqualToString:@"0"])
            [params setValue:_qryCode[4] forKey:@"level"];//区域level
    }
    [api setAllwaysFlash:_newsAllwaysFlash];
    [api requestWithURL:NetUrl params:params delegate:self];
}

-(void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result
{
    // NSLog(@"响应：%@",result);
    PricePlaceModel *dm;
    NSArray *datatmp;
    NSDictionary *dict = result;
    dm= [[PricePlaceModel alloc]init];
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

#pragma mark table delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _tableDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    PlaceTypeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PlaceTypeCellId forIndexPath:indexPath];
    
    // 将数据视图框架模型(该模型中包含了数据模型)赋值给Cell，
    PricePlaceModel *dm=_tableDataSource[indexPath.item];
    [cell showUiSupplyCell:dm];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;//餐企商超
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PlaceTypeTableViewCell *svc =(PlaceTypeTableViewCell*)[self.TableView cellForRowAtIndexPath:indexPath];
    PricePlaceModel *dm=[svc praseModelWithCell:svc];
    DetailPriceViewController *shortCutView=[[DetailPriceViewController alloc]init];
    shortCutView.hidesBottomBarWhenPushed=YES;
    shortCutView.navigationItem.hidesBackButton=YES;
    [shortCutView setMsgId:dm.priceId];
    //[shortCutView setPriceData:dm];
     shortCutView.view.backgroundColor = [UIColor whiteColor];
    //[shortCutView setTopTitle:@"价格行情"];
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
        _selectedCityName=@"pricelist";
        [params setValue:_selectedCityName forKey:@"ut"];
        [params setValue:[NSNumber numberWithInteger:15] forKey:@"pageSize"];
        [params setValue:[NSNumber numberWithInteger:_pageindex] forKey:@"pageNo"];
        if (_qryCode.count>4) {
            if (![_qryCode[0] isEqualToString:@"0"])
                [params setValue:_qryCode[0] forKey:@"areaId"];//区域
            if (![_qryCode[1] isEqualToString:@"0"])
                [params setValue:_qryCode[1] forKey:@"brandId"];//类别brandId
            if (![_qryCode[2] isEqualToString:@"0"])
                [params setValue:_qryCode[2] forKey:@"createTime"];//时间
            if (![_qryCode[3] isEqualToString:@"0"])
                [params setValue:_qryCode[3] forKey:@"typeId"];//类别typeId
            if (![_qryCode[4] isEqualToString:@"0"])
                [params setValue:_qryCode[4] forKey:@"level"];//区域level
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
        _selectedCityName=@"pricelist";
        [params setValue:_selectedCityName forKey:@"ut"];
        [params setValue:[NSNumber numberWithInteger:15] forKey:@"pageSize"];
        [params setValue:[NSNumber numberWithInteger:_pageindex] forKey:@"pageNo"];
        if (_qryCode.count>4) {
            if (![_qryCode[0] isEqualToString:@"0"])
                [params setValue:_qryCode[0] forKey:@"areaId"];//区域
            if (![_qryCode[1] isEqualToString:@"0"])
                [params setValue:_qryCode[1] forKey:@"brandId"];//类别
            if (![_qryCode[2] isEqualToString:@"0"])
                [params setValue:_qryCode[2] forKey:@"createTime"];//时间
            if (![_qryCode[3] isEqualToString:@"0"])
                [params setValue:_qryCode[3] forKey:@"typeId"];//类别typeId
            if (![_qryCode[4] isEqualToString:@"0"])
                [params setValue:_qryCode[4] forKey:@"level"];//区域level
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
@end
