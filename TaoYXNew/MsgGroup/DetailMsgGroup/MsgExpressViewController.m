//
//  MsgExpressViewController.m
//  TaoYXNew
//
//  Created by tianan-apple on 16/1/6.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "MsgExpressViewController.h"
#import "PublicDefine.h"
#import "MsgExpressDeal.h"
#import "DPAPI.h"

@interface MsgExpressViewController ()<DPRequestDelegate,UIWebViewDelegate>

@end

@implementation MsgExpressViewController

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

-(void)setMsgId:(NSString *)msgId{
    _msgId=msgId;
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
    [titleLbl setText:@"物流详情"];
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
    [params setValue:@"loginfodetail" forKey:@"ut"];
    [params setValue:_msgId forKey:@"id"];
    [api setAllwaysFlash:@"1"];
    [api requestWithURL:NetUrl params:params delegate:self];
}

-(void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result
{
    // NSLog(@"响应：%@",result);
    MsgExpressDeal *dm;
    NSArray *datatmp;
    NSDictionary *dict = result;
    dm= [[MsgExpressDeal alloc]init];
    datatmp=[dm asignModelWithDict:dict];
    
    [self loadMsgView];
    if (datatmp.count>0) {
        [self loadMsgInfo:datatmp[0]];
    }

    
}
-(void)request:(DPRequest *)request didFailWithError:(NSError *)error
{
    NSLog(@"报错了：%@",error);
}



-(void)loadMsgInfo:(MsgExpressDeal*)SM{
    
    _logInfoType.text=[NSString stringWithFormat:@"%@%@",@"类型：",SM.logInfoType];
    if ([SM.logInfoType isEqualToString:@"车源"]) {
        _detailDesc.text=[NSString stringWithFormat:@"%@%@%@%@%@%@%@%@",@"车型：",SM.vehicleType,@"车长：",SM.vehicleLength,@"米，载重：",SM.vehicleLoad,@"吨，车牌：",SM.carCode];
    }
    else{
        _detailDesc.text=[NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@",@"种类：",SM.goodsType,@"，名称：",SM.goodsName,@"，体积：",SM.goodsVolume,@"m³，重量：",SM.goodsWeight,@"吨"];
    }
    _startPlace.text=[NSString stringWithFormat:@"%@%@%@%@",@"出发地：",SM.startProvince,SM.startCity,SM.startCounty];
    _endPlace.text=[NSString stringWithFormat:@"%@%@%@%@",@"目的地：",SM.endProvicen,SM.endCity,SM.endCounty];
    _customerName.text=[NSString stringWithFormat:@"%@%@",@"联系人：",SM.customerName];
    _telphone.text=[NSString stringWithFormat:@"%@%@",@"电 话：",SM.telphone];
    _sendTime.text=[NSString stringWithFormat:@"%@%@",@"出发时间：",SM.sendTime];
    _createTime.text=[NSString stringWithFormat:@"%@%@",@"发布时间：",SM.createTime];
}

-(void)loadMsgView{
    float infoViewHeigh=120;
    UIView *InfoView=[[UIView alloc]initWithFrame:CGRectMake(0, TopSeachHigh, fDeviceWidth, infoViewHeigh)];
    CGFloat CellWidth= fDeviceWidth-14;
   
    _logInfoType=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 120, 20)];
    _logInfoType.font=[UIFont systemFontOfSize:13];
    [InfoView addSubview:_logInfoType];
    
    _detailDesc=[[UILabel alloc]initWithFrame:CGRectMake(10,20,CellWidth,40)];
    _detailDesc.font=[UIFont systemFontOfSize:13];
    [_detailDesc setLineBreakMode:NSLineBreakByWordWrapping];
    [_detailDesc setNumberOfLines:2];
    [InfoView addSubview:_detailDesc];
    
    _startPlace=[[UILabel alloc]initWithFrame:CGRectMake(10, 70, CellWidth, 20)];
    _startPlace.font=[UIFont systemFontOfSize:13];
    [InfoView addSubview:_startPlace];
    
    _endPlace=[[UILabel alloc]initWithFrame:CGRectMake(10, 110, CellWidth, 20)];
    _endPlace.font=[UIFont systemFontOfSize:13];
    [InfoView addSubview:_endPlace];
    
    _customerName=[[UILabel alloc]initWithFrame:CGRectMake(10, 150, CellWidth, 20)];
    _customerName.font=[UIFont systemFontOfSize:13];
    [InfoView addSubview:_customerName];
    
    _telphone=[[UILabel alloc]initWithFrame:CGRectMake(10, 190, CellWidth, 20)];
    _telphone.font=[UIFont systemFontOfSize:13];
    [InfoView addSubview:_telphone];
    
    _sendTime=[[UILabel alloc]initWithFrame:CGRectMake(10, 230, CellWidth, 20)];
    _sendTime.font=[UIFont systemFontOfSize:13];
    [InfoView addSubview:_sendTime];
    
    _createTime=[[UILabel alloc]initWithFrame:CGRectMake(10, 270, CellWidth, 20)];
    _createTime.font=[UIFont systemFontOfSize:13];
    [InfoView addSubview:_createTime];
    
    [self.view addSubview:InfoView];
    
    
    
    
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
