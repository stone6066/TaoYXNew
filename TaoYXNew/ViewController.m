//
//  ViewController.m
//  TaoYXNew
//
//  Created by tianan-apple on 15/12/7.
//  Copyright © 2015年 tianan-apple. All rights reserved.
//

#import "ViewController.h"
#import "PublicDefine.h"
#import "ChangeCityViewController.h"
#import "HomeCollectionViewCell.h"
#import "MJRefresh.h"
#import "DPAPI.h"
#import "ADCollectionViewCell.h"
#import "stdPubFunc.h"
#import "TitleCollectionViewCell.h"
#import "ShortCutViewController.h"
#import "TopNavViewController.h"
#import "LiveSrvViewController.h"
#import "ExpressViewController.h"
#import "PriceInfoViewController.h"
#import "LoginViewController.h"
#import "HomeModel.h"
#import "MessageListViewController.h"
#import "PublishMsgViewController.h"
#import "myInfoViewController.h"

@interface ViewController ()<DPRequestDelegate,MJRefreshBaseViewDelegate,ShortCutdelegate>
{
    NSMutableArray *_dataSource;
    NSString *_selectedCityName;
    NSString *_selectedCategory;
    NSInteger _pageindex;//显示数据的页码，每次刷新+1
    NSMutableArray *_fakeColor;
    MJRefreshFooterView *_footer;//上拉刷新
    MJRefreshHeaderView *_header;//下拉刷新
    UITextField * _seachTextF;
    NSMutableArray *_menuArray;
    UIButton *btn;
    NSString *_homeAllwaysFlash;
    
