//
//  MsgCommonViewController.m
//  TaoYXNew
//
//  Created by tianan-apple on 16/1/7.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "MsgCommonViewController.h"
#import "DPAPI.h"
#import "PublicDefine.h"
#import "MsgCommonDeal.h"

@interface MsgCommonViewController ()<DPRequestDelegate,UIWebViewDelegate>

@end

@implementation MsgCommonViewController

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
    [titleLbl setText:@"消息详情"];
    [titleLbl setTextColor:[UIColor whiteColor]];
    titleLbl.font=[UIFont systemFontOfSize:18];
    [topView addSubview:titleLbl];
    
    [self.view addSubview:topView];
    
}
-(void)clickleftbtn{
    [self.navigationController popViewControllerAnimated:YES];
}

# pragma 网络请求
- (void)createRequest{
    DPAPI *api = [[DPAPI alloc]init];
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setValue:@"noticedetail" forKey:@"ut"];
    [params setValue:_msgId forKey:@"id"];
    [api setAllwaysFlash:@"1"];
    [api requestWithURL:NetUrl params:params delegate:self];
}

-(void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result
{
    // NSLog(@"响应：%@",result);
    MsgCommonDeal *dm;
    NSArray *datatmp;
    NSDictionary *dict = result;
    dm= [[MsgCommonDeal alloc]init];
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


-(void)loadMsgInfo:(MsgCommonDeal*)SM{
    
    _sTitle.text=SM.title;

    _sTime.text=[NSString stringWithFormat:@"%@%@",@"发布时间：",SM.send_time];
    
    _sDesc=SM.supplyDesc;
}

-(void)loadMsgView{
    float infoViewHeigh=180;
    UIView *InfoView=[[UIView alloc]initWithFrame:CGRectMake(0, TopSeachHigh, fDeviceWidth, infoViewHeigh)];
    CGFloat CellWidth= fDeviceWidth-4;
    
    _sTitle=[[UILabel alloc]initWithFrame:CGRectMake(10, 20, CellWidth, 20)];
    _sTitle.font=[UIFont systemFontOfSize:13];
    [InfoView addSubview:_sTitle];
    
    _sTime=[[UILabel alloc]initWithFrame:CGRectMake(10, 50, CellWidth, 20)];
    _sTime.font=[UIFont systemFontOfSize:13];
    [InfoView addSubview:_sTime];

    [self.view addSubview:InfoView];
    
}

-(void)loadWebView{
    UIWebView *DescView=[[UIWebView alloc]initWithFrame:CGRectMake(0, TopSeachHigh+80, fDeviceWidth, fDeviceHeight-TopSeachHigh-180)];
    [DescView setDelegate:self];
    
    [DescView loadHTMLString:_sDesc baseURL:nil];
    [self.view addSubview: DescView];
    
}


@end
