//
//  LiveSrvViewController.m
//  TaoYXNew
//
//  Created by tianan-apple on 15/12/9.
//  Copyright © 2015年 tianan-apple. All rights reserved.
//

#import "LiveSrvViewController.h"
#import "PublicDefine.h"
#import "JZMTBtnView.h"

@interface LiveSrvViewController ()

@end

@implementation LiveSrvViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadLiveButton];
    [self loadTopNavView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setTopTitle:(NSString *)topTitle{
    _topTitle=topTitle;
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
-(void)loadLiveButton{
    _backView1 = [[UIView alloc] initWithFrame:CGRectMake(0, TopSeachHigh, fDeviceWidth, 240)];
    _backView1.backgroundColor=[UIColor whiteColor];
    //创建8个
    NSMutableArray *arr=[[NSMutableArray alloc]initWithObjects:@"话费",@"机票",@"电影票", @"游戏",@"彩票",@"团购",@"酒店",@"水电煤",@"众筹",@"理财",@"礼品卡",@"白条",nil];
    NSMutableArray *imgarr=[[NSMutableArray alloc]initWithObjects:@"stock",@"airTicket",@"ticket", @"stock",@"stock",@"stock",@"spot",@"stock",@"stock",@"ticket",@"ticket",@"ticket",nil];
    
    for (int i = 0; i < 12; i++) {
        if (i < 4) {
            CGRect frame = CGRectMake(i*fDeviceWidth/4-3, -5, fDeviceWidth/4, 80);
            NSString *title =arr[i];//@"测试";
            NSString *imageStr =imgarr[i];//@"icon_homepage_foodCategory.png";
            JZMTBtnView *btnView = [[JZMTBtnView alloc] initWithFrame:frame title:title imageStr:imageStr];
            btnView.tag = 10+i;
            [_backView1 addSubview:btnView];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapBtnView:)];
            [btnView addGestureRecognizer:tap];
            
        }else if(i < 8){
            CGRect frame = CGRectMake((i-4)*fDeviceWidth/4-3, 75, fDeviceWidth/4, 80);
            NSString *title =arr[i];//@"测试1";
            NSString *imageStr =imgarr[i];//@"icon_homepage_foodCategory.png";
            JZMTBtnView *btnView = [[JZMTBtnView alloc] initWithFrame:frame title:title imageStr:imageStr];
            btnView.tag = 10+i;
            [_backView1 addSubview:btnView];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapBtnView:)];
            [btnView addGestureRecognizer:tap];
            
        }
        else {
            CGRect frame = CGRectMake((i-8)*fDeviceWidth/4-3, 155, fDeviceWidth/4, 80);
            NSString *title =arr[i];//@"测试1";
            NSString *imageStr =imgarr[i];//@"icon_homepage_foodCategory.png";
            JZMTBtnView *btnView = [[JZMTBtnView alloc] initWithFrame:frame title:title imageStr:imageStr];
            btnView.tag = 10+i;
            [_backView1 addSubview:btnView];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapBtnView:)];
            [btnView addGestureRecognizer:tap];
            
        }
    }
    [self.view addSubview:_backView1];
}

-(void)OnTapBtnView:(UITapGestureRecognizer *)sender{
    NSLog(@"%d",sender.view.tag);
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