    NSMutableArray *adImgTitle;//首页广告栏图片url
    NSMutableArray *adUrlTitle;//首页广告栏详情url
    NSMutableArray *adtxtTitle;//首页广告栏标题
    NSInteger refreshFlag;
}


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _VersionType=0;//默认农村版
    refreshFlag=0;
    [self loadNavTopView];
    [self loadHomeCollectionView];
    [self loadBackToTopBtn];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    if ([[stdPubFunc getIsLogin]isEqualToString:@"1"]) {
        [_myViewTitle setText:@"我的"];
    }
}
- (void)loadNavTopView
{
    UIView *topSearch=[[UIView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, TopSeachHigh)];
    topSearch.backgroundColor=topSearchBgdColor;
    
    UIImageView *loginLogo=[[UIImageView alloc] initWithFrame:CGRectMake(fDeviceWidth-30, 27, 22, 22)];
    loginLogo.image=[UIImage imageNamed:@"login"];
    [topSearch addSubview:loginLogo];
    
    _myViewTitle=[[UILabel alloc]initWithFrame:CGRectMake(fDeviceWidth-28, 5, 50, 100)];
    _myViewTitle.text=@"登录";
    [_myViewTitle setTextColor:[UIColor whiteColor]];
    [_myViewTitle setFont:[UIFont systemFontOfSize:9]];
    [topSearch addSubview:_myViewTitle];
    
    UIButton *loginBtn=[[UIButton alloc]initWithFrame:CGRectMake(fDeviceWidth-40, -10, 50, 100)];
    [loginBtn setImageEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    [loginBtn addTarget:self action:@selector(doLogin:) forControlEvents:UIControlEventTouchUpInside];
    [topSearch addSubview:loginBtn];

    
    _cityLbl = [[UILabel alloc] initWithFrame:CGRectMake(0,0,0,0)];//这个frame是初设的，没关系，后面还会重新设置其size。
    [_cityLbl setNumberOfLines:0];
    NSString *s = @"永宁";
    UIFont *font = [UIFont fontWithName:@"Arial" size:20];
    CGSize size = CGSizeMake(320,2000);
    CGSize labelsize =
    [s sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    
    _cityLbl.text=s;
    [_cityLbl setFrame:CGRectMake((fDeviceWidth-labelsize.width)/2,29, labelsize.width, labelsize.height)];
    [_cityLbl setTextColor:[UIColor whiteColor]];
    [_cityLbl setFont:[UIFont fontWithName:@"Arial" size:16]];
    [topSearch addSubview:_cityLbl];
    
    _dropDown=[[UIImageView alloc] initWithFrame:CGRectMake((fDeviceWidth-18)/2, 49, 10, 10)];
    _dropDown.image=[UIImage imageNamed:@"combox"];
    [topSearch addSubview:_dropDown];
    
    UIButton *cityBtn=[[UIButton alloc]initWithFrame:CGRectMake((fDeviceWidth-labelsize.width)/2-20, -10, 100, 120)];
    [cityBtn setImageEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    [cityBtn addTarget:self action:@selector(changeCity:) forControlEvents:UIControlEventTouchUpInside];
    [topSearch addSubview:cityBtn];
    
    _cityView=[[UIImageView alloc]initWithFrame:CGRectMake(12, 27, 22, 22)];
    _cityView.image=[UIImage imageNamed:@"CountryChar"];
    [topSearch addSubview:_cityView];
    
    _verTypeLbl=[[UILabel alloc]initWithFrame:CGRectMake(9, 5, 80, 100)];
    _verTypeLbl.text=@"农村版";
    [_verTypeLbl setTextColor:[UIColor whiteColor]];
    [_verTypeLbl setFont:[UIFont systemFontOfSize:9]];
    [topSearch addSubview:_verTypeLbl];
    
    UIButton *versionBtn=[[UIButton alloc]initWithFrame:CGRectMake(0,5, 100, 120)];
    [versionBtn setImageEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    [versionBtn addTarget:self action:@selector(changeVersion:) forControlEvents:UIControlEventTouchUpInside];
    [topSearch addSubview:versionBtn];
    
    [self.view addSubview:topSearch];
}
-(void)changeVersion:(UIButton*)sender{
    if (_VersionType==1) {
        _VersionType=0;
        [self.collectionView reloadData];
        _verTypeLbl.text=@"农村版";
        [_cityView setImage:[UIImage imageNamed:@"CountryChar"]];
        
       [self setcitylblText:@"永宁"];
    }
    else
    {
        _VersionType=1;
        [self.collectionView reloadData];
        _verTypeLbl.text=@"城市版";
        [_cityView setImage:[UIImage imageNamed:@"CityChar"]];
        [self setcitylblText:@"银川"];
    }
    refreshFlag=1;
    [self createRequest:_VersionType];
//    NSString *urlstr = @"MyApp://com.tianan.std";
//    NSURL *handlbackeUrl = [NSURL URLWithString:urlstr];
//    [[UIApplication sharedApplication] openURL:handlbackeUrl];
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"mqq://"]];
}
-(void)setcitylblText:(NSString*)txt{
    CGSize size = CGSizeMake(320,2000);
    UIFont *font = [UIFont fontWithName:@"Arial" size:20];
    CGSize labelsize =
    [txt sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    
    _cityLbl.text=txt;
    //[_cityLbl setFrame:CGRectMake(50,27, labelsize.width, labelsize.height)];
    [_cityLbl setFrame:CGRectMake((fDeviceWidth-labelsize.width)/2,29, labelsize.width, labelsize.height)];
    //[_dropDown setFrame:CGRectMake(44+_cityLbl.frame.size.width, 32, 10, 10)];
    
    
}
-(void)readLoginInfo{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * userName = [user objectForKey:NSUserDefaultsUsers];
    NSString * userPwd = [user objectForKey:NSUserDefaultsUid];
    NSLog(@"user:%@Uid:%@",userName,userPwd);
}
-(void)changeCity:(UIButton*)button{
    //NSLog(@"city");
    ChangeCityViewController *cityView=[[ChangeCityViewController alloc]init];
    cityView.hidesBottomBarWhenPushed=YES;
    cityView.navigationItem.hidesBackButton=YES;
    [cityView setCityType:_VersionType];
    cityView.CityChangeBlock = ^(ChangeCityViewController *aqrvc,NSString *qrString){
        [aqrvc dismissViewControllerAnimated:NO completion:nil];
        [self setcitylblText:qrString];
        
    };
    cityView.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:cityView animated:YES];
    
}

-(void)doLogin:(UIButton*)button{
    [self createLoginRequest];
}
-(void)loadLoginView{
    LoginViewController *shortCutView=[[LoginViewController alloc]init];
    shortCutView.hidesBottomBarWhenPushed=YES;
    shortCutView.navigationItem.hidesBackButton=YES;
   
   
    [shortCutView setWeburl:[NSString stringWithFormat:@"%@%@",MainUrl,@"nst/jumpmobilelogin.htm"]];
    [shortCutView setTopTitle:@"登录"];
    shortCutView.LoginFlagBlock = ^(LoginViewController *LoginView,NSInteger loginFlag){
        [LoginView dismissViewControllerAnimated:NO completion:nil];
        if (loginFlag==1) {
            [_myViewTitle setText:@"我的"];
        }
    };
    shortCutView.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:shortCutView animated:YES];
}
-(void)loadMyInfoView{
    myInfoViewController *LiveView=[[myInfoViewController alloc]init];
    LiveView.hidesBottomBarWhenPushed=YES;
    LiveView.navigationItem.hidesBackButton=YES;
    LiveView.LoginOutFlagBlock = ^(myInfoViewController *MyinfoView,NSInteger loginFlag){
        [MyinfoView dismissViewControllerAnimated:NO completion:nil];
        if (loginFlag==1) {
            [_myViewTitle setText:@"登录"];
            [stdPubFunc setIsLogin:@"0"];
        }
    };

    
    LiveView.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:LiveView animated:YES];
}
# pragma 网络请求
- (void)createLoginRequest{
    DPAPI *api = [[DPAPI alloc]init];
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setValue:@"islogin" forKey:@"ut"];
    [api setAllwaysFlash:@"1"];
    NSString *myurl=NetUrl;
    [api loginRequestWithURL:myurl params:params delegate:self];
}

