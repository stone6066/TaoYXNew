//
//  TimeSelectViewController.m
//  TaoYXNew
//
//  Created by tianan-apple on 15/12/21.
//  Copyright © 2015年 tianan-apple. All rights reserved.
//

#import "TimeSelectViewController.h"
#import "PublicDefine.h"

@interface TimeSelectViewController ()
{
    NSMutableArray *_tableDataSource;
}
@end

@implementation TimeSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadNavTopView];
    [self loadTableView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)loadNavTopView
{
    UIView *topSearch=[[UIView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, TopSeachHigh)];
    topSearch.backgroundColor=topSearchBgdColor;
    
    //    UIImageView *toplogo=[[UIImageView alloc] initWithFrame:CGRectMake(5, 25, 30, 30)];
    //    toplogo.image=[UIImage imageNamed:@"topLogo"];
    //    [topSearch addSubview:toplogo];
    
    UILabel *viewTitle=[[UILabel alloc]initWithFrame:CGRectMake(fDeviceWidth/2-50, -10, 80, 100)];
    viewTitle.text=@"选择时间";
    [viewTitle setTextColor:[UIColor whiteColor]];
    [viewTitle setFont:[UIFont systemFontOfSize:20]];
    [topSearch addSubview:viewTitle];
    
//    UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
//    back.titleLabel.font = [UIFont boldSystemFontOfSize:13];
//    
//    [back setFrame:CGRectMake(8, 24, 60, 24)];
//    [back setBackgroundImage:[UIImage imageNamed:@"bar_back"] forState:UIControlStateNormal];
//    [back addTarget:self action:@selector(clickleftbtn) forControlEvents:UIControlEventTouchUpInside];
//    [topSearch addSubview:back];
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

//获取距离今天指定天数的日期days=-1,取昨天日期，days＝1，取明天的日期
-(NSString *)getDayOfToday:(NSInteger)days{
    NSDateFormatter *formater=[[NSDateFormatter alloc]init];
    [formater setDateFormat:@"yyyy-MM-dd"];
    NSDate *dd=[NSDate dateWithTimeIntervalSinceNow:3600*24*days];
    NSString *datetime=[formater stringFromDate:dd];
    return datetime;
}

#pragma mark loadTableView
-(void)loadTableView{
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, TopSeachHigh, fDeviceWidth, fDeviceHeight-TopSeachHigh)];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [self.view addSubview:self.tableView];
    _tableDataSource=[[NSMutableArray alloc]init];
    [_tableDataSource addObject:@"全部"];
    for (int i=0; i<30; i++) {
        [_tableDataSource addObject:[self getDayOfToday:0-i]];
    }
    //_tableDataSource=[[NSMutableArray alloc]initWithObjects:@"青铜峡",@"灵武",@"永宁",@"贺兰",@"平罗", @"盐池",@"同心",@"西吉",@"泾源",@"隆德",@"彭阳",@"中宁",@"海原",nil];
    self.tableView.backgroundColor=collectionBgdColor;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tableDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"timetableCell";
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
    if (self.TimeChangeBlock) {
        [self clickleftbtn];
        self.TimeChangeBlock(self,cell.textLabel.text);
    }
    
}
@end
