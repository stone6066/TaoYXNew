//
//  CarDetailInfoViewController.m
//  TaoYXNew
//
//  Created by tianan-apple on 16/1/11.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "CarDetailInfoViewController.h"
#import "CarExpressDeal.h"
#import "PublicDefine.h"
#import "stdCallBtn.h"
@interface CarDetailInfoViewController ()

@end

@implementation CarDetailInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadTopNavView];
    [self loadMsgView];
    [self loadMsgInfo:_ViewData];
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
-(void)setViewData:(CarExpressDeal *)ViewData
{
    _ViewData=ViewData;
}

-(void)loadMsgInfo:(CarExpressDeal*)SM{
    _logInfoType.text=SM.carCode;
    _startPlace.text=SM.startCity;
    _endPlace.text=SM.endCity;
    _customerName.text=SM.contact;
    _telphone.text=SM.mobile;
    [_telLbl setLblText:_telphone.text];
    _createTime.text=[NSString stringWithFormat:@"发布时间：%@",SM.publicTime];//SM.publicTime;
    _detailDesc.text=[NSString stringWithFormat:@"描述：%@",SM.infoDesc];
    
}

-(void)loadMsgView{
    float infoViewHeigh=fDeviceHeight-TopSeachHigh-30;
    UIView *InfoView=[[UIView alloc]initWithFrame:CGRectMake(0, TopSeachHigh, fDeviceWidth, infoViewHeigh)];
    //InfoView.backgroundColor=[UIColor blueColor];
    CGFloat CellWidth= fDeviceWidth-14;
    _logInfoType=[[UILabel alloc]initWithFrame:CGRectMake(10,20,CellWidth,20)];
    _logInfoType.font=[UIFont systemFontOfSize:13];
    [_logInfoType setLineBreakMode:NSLineBreakByWordWrapping];
    [_logInfoType setNumberOfLines:2];
    [InfoView addSubview:_logInfoType];
    
    _detailDesc=[[UILabel alloc]initWithFrame:CGRectMake(10,60,CellWidth,20)];
    _detailDesc.font=[UIFont systemFontOfSize:13];
    [_detailDesc setLineBreakMode:NSLineBreakByWordWrapping];
    [_detailDesc setNumberOfLines:2];
    [InfoView addSubview:_detailDesc];
    
    _startPlace=[[UILabel alloc]initWithFrame:CGRectMake(10, 100, CellWidth, 20)];
    _startPlace.font=[UIFont systemFontOfSize:13];
    [InfoView addSubview:_startPlace];
    
    _endPlace=[[UILabel alloc]initWithFrame:CGRectMake(10, 140, CellWidth, 20)];
    _endPlace.font=[UIFont systemFontOfSize:13];
    [InfoView addSubview:_endPlace];
    
    _customerName=[[UILabel alloc]initWithFrame:CGRectMake(10, 180, CellWidth, 20)];
    _customerName.font=[UIFont systemFontOfSize:13];
    [InfoView addSubview:_customerName];
    
    _telphone=[[UILabel alloc]initWithFrame:CGRectMake(10, 220, CellWidth, 20)];
    _telphone.font=[UIFont systemFontOfSize:13];
    //[InfoView addSubview:_telphone];
    
    _telLbl=[[stdCallBtn alloc]initWithFrame:CGRectMake(10, 220, CellWidth, 20)];
    [InfoView addSubview:_telLbl];

    _createTime=[[UILabel alloc]initWithFrame:CGRectMake(10, 260, CellWidth, 20)];
    _createTime.font=[UIFont systemFontOfSize:13];
    [InfoView addSubview:_createTime];
    
    [self.view addSubview:InfoView];
 
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
    [titleLbl setText:@"车源详情"];
    [titleLbl setTextColor:[UIColor whiteColor]];
    titleLbl.font=[UIFont systemFontOfSize:18];
    [topView addSubview:titleLbl];
    
    [self.view addSubview:topView];
    
}
-(void)clickleftbtn{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