-(void)loginrequest:(DPRequest *)request didFinishLoadingWithResult:(id)result{
    NSDictionary *dict=result;
    NSString *logstr=[dict objectForKey:@"msg"];
    if ([logstr isEqualToString:@"ok"]) {//已经登录
        [self loadMyInfoView];
    }
    else
    {
        [_myViewTitle setText:@"登录"];
        [self loadLoginView];
    }
}


static NSString * const reuseIdentifier = @"MainCell";//数据cell
static NSString * const cellIndentifier = @"menucell";//8个按钮
static NSString * const aoScrollid = @"aoScrollid";//轮播页面
static NSString * const titleCellid = @"titleCellid";//标题页

-(void)loadHomeCollectionView{
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, TopSeachHigh, fDeviceWidth, fDeviceHeight-TopSeachHigh) collectionViewLayout:flowLayout];
   
    //设置代理
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    //-----------------------------------------
    
    self.collectionView.backgroundColor =collectionBgdColor;// [UIColor whiteColor];
    
    //注册cell和ReusableView（相当于头部）
    [self.collectionView registerClass:[ADCollectionViewCell  class] forCellWithReuseIdentifier:@"menucell"];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"HomeCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    
    //[self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:aoScrollid];
    
    [self.collectionView registerClass:[AOScrollerView  class] forCellWithReuseIdentifier:aoScrollid];
    
    [self.collectionView registerClass:[TitleCollectionViewCell  class] forCellWithReuseIdentifier:titleCellid];
    
    
    
   
    
    //=========================================
    
    _homeAllwaysFlash=@"0";
    //[self setHomeLastUpdateTime];
    
    _pageindex=1;
    [self createRequest:_VersionType];
    _dataSource = [NSMutableArray array];//还要再搞一次，否则_dataSource装不进去数据
    
    // 3.集成刷新控件
    // 3.1.下拉刷新
    MJRefreshHeaderView *header = [MJRefreshHeaderView header];
    header.scrollView = self.collectionView;
    header.delegate = self;
    // 自动刷新
    
    _header = header;
    //NSLog(@"%@",_header.lastUpdateTimeLabel.text);
    
    // 集成刷新控件
    // 上拉刷新
    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
    footer.scrollView = self.collectionView;
    footer.delegate = self;
    _footer = footer;
}

