//
//  MsgSettingViewController.m
//  TaoYXNew
//
//  Created by tianan-apple on 16/1/6.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "MsgSettingViewController.h"
#import "PublicDefine.h"
#import "SSCheckBoxView.h"


@interface MsgSettingViewController ()

@end

@implementation MsgSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadTopNavView];
    [self loadTypeSetting];
    [self loadCitySetting];
    [self stdRightGesture];
    //NSLog(@"citycode:%@-------typecode:%@",[self getCityQryCode],[self getTypeQryCode]);
    // Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setTopTitle:(NSString *)topTitle{
    _topTitle=topTitle;
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
    [titleLbl setText:_topTitle];
    [titleLbl setTextColor:[UIColor whiteColor]];
    titleLbl.font=[UIFont systemFontOfSize:18];
    [topView addSubview:titleLbl];

    [self.view addSubview:topView];
    
}

-(void)clickleftbtn{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)saveTypeInfo:(NSMutableArray *)cityCode cityName:(NSString *)cityStr{
    NSUserDefaults *CityInfo = [NSUserDefaults standardUserDefaults];
    [CityInfo setObject:cityCode forKey:NSUserDefaultsTypeInfo];
    [CityInfo setObject:cityStr forKey:NSUserDefaultsTypeName];
    [CityInfo synchronize];
}
-(NSString*)readTypeInfo{
    NSUserDefaults *cityName = [NSUserDefaults standardUserDefaults];
    NSString * CName = [cityName objectForKey:NSUserDefaultsTypeName];
    return CName;
}

- (void) TypeCheckBoxViewChangedState:(SSCheckBoxView *)cbv
{
    NSMutableArray *typeArr=[[NSMutableArray alloc]init];
    NSString *typeName=@"";
    NSString *typeId=@"1";
    for (SSCheckBoxView *citybv in TypeCheckboxes)
    {
        if (citybv.checked) {
            typeId=[NSString stringWithFormat:@"%ld",citybv.tag];
            [typeArr addObject:typeId];
            typeName=[NSString stringWithFormat:@"%@%@%@",typeName,citybv.textLabel.text,@"|"];
        }
    }
    [self saveTypeInfo:typeArr cityName:typeName];

}

-(void)loadTypeSetting{
    
    UIView *TitleVc=[[UIView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, 30)];
    UILabel *TypeLbl=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, fDeviceWidth, 30)];
    TypeLbl.text=@"选择需要接收的消息类型";
    [TypeLbl setFont:[UIFont systemFontOfSize:15]];
    [TitleVc addSubview:TypeLbl];
    TitleVc.backgroundColor=SettingViewColor;
    
    
    NSArray *checkTxt=[[NSArray alloc]initWithObjects:@"普通消息",@"价格行情", @"物流信息",@"供求信息",nil];
    NSMutableArray *a = [[NSMutableArray alloc] initWithCapacity:checkTxt.count];
    TypeCheckboxes = a;
    
    UIView *TypeVc=[[UIView alloc]initWithFrame:CGRectMake(0, TopSeachHigh, fDeviceWidth, 180)];
    
    [TypeVc addSubview:TitleVc];
    
    SSCheckBoxView *cbv = nil;
    SSCheckBoxViewStyle style = kSSCheckBoxViewStyleGreen;
    CGRect frame = CGRectMake(20, 40, 240, 30);
    
    NSString *TypeSelected=[self readTypeInfo];
    BOOL checked = 0;
    for (int i = 0; i < checkTxt.count; ++i) {
        
        if ([TypeSelected rangeOfString:checkTxt[i]].location !=NSNotFound) {
            checked=1;
        }
        else
            checked=0;
        cbv = [[SSCheckBoxView alloc] initWithFrame:frame
                                              style:style
                                            checked:checked];
        [cbv setText:checkTxt[i]];
        cbv.tag=i;
        [TypeVc addSubview:cbv];
        [cbv setStateChangedBlock:^(SSCheckBoxView *v) {
            [self TypeCheckBoxViewChangedState:v];
        }];
        
        [TypeCheckboxes addObject:cbv];
        frame.origin.y += 36;
    }
    
    [self.view addSubview:TypeVc];

}

