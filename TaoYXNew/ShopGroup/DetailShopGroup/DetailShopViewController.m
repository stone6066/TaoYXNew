//
//  DetailShopViewController.m
//  TaoYXNew
//
//  Created by tianan-apple on 16/1/7.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "DetailShopViewController.h"
#import "CmpModel.h"
#import "PublicDefine.h"
#import "stdCallBtn.h"
@interface DetailShopViewController ()<UIWebViewDelegate>

@end

@implementation DetailShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadTopNavView];
    [self loadMsgView];
    [self loadMsgInfo:_companyData];
    [self loadWebView];
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

-(void)setCompanyData:(CmpModel *)companyData{
    _companyData=companyData;
}

-(void)loadMsgInfo:(CmpModel*)NModel{
    
    _supplyTitle.text=NModel.empName;
    
    _supplyPerson.text=NModel.contact;
    
    _supplyDetail.text=NModel.address;
    
    _supplyTel.text=NModel.phone;
    
    [_telLbl setLblText:_supplyTel.text];
    
    _cellUrl=NModel.empDesc;
}

-(void)loadMsgView{
    float infoViewHeigh=130;
    UIView *InfoView=[[UIView alloc]initWithFrame:CGRectMake(0, TopSeachHigh, fDeviceWidth, infoViewHeigh)];
    CGFloat CellWidth= fDeviceWidth-6;
    
    _supplyTitle=[[UILabel alloc]initWithFrame:CGRectMake(5,0,CellWidth,40)];
    _supplyTitle.font=[UIFont systemFontOfSize:13];
    [_supplyTitle setLineBreakMode:NSLineBreakByWordWrapping];
    [_supplyTitle setNumberOfLines:2];
    [InfoView addSubview:_supplyTitle];
    

    _supplyDetail=[[UILabel alloc]initWithFrame:CGRectMake(5, 78, CellWidth, 40)];
    _supplyDetail.font=[UIFont systemFontOfSize:13];
    [_supplyDetail setLineBreakMode:NSLineBreakByWordWrapping];
    [_supplyDetail setNumberOfLines:0];
    
    [InfoView addSubview:_supplyDetail];
    
    
    _supplyPerson=[[UILabel alloc]initWithFrame:CGRectMake(5, 41, CellWidth, 20)];
    _supplyPerson.font=[UIFont systemFontOfSize:13];
    [InfoView addSubview:_supplyPerson];
    
    _supplyTel=[[UILabel alloc]initWithFrame:CGRectMake(5, 63, CellWidth, 20)];
    _supplyTel.font=[UIFont systemFontOfSize:13];
    //[InfoView addSubview:_supplyTel];
    
    _telLbl=[[stdCallBtn alloc]initWithFrame:CGRectMake(5, 63, CellWidth, 20)];
    [InfoView addSubview:_telLbl];
    
    [self.view addSubview:InfoView];
}

-(void)loadWebView{
    UIWebView *DescView=[[UIWebView alloc]initWithFrame:CGRectMake(0, TopSeachHigh+130, fDeviceWidth, fDeviceHeight-TopSeachHigh-130)];
    [DescView setDelegate:self];
    
    [DescView loadHTMLString:_cellUrl baseURL:nil];
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
    [titleLbl setText:@"商超详情"];
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