//轮播广告点击跳转事件
#pragma AOScrollViewDelegate
-(void)buttonClick:(NSString*)vid vname:(NSString*)vname{
//    NSString *strurl=vid;
//    NSString *titleStr=vname;
    NSMutableArray *arrTmp;
    if ([vname isEqualToString:@"餐企商超"]) {
        arrTmp =[[NSMutableArray alloc]initWithObjects:@"供求信息",@"商超列表",nil];
        [self popNavView:@"餐企商超" myButtonstr:arrTmp myType:0];

    }
    else if([vname isEqualToString:@"物流信息"])
    {
        arrTmp =[[NSMutableArray alloc]initWithObjects:@"车源信息",@"货源信息",@"本地货站",@"本地长途",@"本地国际",nil];
        [self popExpressView:@"物流信息" myButtonstr:arrTmp myType:2];
    }


    
}

# pragma 网络请求
- (void)createRequest:(NSInteger)qryType{
    DPAPI *api = [[DPAPI alloc]init];
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    if (0==qryType) {//农村版
        _selectedCityName=@"indexVilliageGoods";
    }
    else
        _selectedCityName=@"indexCityGoods";
    [params setValue:_selectedCityName forKey:@"ut"];
    [params setValue:[NSNumber numberWithInteger:20] forKey:@"pageSize"];
    [params setValue:[NSNumber numberWithInteger:_pageindex] forKey:@"pageNo"];
    [api setAllwaysFlash:_homeAllwaysFlash];
    [api requestWithURL:NetUrl params:params delegate:self];
}

-(void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result
{
    //NSLog(@"相应：%@",result);
    NSDictionary *dict = result;
    HomeModel *md = [[HomeModel alloc]init];
    NSArray *datatmp=[md asignModelWithDict:dict];
    if (refreshFlag==1) {
        [_dataSource removeAllObjects];
    }//强制刷新 清空列表
    [_dataSource addObjectsFromArray:datatmp];
    [self.collectionView reloadData];
    
}
-(void)request:(DPRequest *)request didFailWithError:(NSError *)error
{
    NSLog(@"报错了：%@",error);
}

#pragma mark -- UICollectionViewDataSource
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (3==section) {
        return _dataSource.count;
    }
    else if (2==section) {
        return 1;
    }
    return 1;
}
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 4;
}
//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"NSIndexPath:%ld",indexPath.section);
    if (indexPath.section==0) {
        ADCollectionViewCell* cell=[collectionView dequeueReusableCellWithReuseIdentifier:cellIndentifier forIndexPath:indexPath];
        cell=[cell initWithFrame:CGRectMake(0, 0, fDeviceWidth, 160) AdShowType:_VersionType];
        cell.delegate=self;
        
        //NSLog(@"NSIndexPath:%ld",indexPath.item);
        return cell;
       
    }
    else if(indexPath.section==1)
    {
        //轮播加载============================
        NSMutableArray *arr=[[NSMutableArray alloc]initWithObjects:HomeAdUrl1,HomeAdUrl2,HomeAdUrl3,nil];
        //设置标题数组
        NSMutableArray *strArr = [[NSMutableArray alloc]initWithObjects:@"餐企商超",@"物流信息",@"商务服务", nil];
        
        NSMutableArray *urlArr = [[NSMutableArray alloc]initWithObjects:@"http://www.tao-yx.com/mobile/list/4742",@"http://www.tao-yx.com/mobile/list/4678",@"http://www.tao-yx.com/mobile/list/4678",nil];
        
        
        _myheaderView=[[AOScrollerView alloc]initWithNameArr:arr titleArr:strArr dealUrl:urlArr height:AdHight];
        //设置委托
        _myheaderView.vDelegate=self;
        
        
        
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:aoScrollid forIndexPath:indexPath];
        [cell addSubview:_myheaderView];//头部广告栏
        
        return cell;
        
    }
    else if(indexPath.section==2)
    {
//        TitleCollectionViewCell *cell=[[TitleCollectionViewCell alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth-4, 35) cellTitle:@"热门推荐"];
//        //[cell setCellTitle:@"热门推荐"];
        TitleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:titleCellid forIndexPath:indexPath];
        if (0==_VersionType) {
            [cell setlabtitleTxt:@"热门推荐"];
        }
        else {
            [cell setlabtitleTxt:@"特色农副产品"];
        }
        
        return cell;
        
    }
    else //if (indexPath.section==1)
    {
        HomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
        HomeModel *md=_dataSource[indexPath.item];
        [cell showUIWithModel:md];
        //NSLog(@"NSIndexPath-----:%ld",indexPath.item);
        return cell;
    }
    
    //[cell sizeToFit];
}

