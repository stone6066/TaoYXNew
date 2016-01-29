//
//  MyPublicViewController.m
//  TaoYXNew
//
//  Created by tianan-apple on 16/1/19.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "MyPublicViewController.h"
#import "PublicDefine.h"
#import "MySupplyInfoViewController.h"
#import "MyPubCarViewController.h"
#import "MyPubGoodsViewController.h"
#import "MyPubPriceViewController.h"
#import "MySupplyOrderViewController.h"

@interface MyPublicViewController ()
{
    NSMutableArray *_tableDataSource;
}
@end

@implementation MyPublicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadNavTopView];
    [self loadTableView];
    [self stdRightGesture];
    // Do any additional setup after loading the view.
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

- (void)loadNavTopView
{
    UIView *topSearch=[[UIView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, TopSeachHigh)];
    topSearch.backgroundColor=topSearchBgdColor;
    
    UILabel *viewTitle=[[UILabel alloc]initWithFrame:CGRectMake(fDeviceWidth/2-40, -10, 80, 100)];
    viewTitle.text=@"我的发布";
    [viewTitle setTextColor:[UIColor whiteColor]];
    [viewTitle setFont:[UIFont systemFontOfSize:20]];
    [topSearch addSubview:viewTitle];
    
    UIImageView *backimg=[[UIImageView alloc]initWithFrame:CGRectMake(8, 24, 60, 24)];
    backimg.image=[UIImage imageNamed:@"bar_back"];
    [topSearch addSubview:backimg];
    //返回按钮
    UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
    [back setFrame:CGRectMake(0, 22, 70, 42)];
    [back addTarget:self action:@selector(clickleftbtn) forControlEvents:UIControlEventTouchUpInside];
    //back.backgroundColor=[UIColor yellowColor];
    [topSearch addSubview:back];
    
    [self.view addSubview:topSearch];
}

-(void)clickleftbtn{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)loadTableView{
    
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, TopSeachHigh, fDeviceWidth, fDeviceHeight-TopSeachHigh)];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.tableFooterView = [[UIView alloc]init];
    //self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    _tableDataSource=[[NSMutableArray alloc]initWithObjects:@"供求信息",@"我的报价",@"车源信息",@"货源信息",@"产地报价", nil];
    
    
    //self.tableView.backgroundColor=collectionBgdColor;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tableDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"MyInfotableCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    UIImageView* cellImg =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_filter_arrow@2x"]];
    cell.accessoryView=cellImg;
    cell.textLabel.text = _tableDataSource[indexPath.row];
    
    
    return cell;
    
}

//每行的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0://我的供应信息
            [self popMyPublicSupplyView];
            break;
        case 1://我的报价
            [self popMySupplyOrderView];
            break;
        case 2://我的车源信息
            [self popMyPublicCarView];
            break;
        case 3://我的货源信息
            [self popMyPublicGoodsView];
            break;
        case 4://产地报价
            [self popMyPublicPriceView];
            break;
        default:
            break;
    }
    
}

-(void)popMyPublicSupplyView{
    MySupplyInfoViewController *LiveView=[[MySupplyInfoViewController alloc]init];
    LiveView.hidesBottomBarWhenPushed=YES;
    LiveView.navigationItem.hidesBackButton=YES;
    LiveView.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:LiveView animated:YES];
}

-(void)popMyPublicCarView{
    MyPubCarViewController *LiveView=[[MyPubCarViewController alloc]init];
    LiveView.hidesBottomBarWhenPushed=YES;
    LiveView.navigationItem.hidesBackButton=YES;
    LiveView.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:LiveView animated:YES];
}

-(void)popMyPublicGoodsView{
    MyPubGoodsViewController *LiveView=[[MyPubGoodsViewController alloc]init];
    LiveView.hidesBottomBarWhenPushed=YES;
    LiveView.navigationItem.hidesBackButton=YES;
    LiveView.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:LiveView animated:YES];
}

-(void)popMyPublicPriceView{
    MyPubPriceViewController *LiveView=[[MyPubPriceViewController alloc]init];
    LiveView.hidesBottomBarWhenPushed=YES;
    LiveView.navigationItem.hidesBackButton=YES;
    LiveView.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:LiveView animated:YES];
}

-(void)popMySupplyOrderView{
    MySupplyOrderViewController *LiveView=[[MySupplyOrderViewController alloc]init];
    LiveView.hidesBottomBarWhenPushed=YES;
    LiveView.navigationItem.hidesBackButton=YES;
    LiveView.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:LiveView animated:YES];
}

@end
