//
//  ExpressViewController.m
//  TaoYXNew
//
//  Created by tianan-apple on 15/12/16.
//  Copyright © 2015年 tianan-apple. All rights reserved.
//

#import "ExpressViewController.h"
#import "PublicDefine.h"
#import "CarInfoViewController.h"
#import "GoodsInfoViewController.h"
#import "LocalInternationViewController.h"
#import "LocalLongViewController.h"
#import "LocalStationViewController.h"
//#import "MySendInfoViewController.h"

@interface ExpressViewController ()
{
    NSMutableArray *lblArr;
    NSMutableArray *lineArr;
    UIScrollView *topNavScrollView;
    UIViewController *currVc;
    CarInfoViewController *carInfoVc;
    GoodsInfoViewController *goodsInfoVc;
    LocalInternationViewController *internationVc;
    LocalLongViewController *longVc;
    LocalStationViewController *stationVc;
    //MySendInfoViewController *mySendVc;
}
@end

@implementation ExpressViewController

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
    float topNavH=NavTopHight+5;
    if (topNavScrollView == nil)
    {
        topNavScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, TopSeachHigh, fDeviceWidth, 30)];
        topNavScrollView.showsHorizontalScrollIndicator = NO;
    }
    topNavScrollView.backgroundColor=[UIColor whiteColor];
    UIView *topView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, topNavH)];
    topView.backgroundColor=topSearchBgdColor;
   
    
    UIImageView *backimg=[[UIImageView alloc]initWithFrame:CGRectMake(8, 24, 60, 24)];
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
        UILabel *navLbl=[[UILabel alloc]initWithFrame:CGRectMake(scrollWidth+5, -2, btnWidth, 30)];
        selLineWidth=txtTmp.length*17.5;
        UIView *selectedLine=[[UIView alloc]initWithFrame:CGRectMake(scrollWidth+5, 23, selLineWidth, 2)];
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
    carInfoVc=[[CarInfoViewController alloc]init];
    [self addChildViewController:carInfoVc];
    [carInfoVc.view setFrame:CGRectMake(0, NavTopHight, fDeviceWidth, fDeviceHeight-NavTopHight)];
    
    goodsInfoVc=[[GoodsInfoViewController alloc]init];
    [self addChildViewController:goodsInfoVc];
    [goodsInfoVc.view setFrame:CGRectMake(0, NavTopHight, fDeviceWidth, fDeviceHeight-NavTopHight)];
    
    stationVc=[[LocalStationViewController alloc]init];
    [self addChildViewController:stationVc];
    [stationVc.view setFrame:CGRectMake(0, NavTopHight, fDeviceWidth, fDeviceHeight-NavTopHight)];
    
    longVc=[[LocalLongViewController alloc]init];
    [self addChildViewController:longVc];
    [longVc.view setFrame:CGRectMake(0, NavTopHight, fDeviceWidth, fDeviceHeight-NavTopHight)];
    
    internationVc=[[LocalInternationViewController alloc]init];
    [self addChildViewController:internationVc];
    [internationVc.view setFrame:CGRectMake(0, NavTopHight, fDeviceWidth, fDeviceHeight-NavTopHight)];
    
//    mySendVc=[[MySendInfoViewController alloc]init];
//    [self addChildViewController:mySendVc];
//    [mySendVc.view setFrame:CGRectMake(0, NavTopHight, fDeviceWidth, fDeviceHeight-NavTopHight)];
    
    [self.view addSubview:carInfoVc.view];
    currVc=carInfoVc;
}

-(void)navClick:(UIButton*)sender{
   // NSLog(@"_viewType:%ld,sender:%ld",_viewType,sender.tag);
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
    //||(currVc==mySendVc &&sender.tag==5)
    if ((currVc==carInfoVc &&sender.tag==0)||(currVc==goodsInfoVc &&sender.tag==1)||(currVc==stationVc &&sender.tag==2) ||(currVc==longVc &&sender.tag==3)||(currVc==internationVc &&sender.tag==4)){
        return;
    }
    switch (sender.tag) {
        case 0:
            [self replaceController:currVc newController:carInfoVc];
            break;
        case 1:
            [self replaceController:currVc newController:goodsInfoVc];
            break;
        case 2:
            [self replaceController:currVc newController:stationVc];
            break;
        case 3:
            [self replaceController:currVc newController:longVc];
            break;
        case 4:
            [self replaceController:currVc newController:internationVc];
            break;
//        case 5:
//            [self replaceController:currVc newController:mySendVc];
//            break;
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