#pragma mark --UICollectionViewDelegateFlowLayout


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0)
        return  CGSizeMake(fDeviceWidth-4, 160);
    if(indexPath.section==1)
        return  CGSizeMake(fDeviceWidth-4, AdHight);
    if(indexPath.section==2)
        return  CGSizeMake(fDeviceWidth-4, 35);
    else
        return CGSizeMake(fDeviceWidth-4, 80);;
}

//定义每个UICollectionView 的间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 2, 2, 2);
}
//定义每个UICollectionView 纵向的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}
//定义每行UICollectionCellView 的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section;
{
    return 1;
}
#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section==3) {
        HomeCollectionViewCell *svc =(HomeCollectionViewCell*)[self.collectionView cellForItemAtIndexPath:indexPath];
        HomeModel *HM=[svc praseModelWithCell:svc];
        ShortCutViewController *shortCutView=[[ShortCutViewController alloc]init];
        shortCutView.hidesBottomBarWhenPushed=YES;
        shortCutView.navigationItem.hidesBackButton=YES;
        
        [shortCutView setWeburl:HM.dealurl];
        [shortCutView setTopTitle:@"商品详情"];
        [shortCutView setScanFlag:1];
        shortCutView.view.backgroundColor = [UIColor whiteColor];
        [self.navigationController pushViewController:shortCutView animated:YES];
        
    }
    else
    {
        NSLog(@"%ld---%ld---select:",indexPath.section,indexPath.item);
    }
    
    
}
//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
-(void)popNavView:(NSString*)titleStr myButtonstr:(NSMutableArray*)btnArr myType:(NSInteger)typeFlag{
    TopNavViewController *componyView=[[TopNavViewController alloc]init];
    componyView.hidesBottomBarWhenPushed=YES;
    componyView.navigationItem.hidesBackButton=YES;
    [componyView setTopTitle:titleStr];
    [componyView setTitleArr:btnArr];
    [componyView setViewType:typeFlag];
    componyView.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:componyView animated:YES];
}

-(void)popExpressView:(NSString*)titleStr myButtonstr:(NSMutableArray*)btnArr myType:(NSInteger)typeFlag{
    ExpressViewController *componyView=[[ExpressViewController alloc]init];
    componyView.hidesBottomBarWhenPushed=YES;
    componyView.navigationItem.hidesBackButton=YES;
    [componyView setTopTitle:titleStr];
    [componyView setTitleArr:btnArr];
    [componyView setViewType:typeFlag];
    componyView.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:componyView animated:YES];
}

-(void)popPriceView:(NSString*)titleStr myButtonstr:(NSMutableArray*)btnArr myType:(NSInteger)typeFlag{
    PriceInfoViewController *componyView=[[PriceInfoViewController alloc]init];
    componyView.hidesBottomBarWhenPushed=YES;
    componyView.navigationItem.hidesBackButton=YES;
    //[componyView setTopTitle:titleStr];
    //[componyView setTitleArr:btnArr];
    componyView.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:componyView animated:YES];
}

