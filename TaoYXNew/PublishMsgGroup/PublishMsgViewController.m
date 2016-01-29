//
//  PublishMsgViewController.m
//  TaoYXNew
//
//  Created by tianan-apple on 16/1/8.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "PublishMsgViewController.h"
#import "PublicDefine.h"
#import "DetailPubPriceViewController.h"
#import "DetailPubExpViewController.h"
#import "DetailPubSupplyViewController.h"
#import "DetailPubShopViewController.h"
#import "DPAPI.h"
#import "LoginViewController.h"

@interface PublishMsgViewController ()<DPRequestDelegate>
{
    NSMutableArray *_tableDataSource;
    NSInteger selectedIndex;
}
@end

@implementation PublishMsgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadNavTopView];
    [self loadTableView];
    // Do any additional setup after loading the view.
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

-(void)setShowType:(NSInteger)showType{
    _showType=showType;
}
-(void)loadTableView{
    
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, TopSeachHigh, fDeviceWidth, fDeviceHeight-TopSeachHigh)];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.tableFooterView = [[UIView alloc]init];
    //self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    if (_showType==0) {//农村版
         _tableDataSource=[[NSMutableArray alloc]initWithObjects:@"发布餐企商超",@"发布价格行情",@"发布物流消息",@"发布供求信息", nil];
    }
    else{
        _tableDataSource=[[NSMutableArray alloc]initWithObjects:@"发布价格行情",@"发布物流消息",@"发布供求信息", nil];
    }
   
    //self.tableView.backgroundColor=collectionBgdColor;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tableDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"MsgtableCell";
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

-(void)popPubShopView{
    DetailPubShopViewController *LiveView=[[DetailPubShopViewController alloc]init];
    LiveView.hidesBottomBarWhenPushed=YES;
    LiveView.navigationItem.hidesBackButton=YES;
     LiveView.view.backgroundColor = [UIColor whiteColor];
    
    [self.navigationController pushViewController:LiveView animated:YES];
}

-(void)popPubPriceView{
    DetailPubPriceViewController *LiveView=[[DetailPubPriceViewController alloc]init];
    LiveView.hidesBottomBarWhenPushed=YES;
    LiveView.navigationItem.hidesBackButton=YES;
     LiveView.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:LiveView animated:YES];
}

-(void)popPubExpView{
    DetailPubExpViewController *LiveView=[[DetailPubExpViewController alloc]init];
    LiveView.hidesBottomBarWhenPushed=YES;
    LiveView.navigationItem.hidesBackButton=YES;
    [LiveView setDetailId:@""];
     LiveView.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:LiveView animated:YES];
}

-(void)popPubSupplyView{
    DetailPubSupplyViewController *LiveView=[[DetailPubSupplyViewController alloc]init];
    LiveView.hidesBottomBarWhenPushed=YES;
    LiveView.navigationItem.hidesBackButton=YES;
    LiveView.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:LiveView animated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //UITableViewCell *cell =[self.tableView cellForRowAtIndexPath:indexPath];
    selectedIndex=indexPath.row;
    if (indexPath.row<4) {
        [self createLoginRequest];
    }

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
        if (_showType==0) {//农村版
            switch (selectedIndex) {
                case 0:
                    [self popPubShopView];
                    break;
                case 1:
                    [self popPubPriceView];
                    break;
                case 2:
                    [self popPubExpView];
                    break;
                case 3:
                    [self popPubSupplyView];
                    break;
                default:
                    break;
            }
        }
        else{
            switch (selectedIndex) {
                case 0:
                    NSLog(@"价格");
                    break;
                case 1:
                    NSLog(@"物流");
                    break;
                case 2:
                    NSLog(@"供求");
                    break;
                default:
                    break;
            }
        }
    }
    else
    {
        [self loadLoginView];
    }
}

-(void)loadLoginView{
    LoginViewController *shortCutView=[[LoginViewController alloc]init];
    shortCutView.hidesBottomBarWhenPushed=YES;
    shortCutView.navigationItem.hidesBackButton=YES;
    
    
    [shortCutView setWeburl:[NSString stringWithFormat:@"%@%@",MainUrl,@"nst/jumpmobilelogin.htm"]];
    [shortCutView setTopTitle:@"登录"];
    shortCutView.LoginFlagBlock = ^(LoginViewController *LoginView,NSInteger loginFlag){
        [LoginView dismissViewControllerAnimated:NO completion:nil];
        if (loginFlag==1) {
            
        }
    };
    shortCutView.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:shortCutView animated:YES];
}


- (void)loadNavTopView
{
    UIView *topSearch=[[UIView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, TopSeachHigh)];
    topSearch.backgroundColor=topSearchBgdColor;
    
    UILabel *viewTitle=[[UILabel alloc]initWithFrame:CGRectMake(fDeviceWidth/2-80, 20, 200, 40)];
    viewTitle.text=@"选择发布信息类型";
    [viewTitle setTextColor:[UIColor whiteColor]];
    [viewTitle setFont:[UIFont systemFontOfSize:16]];
    [topSearch addSubview:viewTitle];
    
    UIImageView *backimg=[[UIImageView alloc]initWithFrame:CGRectMake(8, 24, 60, 24)];
    backimg.image=[UIImage imageNamed:@"bar_back"];
    [topSearch addSubview:backimg];
    //返回按钮
    UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
    [back setFrame:CGRectMake(0, 22, 70, 42)];
    [back addTarget:self action:@selector(clickleftbtn) forControlEvents:UIControlEventTouchUpInside];
    [topSearch addSubview:back];
    
    [self.view addSubview:topSearch];
}

-(void)clickleftbtn{
    [self.navigationController popViewControllerAnimated:YES];
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}
@end
