//
//  PopViewController.m
//  团购项目
//
//  Created by lb on 15/5/27.
//  Copyright (c) 2015年 lbcoder. All rights reserved.
//

#import "PopViewController.h"
#import "popView.h"
#import "CategoriyModel.h"
#import "PublicDefine.h"

@interface PopViewController ()<MyPopviewDataSource,MyPopviewDelegate>{
    CategoriyModel *_seletedModel;
}

@end

@implementation PopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadTopNavView];
    popView *pop = [popView makePopView];
    
    [pop setFrame:CGRectMake(0, TopSeachHigh, fDeviceWidth, fDeviceHeight-TopSeachHigh)];
    [self.view addSubview:pop];
    pop.dataSource = self;
    pop.delegate = self;
    pop.autoresizingMask = UIViewAutoresizingNone;
    self.preferredContentSize = CGSizeMake(pop.frame.size.width, pop.frame.size.height);
    NSArray *categoryArr = [self getData];
    _seletedModel = categoryArr[0];
}
-(void)setDataType:(NSInteger)dataType{
    _dataType=dataType;
}
//获取到 第一个分类数据下拉菜单的模型数组
- (NSArray *)getData{
    CategoriyModel *md = [[CategoriyModel alloc]init];
    NSArray *categorieyArray = [md loadPlistData:_dataType];
    return categorieyArray;
}

#pragma mark -topnav
-(void)clickleftbtn{
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark - popview dataSource
- (NSInteger)numberOfRowsInLeftTable:(popView *)popView{
    return [self getData].count;
}

- (NSString *)popView:(popView *)popView titleForRow:(int)row{
    return [[self getData][row]name];
}

//- (NSString *)popView:(popView *)popView imageForRow:(int)row{
//    return [[self getData][row]small_icon];
//}

- (NSArray *)popView:(popView *)popView subDataForRow:(int)row{
    if (_dataType==0) {//地区
        return [[self getData][row]subcategories];
    }
    else//分类
    {
        NSArray *subDict=[[self getData][row]subcategories];
        NSMutableArray *subArr=[[NSMutableArray alloc]init];
        NSString *subName;
        for (NSDictionary *dict in subDict) {
            subName=[dict objectForKey:@"name"];
            [subArr addObject:subName];
        }
        return subArr;
    }
   
}

- (NSArray *)popView:(popView *)popView rightSubDataForRow:(int)row{
    NSArray *subDict=[[self getData][row]subcategories];
    NSMutableArray *subArr=[[NSMutableArray alloc]init];
    NSString *subName;
    for (NSDictionary *dict in subDict) {
        subName=[dict objectForKey:@"name"];
        [subArr addObject:subName];
    }
    
    return subArr;
}
#pragma mark - popview delegate
- (void)popView:(popView *)popView didSelectRowAtLeftTable:(int)row{
    //选择了popview的左侧表格
    NSArray *categoryArr = [self getData];
    //NSString *subDict=[[self getData][row]dataid];
  
    _seletedModel = categoryArr[row];
    
     //NSLog(@"%@",_seletedModel.name) ;
    //有没有子数据
    if (!_seletedModel.subcategories.count) {
        if (self.TypeChangeBlock) {
            [self clickleftbtn];
            if (_dataType==1) {
                self.TypeChangeBlock(self,_seletedModel.name,_seletedModel.dataid,1);
            }
            else
            {
                if (row==0) {
                    self.TypeChangeBlock(self,_seletedModel.name,@"0",0);
                }
                else
                    self.TypeChangeBlock(self,_seletedModel.name,@"2",0);
            }
            
        }
    }
}

- (void)popView:(popView *)popView didSelectRowAtRightTable:(int)row{
    NSArray *subArr = _seletedModel.subcategories;
   
    if (self.TypeChangeBlock) {
        [self clickleftbtn];
        if (_dataType==1) {
            if(0==row){//全部的时候返回上一级名称
                self.TypeChangeBlock(self,_seletedModel.name,_seletedModel.dataid,1);
            }
            else
            {
                NSDictionary *dict=subArr[row];
                NSString *cellId=[[dict objectForKey:@"id"]stringValue];
                NSString *cellName=[dict objectForKey:@"name"];
                self.TypeChangeBlock(self,cellName,cellId,0);
            }
        
        }
        else{
        if(0==row){//全部的时候返回上一级名称
            self.TypeChangeBlock(self,_seletedModel.name,@"2",0);//区域查询的时候带着level＝2
        }
        else
            self.TypeChangeBlock(self,subArr[row],@"0",0);
        }
    }
}


-(void)loadTopNavView{
    
    float topHight=TopSeachHigh;
    UIView *topView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, topHight)];
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
    if (0==_dataType) {
        [titleLbl setText:@"选择区域"];
    }
    else
        [titleLbl setText:@"选择分类"];
    
    [titleLbl setTextColor:[UIColor whiteColor]];
    titleLbl.font=[UIFont systemFontOfSize:18];
    [topView addSubview:titleLbl];
    [self.view addSubview:topView];
    
}
@end