-(void)popMessageView:(NSString*)titleStr {
    MessageListViewController *componyView=[[MessageListViewController alloc]init];
    componyView.hidesBottomBarWhenPushed=YES;
    componyView.navigationItem.hidesBackButton=YES;
    [componyView setTopTitle:titleStr];
    //[componyView setTitleArr:btnArr];
    componyView.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:componyView animated:YES];
}


-(void)popLiveView:(NSString*)titleStr{
    LiveSrvViewController *LiveView=[[LiveSrvViewController alloc]init];
    LiveView.hidesBottomBarWhenPushed=YES;
    LiveView.navigationItem.hidesBackButton=YES;
    [LiveView setTopTitle:titleStr];
    LiveView.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:LiveView animated:YES];
}

//MsgType 0农村版 1城市版
-(void)popPubMsgView:(NSInteger)MsgType{
    PublishMsgViewController *LiveView=[[PublishMsgViewController alloc]init];
    LiveView.hidesBottomBarWhenPushed=YES;
    LiveView.navigationItem.hidesBackButton=YES;
    [LiveView setShowType:MsgType];
    LiveView.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:LiveView animated:YES];
}

//#define NongFuUrl @"http://shop.anquan365.org/mobile/cates-391.html"
//#define NongZiUrl @"http://shop.anquan365.org/mobile/cates-386.html"
//#define LiveProductUrl @"http://shop.anquan365.org/mobile/cates-397.html"


-(void)shortCutClick:(NSInteger)sendTag{
    NSString *strurl=@"";
    NSString *titleStr=@"淘翼夏";
    NSMutableArray *arrTmp;
    NSInteger myScan=0;
    switch (sendTag) {//_VersionType==0农村版
        case 10:
            if (1==_VersionType)
            {
            titleStr=@"农副产品";
            
            strurl=[NSString stringWithFormat:@"%@%@",MainUrl,@"mobile/cates-391.html"];
            myScan=1;
            }
            else{
                titleStr=@"农资用品";
                strurl=[NSString stringWithFormat:@"%@%@",MainUrl,@"mobile/cates-386.html"];
                myScan=1;
            }
            break;
        case 11:
        {
            if (1==_VersionType) {
                arrTmp =[[NSMutableArray alloc]initWithObjects:@"区域",@"类别",@"时间", nil];
                [self popPriceView:@"价格信息" myButtonstr:arrTmp myType:1];
            }
            else{
                strurl=[NSString stringWithFormat:@"%@%@",MainUrl,@"mobile/cates-397.html"];
                titleStr=@"生活用品";
                myScan=1;
            }
        }
            break;
        case 12:
            if (1==_VersionType) {
                //[self popLiveView:@"生活服务"];
            }
            else
            {
                strurl=[NSString stringWithFormat:@"%@%@",MainUrl,@"mobile/cates-391.html"];
                titleStr=@"农副产品";
                myScan=1;
            }
            break;
        case 13:
            if (1==_VersionType){
                arrTmp =[[NSMutableArray alloc]initWithObjects:@"区域",@"类别",@"时间", nil];
                [self popPriceView:@"价格信息" myButtonstr:arrTmp myType:1];
            }
            else{
                arrTmp =[[NSMutableArray alloc]initWithObjects:@"供求信息",@"商超列表",nil];
                [self popNavView:@"餐企商超" myButtonstr:arrTmp myType:0];
            }
            break;
        case 14:
            if (1==_VersionType) {
                [self popLiveView:@"生活服务"];
            }
            else
            {
                arrTmp =[[NSMutableArray alloc]initWithObjects:@"区域",@"类别",@"时间", nil];
                [self popPriceView:@"价格信息" myButtonstr:arrTmp myType:1];
                
                
            }


            
            break;
        case 15:
            if (1==_VersionType) {
                [self popLiveView:@"生活服务"];
            }
            else
            {
                arrTmp =[[NSMutableArray alloc]initWithObjects:@"车源信息",@"货源信息",@"本地货站",@"本地长途",@"本地国际",nil];
                [self popExpressView:@"物流信息" myButtonstr:arrTmp myType:2];
            }
            break;
        case 16:
            if (1==_VersionType){
             [self popLiveView:@"生活服务"];
            }
            else{//消息中心
                [self popMessageView:@"消息中心"];
            }
            break;
            
        case 17:
            if (1==_VersionType) {
                strurl=[NSString stringWithFormat:@"%@%@",MainUrl,@"mobile/cates-397.html"];
                titleStr=@"生活用品";
                myScan=1;
            }
            else
            {//发布信息
                [self popPubMsgView:0];
            }
            
            break;
        default:
            break;
    }
    if ([strurl length]>0) {
        ShortCutViewController *shortCutView=[[ShortCutViewController alloc]init];
        shortCutView.hidesBottomBarWhenPushed=YES;
        shortCutView.navigationItem.hidesBackButton=YES;
        
        [shortCutView setWeburl:strurl];
        [shortCutView setTopTitle:titleStr];
        [shortCutView setScanFlag:myScan];
        shortCutView.view.backgroundColor = [UIColor whiteColor];
        [self.navigationController pushViewController:shortCutView animated:YES];
    }
    else{
        NSLog(@"跳转链接为空");
    }

}