-(void)saveCityInfo:(NSMutableArray *)cityCode cityName:(NSString *)cityStr{
    NSUserDefaults *CityInfo = [NSUserDefaults standardUserDefaults];
    [CityInfo setObject:cityCode forKey:NSUserDefaultsCityInfo];
    [CityInfo setObject:cityStr forKey:NSUserDefaultsCityName];
    [CityInfo synchronize];
}
-(NSString*)getMyCityCode:(NSString *)cityName
{
    NSString *file;
   
    file = [[NSBundle mainBundle]pathForResource:@"cities.plist" ofType:nil];
   
    //加载plist为数组
    NSArray *plistArray = [NSArray arrayWithContentsOfFile:file];
    NSDictionary *citydict=[[NSDictionary alloc]init];
    NSString *city_code=nil;
    for (NSDictionary *dict in plistArray)
    {
      
        citydict=[dict objectForKey:@"citycode"];
        city_code=[citydict objectForKey:cityName];
        if (city_code.length>0) {
            return city_code;
        }
    }
    
    return @"0";
}
- (void) CityCheckBoxViewChangedState:(SSCheckBoxView *)cbv
{
    NSMutableArray *cityArr=[[NSMutableArray alloc]init];
    NSString *cityName=@"";
    for (SSCheckBoxView *citybv in CityCheckboxes)
    {
        if (citybv.checked) {
            
            [cityArr addObject:[self getMyCityCode:citybv.textLabel.text]];
            cityName=[NSString stringWithFormat:@"%@%@%@",cityName,citybv.textLabel.text,@"|"];
        }
    }
    [self saveCityInfo:cityArr cityName:cityName];
//    for (id obj in cityArr) {
//       NSLog(@"%@",obj);
//    }
    
}

-(NSString*)readCityInfo{
    NSUserDefaults *cityName = [NSUserDefaults standardUserDefaults];
    NSString * CName = [cityName objectForKey:NSUserDefaultsCityName];
    return CName;
}

-(void)loadCitySetting{
    UIView *CityVc=[[UIView alloc]initWithFrame:CGRectMake(0, TopSeachHigh+155+30, fDeviceWidth, 30)];
    UILabel *TypeLbl=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, fDeviceWidth, 30)];
    TypeLbl.text=@"选择需要接收的城市";
    [TypeLbl setFont:[UIFont systemFontOfSize:15]];
    [CityVc addSubview:TypeLbl];
    CityVc.backgroundColor=SettingViewColor;
    [self.view addSubview:CityVc];

    NSArray *checkTxt=[[NSArray alloc]initWithObjects:@"银川市",@"石嘴山市",@"吴忠市",@"固原市",@"中卫市",@"永宁县",@"贺兰县",@"灵武市",@"惠农区",@"平罗县", @"盐池县",@"同心县",@"青铜峡市",@"西吉县",@"隆德县",@"泾源县",@"彭阳县",@"中宁县",nil];
    
    NSMutableArray *a = [[NSMutableArray alloc] initWithCapacity:checkTxt.count];
    CityCheckboxes = a;
    
    UIScrollView *TypeVc=[[UIScrollView alloc]initWithFrame:CGRectMake(0, TopSeachHigh+155+60, fDeviceWidth, fDeviceHeight-TopSeachHigh-200)];

    SSCheckBoxView *cbv = nil;
    SSCheckBoxViewStyle style =kSSCheckBoxViewStyleGreen;
    //kSSCheckBoxViewStyleBox;
   
    float ScrollHeigh=10;
    NSString *citySelected=[self readCityInfo];
    
    CGRect frame = CGRectMake(20, 10, 240, 30);
    BOOL checked = 0;
    for (int i = 0; i < checkTxt.count; ++i) {
        
        
        if ([citySelected rangeOfString:checkTxt[i]].location !=NSNotFound) {
            checked=1;
        }
        else
            checked=0;
        cbv = [[SSCheckBoxView alloc] initWithFrame:frame
                                              style:style
                                            checked:checked];
        [cbv setText:checkTxt[i]];
        [TypeVc addSubview:cbv];
        [cbv setStateChangedBlock:^(SSCheckBoxView *v) {
            [self CityCheckBoxViewChangedState:v];
        }];
        [CityCheckboxes addObject:cbv];
        frame.origin.y += 36;
        ScrollHeigh+=36;
    }
    [TypeVc setContentSize:CGSizeMake(fDeviceWidth, ScrollHeigh)];
    [self.view addSubview:TypeVc];
    
}

-(NSString *)getCityQryCode{
    NSUserDefaults *cityName = [NSUserDefaults standardUserDefaults];
    NSMutableArray * CName = [cityName objectForKey:NSUserDefaultsCityInfo];
    NSString *rtStr=@"";
    for (id obj in CName) {
         rtStr=[NSString stringWithFormat:@"%@%@%@",rtStr,obj,@","];
    }
    return rtStr;
}

-(NSString *)getTypeQryCode{
    NSUserDefaults *cityName = [NSUserDefaults standardUserDefaults];
    NSMutableArray * CName = [cityName objectForKey:NSUserDefaultsTypeInfo];
    NSString *rtStr=@"";
    for (id obj in CName) {
        rtStr=[NSString stringWithFormat:@"%@%@%@",rtStr,obj,@","];
    }
    return rtStr;
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
