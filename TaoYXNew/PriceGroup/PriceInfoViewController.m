//
//  PriceInfoViewController.m
//  TaoYXNew
//
//  Created by tianan-apple on 15/12/17.
//  Copyright © 2015年 tianan-apple. All rights reserved.
//

#import "PriceInfoViewController.h"
#import "PlaceTypeViewController.h"
#import "MarketPriceViewController.h"
#import "TraceInfoViewController.h"
#import "PublicDefine.h"

@interface PriceInfoViewController ()
{
    NSMutableArray *lblArr;
    NSMutableArray *viewArr;
    NSMutableArray *lineArr;
    
    UIViewController *currVc;
    PlaceTypeViewController *placeTypeVc;
    MarketPriceViewController *marketPriceVc;
    TraceInfoViewController *traceInfoVc;
    UITabBarController *mytabbar;
}
@end

@implementation PriceInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    lblArr=[[NSMutableArray alloc]init];
    viewArr=[[NSMutableArray alloc]init];
    NSArray *arrtitle=[[NSArray alloc]initWithObjects:@"价格行情", @"市场价格",@"交易分析",nil];
    [self loadTabbar:arrtitle selectedindex:0];
    [self loadTopNavView];
    [self loadAllTableView];
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

-(void)setTopTitle:(NSString *)topTitle{
    _topTitle=topTitle;
}
-(void)setTitleArr:(NSMutableArray *)TitleArr
{
    _TitleArr=TitleArr;
}
-(void)loadAllTableView{
    placeTypeVc=[[PlaceTypeViewController alloc]init];
    [self addChildViewController:placeTypeVc];
    float topHight=TopSeachHigh;
    float tabHight=40;
    [placeTypeVc.view setFrame:CGRectMake(0, topHight, fDeviceWidth, fDeviceHeight-topHight-tabHight)];
    
    marketPriceVc=[[MarketPriceViewController alloc]init];
    [self addChildViewController:marketPriceVc];
    [marketPriceVc.view setFrame:CGRectMake(0, topHight, fDeviceWidth, fDeviceHeight-topHight-tabHight)];
    
    traceInfoVc=[[TraceInfoViewController alloc]init];
    [self addChildViewController:traceInfoVc];
    [traceInfoVc.view setFrame:CGRectMake(0, topHight, fDeviceWidth, fDeviceHeight-topHight-tabHight)];

    [self.view addSubview:placeTypeVc.view];
    currVc=placeTypeVc;
}

-(void)clickleftbtn{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)loadTopNavView{
    
    //float topHight=TopSeachHigh;
    UIView *topView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, TopSeachHigh)];
    topView.backgroundColor=topSearchBgdColor;
    
    UIImageView *backimg=[[UIImageView alloc]initWithFrame:CGRectMake(8, 27, 60, 24)];
    backimg.image=[UIImage imageNamed:@"bar_back"];
    [topView addSubview:backimg];
    //返回按钮
    UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
    [back setFrame:CGRectMake(0, 22, 70, 42)];
    [back addTarget:self action:@selector(clickleftbtn) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:back];
    
    //UIView *navView=[[UIView alloc]initWithFrame:CGRectMake(0, 60, fDeviceWidth, 30)];
    //topNavScrollView=[UIColor whiteColor];
    //标题
    UILabel *titleLbl=[[UILabel alloc]initWithFrame:CGRectMake(fDeviceWidth/2-40, 30, 80, 20)];
    [titleLbl setText:@"价格信息"];
    [titleLbl setTextColor:[UIColor whiteColor]];
    titleLbl.font=[UIFont systemFontOfSize:18];
    [topView addSubview:titleLbl];
    [self.view addSubview:topView];
    
}


