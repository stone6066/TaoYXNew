//
//  DetailPriceViewController.m
//  TaoYXNew
//
//  Created by tianan-apple on 16/1/7.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "DetailPriceViewController.h"
#import "PricePlaceModel.h"
#import "PublicDefine.h"
#import "DPAPI.h"
#import "PublicDefine.h"
//#import "MsgSupllyDeal.h"
#import "UIImageView+WebCache.h"

@interface DetailPriceViewController ()<DPRequestDelegate,UIWebViewDelegate>

@end

@implementation DetailPriceViewController

-(void)setMsgId:(NSString *)msgId{
    _msgId=msgId;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadTopNavView];
    [self createRequest];
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

# pragma 网络请求
- (void)createRequest{
    DPAPI *api = [[DPAPI alloc]init];
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setValue:@"priceDetail" forKey:@"ut"];
    [params setValue:_msgId forKey:@"id"];
    [api setAllwaysFlash:@"1"];
    [api requestWithURL:NetUrl params:params delegate:self];
}

-(void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result
{
    // NSLog(@"响应：%@",result);
    PricePlaceModel *dm;
    NSArray *datatmp;
    NSDictionary *dict = result;
    dm= [[PricePlaceModel alloc]init];
    datatmp=[dm asignDetailModelWithDict:dict];
    
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


-(void)loadMsgInfo:(PricePlaceModel*)SM{
    
    _sTitle.text=SM.title;
    
    _sType.text=SM.areaName;
    
    _sPrice.text=SM.price;
    
    //_sPerson.text=[NSString stringWithFormat:@"%@%@",@"联系人：",SM.contact];
    
    //_sPhone.text=[NSString stringWithFormat:@"%@%@",@"联系电话：",SM.phone];
    
    _sTime.text=[NSString stringWithFormat:@"%@%@",@"发布时间：",SM.publicTime];
    
    //[_images sd_setImageWithStr:SM.images];
    
    _supplyDesc=SM.empDesc;
}

-(void)loadMsgView{
    float infoViewHeigh=120;
    UIView *InfoView=[[UIView alloc]initWithFrame:CGRectMake(0, TopSeachHigh, fDeviceWidth, infoViewHeigh)];
    CGFloat CellWidth= fDeviceWidth-4;
//    _images=[[UIImageView alloc]initWithFrame:CGRectMake(2, 12, 70, 60)];
//    [InfoView addSubview:_images];
    
    _sTitle=[[UILabel alloc]initWithFrame:CGRectMake(2,0,CellWidth-105,40)];
    _sTitle.font=[UIFont systemFontOfSize:15];
    [_sTitle setLineBreakMode:NSLineBreakByWordWrapping];
    [_sTitle setNumberOfLines:2];
    [InfoView addSubview:_sTitle];
    
    _sType=[[UILabel alloc]initWithFrame:CGRectMake(2, 35, 120, 20)];
    _sType.font=[UIFont systemFontOfSize:13];
    [InfoView addSubview:_sType];
    
    
    _sPrice=[[UILabel alloc]initWithFrame:CGRectMake(2, 55, 120, 20)];
    _sPrice.font=[UIFont systemFontOfSize:13];
    [InfoView addSubview:_sPrice];
    
//    _sPerson=[[UILabel alloc]initWithFrame:CGRectMake(75, 75, 120, 20)];
//    _sPerson.font=[UIFont systemFontOfSize:13];
//    [InfoView addSubview:_sPerson];
//    
//    _sPhone=[[UILabel alloc]initWithFrame:CGRectMake(75, 95, 190, 20)];
//    _sPhone.font=[UIFont systemFontOfSize:13];
//    
//    [InfoView addSubview:_sPhone];
    
    _sTime=[[UILabel alloc]initWithFrame:CGRectMake(2, 75, 190, 20)];
    _sTime.font=[UIFont systemFontOfSize:13];
    
    [InfoView addSubview:_sTime];
    
    [self.view addSubview:InfoView];
    
    
    
    
}

-(void)loadWebView{
    UIWebView *DescView=[[UIWebView alloc]initWithFrame:CGRectMake(0, TopSeachHigh+100, fDeviceWidth, fDeviceHeight-TopSeachHigh-120)];
    [DescView setDelegate:self];
    
    [DescView loadHTMLString:_supplyDesc baseURL:nil];//_supplyDesc
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


@end
