//
//  TopNavViewController.m
//  TaoYXNew
//
//  Created by tianan-apple on 15/12/8.
//  Copyright © 2015年 tianan-apple. All rights reserved.
//

#import "TopNavViewController.h"
#import "PublicDefine.h"
#import "DPAPI.h"
#import "MJRefresh.h"
#import "NavTableViewCell.h"
//#import "NavModel.h"

#import "SupplyTableViewCell.h"
//#import "dealModel.h"
#import "SupplyViewController.h"
#import "ShopListViewController.h"
#import "OrderListViewController.h"

@interface TopNavViewController ()
{
    NSMutableArray *lblArr;
    NSMutableArray *lineArr;
    UIScrollView *topNavScrollView;
    SupplyViewController *supplyVc;
    ShopListViewController *shopVc;
    OrderListViewController *orderVc;
    UIViewController *currVc;
}
@end

@implementation TopNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    lblArr=[[NSMutableArray alloc]init];
    lineArr=[[NSMutableArray alloc]init];
    [self loadTopNavView:0 buttonArr:_TitleArr];
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
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
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
-(void)setViewType:(NSInteger)viewType
{
    _viewType=viewType;
}
-(void)clickleftbtn{
    [self.navigationController popViewControllerAnimated:YES];
}

//顶部导航条
-(void)loadTopNavView:(NSInteger)selectIndex buttonArr:(NSArray*)buttonList{
    if (topNavScrollView == nil)
    {
        topNavScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 60, fDeviceWidth, 30)];
        topNavScrollView.showsHorizontalScrollIndicator = NO;
    }
    topNavScrollView.backgroundColor=[UIColor whiteColor];
    UIView *topView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, NavTopHight)];
    topView.backgroundColor=topSearchBgdColor;
//    UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
//    //返回按钮
//    [back setFrame:CGRectMake(8, 27, 60, 24)];
//    [back setBackgroundImage:[UIImage imageNamed:@"bar_back"] forState:UIControlStateNormal];
//    [back addTarget:self action:@selector(clickleftbtn) forControlEvents:UIControlEventTouchUpInside];
//    [topView addSubview:back];
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
    [titleLbl setText:_topTitle];
    [titleLbl setTextColor:[UIColor whiteColor]];
    titleLbl.font=[UIFont systemFontOfSize:18];
    [topView addSubview:titleLbl];
    
    float btnWidth=0;
    float scrollWidth=0;
    float selLineWidth=0;
    NSString *txtTmp=nil;
    //顶部按钮
    for (int i=0; i<buttonList.count; i++) {
        txtTmp=[buttonList objectAtIndex:i];
        btnWidth=txtTmp.length*22.5;
       
        UIButton *navBtn=[[UIButton alloc]initWithFrame:CGRectMake(scrollWidth, 0, btnWidth, 30)];
        //navBtn.backgroundColor=[UIColor redColor];
        UILabel *navLbl=[[UILabel alloc]initWithFrame:CGRectMake(scrollWidth+5, 0, btnWidth, 30)];
        selLineWidth=txtTmp.length*17.5;
        UIView *selectedLine=[[UIView alloc]initWithFrame:CGRectMake(scrollWidth+5, 28, selLineWidth, 2)];
         scrollWidth+=btnWidth;
        
        navLbl.text=txtTmp;
        
        if (i==selectIndex)
        {
            [navLbl setTextColor:[UIColor redColor]];
            selectedLine.backgroundColor=[UIColor redColor];
        }
        else
        {
            [navLbl setTextColor:[UIColor lightGrayColor]];
            selectedLine.backgroundColor=[UIColor whiteColor];
        }
        [topNavScrollView addSubview:navLbl];
        [topNavScrollView addSubview:navBtn];
        navBtn.tag=i;
        [lblArr addObject:navLbl];
        [lineArr addObject:selectedLine];
        [topNavScrollView addSubview:selectedLine];
        
        [navBtn addTarget:self action:@selector(navClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    [topNavScrollView setContentSize:CGSizeMake(scrollWidth, 30)];
    [topView addSubview:topNavScrollView];
    [self.view addSubview:topView];
    
}
-(void)loadAllTableView{
    supplyVc=[[SupplyViewController alloc]init];
    [self addChildViewController:supplyVc];
    [supplyVc.view setFrame:CGRectMake(0, NavTopHight, fDeviceWidth, fDeviceHeight-NavTopHight)];
    
    shopVc=[[ShopListViewController alloc]init];
    [self addChildViewController:shopVc];
    [shopVc.view setFrame:CGRectMake(0, NavTopHight, fDeviceWidth, fDeviceHeight-NavTopHight)];
    
    orderVc=[[OrderListViewController alloc]init];
    [self addChildViewController:orderVc];
    [orderVc.view setFrame:CGRectMake(0, NavTopHight, fDeviceWidth, fDeviceHeight-NavTopHight)];
    
    
    [self.view addSubview:supplyVc.view];
    currVc=supplyVc;
}

-(void)navClick:(UIButton*)sender{
    //UILabel *lbl=(UILabel *)lblArr[sender.tag];
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
    if ((currVc==supplyVc &&sender.tag==0)||(currVc==shopVc &&sender.tag==1)||(currVc==orderVc &&sender.tag==2) ){
        return;
    }
    switch (sender.tag) {
        case 0:
            [self replaceController:currVc newController:supplyVc];
            break;
        case 1:
            [self replaceController:currVc newController:shopVc];
            break;
        case 2:
            [self replaceController:currVc newController:orderVc];
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

@end
