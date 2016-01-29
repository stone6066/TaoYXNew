//
//  MesPriceViewController.m
//  TaoYXNew
//
//  Created by tianan-apple on 16/1/6.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "MesPriceViewController.h"
#import "DPAPI.h"
#import "PublicDefine.h"
#import "MsgPriceDeal.h"
#import "UIImageView+WebCache.h"

@interface MesPriceViewController ()<DPRequestDelegate,UIWebViewDelegate>

@end

@implementation MesPriceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadTopNavView];
    [self createRequest];
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

-(void)setMsgId:(NSString *)msgId{
    _msgId=msgId;
}


# pragma 网络请求
- (void)createRequest{
    DPAPI *api = [[DPAPI alloc]init];
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setValue:@"pricedetail" forKey:@"ut"];
    [params setValue:_msgId forKey:@"id"];
    [api setAllwaysFlash:@"1"];
    [api requestWithURL:NetUrl params:params delegate:self];
}

-(void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result
{
    // NSLog(@"响应：%@",result);
    MsgPriceDeal *dm;
    NSArray *datatmp;
    NSDictionary *dict = result;
    dm= [[MsgPriceDeal alloc]init];
    datatmp=[dm asignModelWithDict:dict];
    
    [self loadMsgView];
    if (datatmp.count>0) {
        [self loadMsgInfo:datatmp[0]];
    }
    [self loadWebView];
}
-(void)request:(DPRequest *)request didFailWithError:(NSError *)error
{
    NSLog(@"报错了：%@",error);
}

//"typeName":"蔬菜",
//"origin":"宁夏银川",
//"areaName":"灵武市",
//"brandName":"青椒",
//"typeId":1,
//"brandId":2,
//"pubId":null,
//"publisher":"管理员",
//"priceDesc":"<p>青椒价格10元/斤</p>",
//"price":10,
//"unit":"斤",
//"areaId":10,
//"priceId":3,
//"createTime":1451377774000

-(void)loadMsgInfo:(MsgPriceDeal*)SM{
    
    _brandName.text=SM.brandName;
   
    _origin.text=[NSString stringWithFormat:@"%@%@",@"产地：",SM.origin];
    
    _price.text=[NSString stringWithFormat:@"%@%@%@",@"价格：",SM.price,SM.unit];
    
    _publisher.text=[NSString stringWithFormat:@"%@%@",@"发布者：",SM.publisher];
    
    _createTime.text=[NSString stringWithFormat:@"%@%@",@"发布时间：",SM.createTime];
    
    _priceDesc=SM.priceDesc;
}

-(void)loadMsgView{
    float infoViewHeigh=180;
    UIView *InfoView=[[UIView alloc]initWithFrame:CGRectMake(0, TopSeachHigh, fDeviceWidth, infoViewHeigh)];
    CGFloat CellWidth= fDeviceWidth-4;
    
    _brandName=[[UILabel alloc]initWithFrame:CGRectMake(10, 20, CellWidth, 20)];
    _brandName.font=[UIFont systemFontOfSize:13];
    [InfoView addSubview:_brandName];
    
    _origin=[[UILabel alloc]initWithFrame:CGRectMake(10, 50, CellWidth, 20)];
    _origin.font=[UIFont systemFontOfSize:13];
    [InfoView addSubview:_origin];
    
    _price=[[UILabel alloc]initWithFrame:CGRectMake(10, 80, CellWidth, 20)];
    _price.font=[UIFont systemFontOfSize:13];
    [InfoView addSubview:_price];
    
    _publisher=[[UILabel alloc]initWithFrame:CGRectMake(10, 110, CellWidth, 20)];
    _publisher.font=[UIFont systemFontOfSize:13];
    [InfoView addSubview:_publisher];
    
    _createTime=[[UILabel alloc]initWithFrame:CGRectMake(10, 140, CellWidth, 20)];
    _createTime.font=[UIFont systemFontOfSize:13];
    [InfoView addSubview:_createTime];
    
    [self.view addSubview:InfoView];
 
}

-(void)loadWebView{
    UIWebView *DescView=[[UIWebView alloc]initWithFrame:CGRectMake(0, TopSeachHigh+180, fDeviceWidth, fDeviceHeight-TopSeachHigh-180)];
    [DescView setDelegate:self];
    
    [DescView loadHTMLString:_priceDesc baseURL:nil];
    [self.view addSubview: DescView];
    
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
    [titleLbl setText:@"价格详情"];
    [titleLbl setTextColor:[UIColor whiteColor]];
    titleLbl.font=[UIFont systemFontOfSize:18];
    [topView addSubview:titleLbl];
    
    [self.view addSubview:topView];
    
}
-(void)clickleftbtn{
    [self.navigationController popViewControllerAnimated:YES];
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
