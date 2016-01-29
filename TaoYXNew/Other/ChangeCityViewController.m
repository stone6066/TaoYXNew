//
//  ChangeCityViewController.m
//  TaoYXNew
//
//  Created by tianan-apple on 15/12/7.
//  Copyright © 2015年 tianan-apple. All rights reserved.
//

#import "ChangeCityViewController.h"
#import "PublicDefine.h"

@interface ChangeCityViewController ()
{
    NSMutableArray *_tableDataSource;
}
@end

@implementation ChangeCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadTableView];
    [self loadNavTopView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

-(void)setCityType:(NSInteger)cityType
{
    _cityType=cityType;
}
-(void)loadTableView{
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, TopSeachHigh-20, fDeviceWidth, fDeviceHeight-TopSeachHigh+20)];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [self.view addSubview:self.tableView];
    if (1==_cityType) {
        _tableDataSource=[[NSMutableArray alloc]initWithObjects:@"银川",@"石嘴山",@"吴忠",@"固原",@"中卫", nil];

    }
    else
        _tableDataSource=[[NSMutableArray alloc]initWithObjects:@"永宁",@"平罗",@"贺兰",@"青铜峡",@"灵武", @"盐池",@"同心",@"西吉",@"泾源",@"隆德",@"彭阳",@"中宁",@"海原",nil];
    self.tableView.backgroundColor=collectionBgdColor;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tableDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"tableCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    
    cell.textLabel.text = _tableDataSource[indexPath.row];
    
   
    return cell;
    
}

//每行的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell =[self.tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"---%@---cellUrl:",cell.textLabel.text);
    if (self.CityChangeBlock) {
        [self clickleftbtn];
        self.CityChangeBlock(self,cell.textLabel.text);
    }
    
}


- (void)loadNavTopView
{
    UIView *topSearch=[[UIView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, TopSeachHigh)];
    topSearch.backgroundColor=topSearchBgdColor;
    
//    UIImageView *toplogo=[[UIImageView alloc] initWithFrame:CGRectMake(5, 25, 30, 30)];
//    toplogo.image=[UIImage imageNamed:@"topLogo"];
//    [topSearch addSubview:toplogo];
    
    UILabel *viewTitle=[[UILabel alloc]initWithFrame:CGRectMake(fDeviceWidth/2-50, -10, 80, 100)];
    viewTitle.text=@"选择地区";
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
    [topSearch addSubview:back];
    
//    UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
//    back.titleLabel.font = [UIFont boldSystemFontOfSize:13];
//    [back setFrame:CGRectMake(8, 24, 60, 24)];
//    [back setBackgroundImage:[UIImage imageNamed:@"bar_back"] forState:UIControlStateNormal];
//    [back addTarget:self action:@selector(clickleftbtn) forControlEvents:UIControlEventTouchUpInside];
//    [topSearch addSubview:back];
    
    [self.view addSubview:topSearch];
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