//自定义底部tabbar
-(void)loadTabbar:(NSArray*)btn_arr selectedindex:(NSInteger)index{
    UIView *tabbar=[[UIView alloc]initWithFrame:CGRectMake(0, fDeviceHeight-40, fDeviceWidth, 40)];
    float btnwidth=fDeviceWidth/3;
    float lblwidth=0;
    NSString *strtmp=nil;
    for (int i=0; i<3; i++) {
        strtmp=[btn_arr objectAtIndex:i];
        lblwidth=strtmp.length*22.5;
        
        UILabel *btn_txt=[[UILabel alloc]initWithFrame:CGRectMake(10, 8, lblwidth, 25)];
        [btn_txt setText:strtmp];
        UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, btnwidth, 40)];
        btn.tag=i;
        [btn addTarget:self action:@selector(tabClick:) forControlEvents:UIControlEventTouchUpInside];
        
        UIView *btnView=[[UIView alloc]initWithFrame:CGRectMake(btnwidth*i, 0, btnwidth, 40)];
        [btnView addSubview:btn_txt];
        [btnView addSubview:btn];
        btnView.tag=i;
        [viewArr addObject:btnView];
        [lblArr addObject:btn_txt];
        if (index==i) {
            btnView.backgroundColor=[UIColor redColor];
            [btn_txt setTextColor:[UIColor whiteColor]];
        }
        else
        {
            btnView.backgroundColor=[UIColor yellowColor];
            [btn_txt setTextColor:[UIColor blackColor]];
        }
        [tabbar addSubview:btnView];
        //[tabbar addSubview:btn];
    }
    
    //tabbar.backgroundColor=[UIColor redColor];
    [self.view addSubview:tabbar];
}
-(void)tabClick:(UIButton*)sender{
    for (int i=0; i<3; i++)
    {
        UILabel *lbl=(UILabel *)lblArr[i];
        UIView *line=(UIView *)viewArr[i];
        if (i==sender.tag) {
            [lbl setTextColor:[UIColor whiteColor]];
            line.backgroundColor=[UIColor redColor];
        }
        else
        {
            [lbl setTextColor:[UIColor blackColor]];
            line.backgroundColor=[UIColor yellowColor];
        }
    }
    if ((currVc==placeTypeVc &&sender.tag==0)||(currVc==marketPriceVc &&sender.tag==1)||(currVc==traceInfoVc &&sender.tag==2) ){
        return;
    }
    switch (sender.tag) {
        case 0:
            [self replaceController:currVc newController:placeTypeVc];
            break;
        case 1:
            [self replaceController:currVc newController:marketPriceVc];
            break;
        case 2:
            [self replaceController:currVc newController:traceInfoVc];
            break;
        default:
            break;
    }

}
-(void)navClick:(UIButton*)sender{
    for (int i=0; i<_TitleArr.count; i++)
    {
        UILabel *lbl=(UILabel *)lblArr[i];
        UIView *line=(UIView *)lineArr[i];
        if (i==sender.tag) {
            [lbl setTextColor:[UIColor redColor]];
            line.backgroundColor=[UIColor redColor];
        }
        else
        {
            [lbl setTextColor:[UIColor lightGrayColor]];
            line.backgroundColor=[UIColor whiteColor];
        }
    }
    if ((currVc==placeTypeVc &&sender.tag==0)||(currVc==marketPriceVc &&sender.tag==1)||(currVc==traceInfoVc &&sender.tag==2) ){
        return;
    }
    switch (sender.tag) {
        case 0:
            [self replaceController:currVc newController:placeTypeVc];
            break;
        case 1:
            [self replaceController:currVc newController:marketPriceVc];
            break;
        case 2:
            [self replaceController:currVc newController:traceInfoVc];
            break;
        default:
            break;
    }
    
}

- (void)replaceController:(UIViewController *)oldController newController:(UIViewController *)newController
{
    /**
     *			着重介绍一下它
     *  transitionFromViewController:toViewController:duration:options:animations:completion:
     *  fromViewController	  当前显示在父视图控制器中的子视图控制器
     *  toViewController		将要显示的姿势图控制器
     *  duration				动画时间(这个属性,old friend 了 O(∩_∩)O)
     *  options				 动画效果(渐变,从下往上等等,具体查看API)
     *  animations			  转换过程中得动画
     *  completion			  转换完成
     */
    
    [self addChildViewController:newController];
    [self transitionFromViewController:oldController toViewController:newController duration:0.5 options:UIViewAnimationOptionTransitionCrossDissolve animations:nil completion:^(BOOL finished) {
        
        if (finished) {
            
            [newController didMoveToParentViewController:self];
            [oldController willMoveToParentViewController:nil];
            [oldController removeFromParentViewController];
            currVc = newController;
            
        }else{
            
            currVc = oldController;
            
        }
    }];
}


//-(void)SetUpRootView
//{
//    placeTypeVc = [[PlaceTypeViewController alloc]init];
//    placeTypeVc.view.backgroundColor = [UIColor whiteColor];
//    
//    marketPriceVc  = [[MarketPriceViewController alloc]init];
//    marketPriceVc.view.backgroundColor = [UIColor yellowColor];
//    
//    traceInfoVc = [[TraceInfoViewController alloc]init];
//    traceInfoVc.view.backgroundColor = [UIColor blueColor];
//    
//    
//    
//    UINavigationController *place = [[UINavigationController alloc] initWithRootViewController:placeTypeVc];
//    
//    UINavigationController *market = [[UINavigationController alloc] initWithRootViewController:marketPriceVc];
//    
//    UINavigationController *trace = [[UINavigationController alloc] initWithRootViewController:traceInfoVc];
//    
//    mytabbar=[[UITabBarController alloc]init];
//    mytabbar.viewControllers = [NSArray arrayWithObjects:place, market,trace, nil];
//    mytabbar.tabBar.frame=CGRectMake(0, fDeviceHeight-MainTabbarHeight, fDeviceWidth, MainTabbarHeight);
//    
//    
//    for (UINavigationController *stack in mytabbar.viewControllers) {
//        [self setupNavigationBar:stack];
//    }
//
//    mytabbar.tabBar.barStyle=UIBarStyleDefault;
//    mytabbar.tabBar.translucent=false;
//    mytabbar.tabBar.tintColor=tabTxtColor;
//    [self.view addSubview:mytabbar.view];
//    
//}
//
//
//
//- (void)setupNavigationBar:(UINavigationController *)stack{
//    UIImage *barImage = [UIImage imageNamed:@"redtop.png"];
//    if(IOS7_OR_LATER)
//        [stack.navigationBar setBackgroundImage:barImage forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
//    else
//        [stack.navigationBar setBackgroundImage:barImage forBarMetrics:UIBarMetricsDefault];
//    
//}
@end