#pragma mark - 刷新控件的代理方法
#pragma mark 开始进入刷新状态

- (void)doneWithView:(MJRefreshBaseView *)refreshView
{
    
    // 刷新表格
    //[self.collectionView reloadData];
    
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
        _homeAllwaysFlash=@"1";//强制刷新
        DPAPI *api = [[DPAPI alloc]init];
        NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
        if (0==_VersionType) {//农村版
            _selectedCityName=@"indexVilliageGoods";
        }
        else
            _selectedCityName=@"indexCityGoods";
        [params setValue:_selectedCityName forKey:@"ut"];
        [params setValue:[NSNumber numberWithInteger:20] forKey:@"pageSize"];
        [params setValue:[NSNumber numberWithInteger:_pageindex] forKey:@"pageNo"];
        [api setAllwaysFlash:_homeAllwaysFlash];
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
        if (0==_VersionType) {//农村版
            _selectedCityName=@"indexVilliageGoods";
        }
        else
            _selectedCityName=@"indexCityGoods";
        [params setValue:_selectedCityName forKey:@"ut"];
        [params setValue:[NSNumber numberWithInteger:20] forKey:@"pageSize"];
        [params setValue:[NSNumber numberWithInteger:_pageindex] forKey:@"pageNo"];
        [api setAllwaysFlash:_homeAllwaysFlash];
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

-(void)setVersionType:(NSInteger)VersionType
{
    _VersionType=VersionType;
}

-(void)loadBackToTopBtn{
    // 添加回到顶部按钮
    _topBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _topBtn.frame = CGRectMake(fDeviceWidth-50, fDeviceHeight-60, 40, 40);
    [_topBtn setBackgroundImage:[UIImage imageNamed:@"back2top.png"] forState:UIControlStateNormal];
    [_topBtn addTarget:self action:@selector(backToTopButton) forControlEvents:UIControlEventTouchUpInside];
    _topBtn.clipsToBounds = YES;
    _topBtn.hidden = YES;
    [self.view addSubview:_topBtn];
}
- (void)backToTopButton{
    [self.collectionView setContentOffset:CGPointMake(0, 0) animated:YES];
}

// MARK:  计算偏移量
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //MARK:列表滑动偏移量计算
    CGPoint point = [self.collectionView contentOffset];
    
    if (point.y >= self.collectionView.frame.size.height) {
        self.topBtn.hidden = NO;
        [self.view bringSubviewToFront:self.topBtn];
    } else {
        self.topBtn.hidden = YES;
    }
}
@end
