//
//  DetailSupplyViewController.m
//  TaoYXNew
//
//  Created by tianan-apple on 16/1/7.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "DetailSupplyViewController.h"
#import "SupplyModel.h"
#import "PublicDefine.h"
#import "stdCallBtn.h"
#import "GrapListViewController.h"
#import "DPAPI.h"
#import "LoginViewController.h"
#import "stdPubFunc.h"
@interface DetailSupplyViewController ()<UIWebViewDelegate,DPRequestDelegate>

@end

@implementation DetailSupplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadTopNavView];
    [self loadMsgView];
    [self loadMsgInfo:_SupplyData];
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

-(void)setSupplyData:(SupplyModel *)SupplyData{
    _SupplyData=SupplyData;
}



-(void)loadMsgInfo:(SupplyModel*)NModel{
    
    _supplyTitle.text=NModel.supplyType;

    _supplyPerson.text=NModel.name;
    
    _supplyDetail.text=[NSString stringWithFormat:@"%@%@",@"类别：",NModel.brandName];
    
    _supplyTel.text=NModel.phone;
    
    _supplyPrice.text=NModel.supplyPrice;
    
    [_telLbl setLblText:_supplyTel.text];
    
    _cellUrl=NModel.supplyDesc;
}

-(void)loadMsgView{
    float infoViewHeigh=130;
    UIView *InfoView=[[UIView alloc]initWithFrame:CGRectMake(0, TopSeachHigh, fDeviceWidth, infoViewHeigh)];
    CGFloat CellWidth= fDeviceWidth-4;
    
    _supplyTitle=[[UILabel alloc]initWithFrame:CGRectMake(0,0,CellWidth,40)];
    _supplyTitle.font=[UIFont systemFontOfSize:15];
    [_supplyTitle setLineBreakMode:NSLineBreakByWordWrapping];
    [_supplyTitle setNumberOfLines:2];
    [InfoView addSubview:_supplyTitle];
    
    
    
    _supplyDetail=[[UILabel alloc]initWithFrame:CGRectMake(5, 45, CellWidth, 20)];
    _supplyDetail.font=[UIFont systemFontOfSize:13];
    [InfoView addSubview:_supplyDetail];
    
    
    _supplyPerson=[[UILabel alloc]initWithFrame:CGRectMake(5, 65, CellWidth, 20)];
    _supplyPerson.font=[UIFont systemFontOfSize:13];
    [InfoView addSubview:_supplyPerson];
    
    _supplyTel=[[UILabel alloc]initWithFrame:CGRectMake(5, 85, CellWidth, 20)];
    _supplyTel.font=[UIFont systemFontOfSize:13];
    //[InfoView addSubview:_supplyTel];
    
    
    
    _telLbl=[[stdCallBtn alloc]initWithFrame:CGRectMake(5, 105, CellWidth, 20)];
    [InfoView addSubview:_telLbl];
    
    _supplyPrice=[[UILabel alloc]initWithFrame:CGRectMake(5, 85, CellWidth, 20)];
    _supplyPrice.font=[UIFont systemFontOfSize:13];
    [InfoView addSubview:_supplyPrice];
    
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
    [titleLbl setText:@"供求详情"];
    [titleLbl setTextColor:[UIColor whiteColor]];
    titleLbl.font=[UIFont systemFontOfSize:18];
    [topView addSubview:titleLbl];
    
    
    //抢单按钮 不能抢自己发布的
        if([_SupplyData.supplyType rangeOfString:@"【求购】"].location !=NSNotFound){
            UILabel *qdLbl=[[UILabel alloc]initWithFrame:CGRectMake(fDeviceWidth-50, 30, 70, 20)];
            [qdLbl setText:@"抢单"];
            [qdLbl setTextColor:[UIColor whiteColor]];
            qdLbl.font=[UIFont systemFontOfSize:18];
            [topView addSubview:qdLbl];
        
            UIButton *qdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [qdBtn setFrame:CGRectMake(fDeviceWidth-70, 22, 70, 42)];
            [qdBtn addTarget:self action:@selector(clickqdbtn) forControlEvents:UIControlEventTouchUpInside];
            [topView addSubview:qdBtn];
        }
    
    [self.view addSubview:topView];
    
}
-(void)clickqdbtn{
//    GrapListViewController *shortCutView=[[GrapListViewController alloc]init];
//    shortCutView.hidesBottomBarWhenPushed=YES;
//    shortCutView.navigationItem.hidesBackButton=YES;
//    shortCutView.view.backgroundColor = [UIColor whiteColor];
//    [shortCutView setSupplyId:_SupplyData.supplyId];
//    [self.navigationController pushViewController:shortCutView animated:YES];
    [self createLoginRequest];

}
-(void)clickleftbtn{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)loadLoginView{
    LoginViewController *shortCutView=[[LoginViewController alloc]init];
    shortCutView.hidesBottomBarWhenPushed=YES;
    shortCutView.navigationItem.hidesBackButton=YES;
    
    
    [shortCutView setWeburl:[NSString stringWithFormat:@"%@%@",MainUrl,@"nst/jumpmobilelogin.htm"]];
    [shortCutView setTopTitle:@"登录"];
    shortCutView.LoginFlagBlock = ^(LoginViewController *LoginView,NSInteger loginFlag){
        [LoginView dismissViewControllerAnimated:NO completion:nil];
//        if (loginFlag==1) {
//            [self loadLoginView];
//        }
    };
    shortCutView.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:shortCutView animated:YES];
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
        if ([_SupplyData.pubId isEqualToString:[stdPubFunc readUserUid]])
        {
            [stdPubFunc stdShowMessage:@"不能抢单自己发布的供求"];
        }
        else
            [self popPubPriceView];
    }
    else
    {
    
        [self loadLoginView];
    }
}

-(void)popPubPriceView{
    GrapListViewController *shortCutView=[[GrapListViewController alloc]init];
    shortCutView.hidesBottomBarWhenPushed=YES;
    shortCutView.navigationItem.hidesBackButton=YES;
    shortCutView.view.backgroundColor = [UIColor whiteColor];
    [shortCutView setSupplyId:_SupplyData.supplyId];
    [self.navigationController pushViewController:shortCutView animated:YES];
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
