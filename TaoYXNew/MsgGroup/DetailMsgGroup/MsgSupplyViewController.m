//
//  MsgSupplyViewController.m
//  TaoYXNew
//
//  Created by tianan-apple on 16/1/6.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "MsgSupplyViewController.h"
#import "DPAPI.h"
#import "PublicDefine.h"
#import "MsgSupllyDeal.h"
#import "UIImageView+WebCache.h"

@interface MsgSupplyViewController ()<DPRequestDelegate,UIWebViewDelegate>

@end

@implementation MsgSupplyViewController

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
-(void)setMsgId:(NSString *)msgId
{
    _msgId=msgId;
}

# pragma 网络请求
- (void)createRequest{
    DPAPI *api = [[DPAPI alloc]init];
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setValue:@"supplydetail" forKey:@"ut"];
    [params setValue:_msgId forKey:@"id"];
    [api setAllwaysFlash:@"1"];
    [api requestWithURL:NetUrl params:params delegate:self];
}

-(void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result
{
    // NSLog(@"响应：%@",result);
    MsgSupllyDeal *dm;
    NSArray *datatmp;
    NSDictionary *dict = result;
    dm= [[MsgSupllyDeal alloc]init];
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
-(void)loadMsgInfo:(MsgSupllyDeal*)SM{
   
    _sTitle.text=[NSString stringWithFormat:@"%@%@%@%@",@"【",SM.supplyType,@"】",SM.title];
    
    _sPerson.text=[NSString stringWithFormat:@"%@%@",@"联系人：",SM.name];
    
    _sType.text=[NSString stringWithFormat:@"%@%@",@"类别：",SM.brandName];
    
    _sPhone.text=[NSString stringWithFormat:@"%@%@",@"联系电话：",SM.phone];
    
    [_images sd_setImageWithStr:SM.images];
    _supplyDesc=SM.supplyDesc;
}

-(void)loadMsgView{
    float infoViewHeigh=120;
    UIView *InfoView=[[UIView alloc]initWithFrame:CGRectMake(0, TopSeachHigh, fDeviceWidth, infoViewHeigh)];
    CGFloat CellWidth= fDeviceWidth-4;
    _images=[[UIImageView alloc]initWithFrame:CGRectMake(2, 12, 70, 60)];
    [InfoView addSubview:_images];
    
    _sTitle=[[UILabel alloc]initWithFrame:CGRectMake(75,0,CellWidth-105,40)];
    _sTitle.font=[UIFont systemFontOfSize:15];
    [_sTitle setLineBreakMode:NSLineBreakByWordWrapping];
    [_sTitle setNumberOfLines:2];
    [InfoView addSubview:_sTitle];
    
    _sType=[[UILabel alloc]initWithFrame:CGRectMake(75, 35, 120, 20)];
    _sType.font=[UIFont systemFontOfSize:13];
    [InfoView addSubview:_sType];
    
    
    _sPerson=[[UILabel alloc]initWithFrame:CGRectMake(75, 55, 120, 20)];
    _sPerson.font=[UIFont systemFontOfSize:13];
    [InfoView addSubview:_sPerson];
    
    _sPhone=[[UILabel alloc]initWithFrame:CGRectMake(75, 75, 190, 20)];
    _sPhone.font=[UIFont systemFontOfSize:13];
    
    [InfoView addSubview:_sPhone];
    
    [self.view addSubview:InfoView];
    
    
    

}

-(void)loadWebView{
    UIWebView *DescView=[[UIWebView alloc]initWithFrame:CGRectMake(0, TopSeachHigh+120, fDeviceWidth, fDeviceHeight-TopSeachHigh-120)];
    [DescView setDelegate:self];
    
    [DescView loadHTMLString:_supplyDesc baseURL:nil];
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
    [titleLbl setText:@"供求详情"];
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
