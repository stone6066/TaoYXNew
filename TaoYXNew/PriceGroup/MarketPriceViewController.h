//
//  MarketPriceViewController.h
//  TaoYXNew
//
//  Created by tianan-apple on 15/12/17.
//  Copyright © 2015年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MarketPriceViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,copy)NSString *topTitle;
@property(nonatomic,copy)NSMutableArray *TitleArr;
@property(nonatomic,strong)UITableView *TableView;
@property(nonatomic,strong)UIButton *topBtn;
@property(nonatomic,assign)NSInteger btnIndex;//顶部导航条索引
@property(nonatomic,copy)NSMutableArray *qryCode;//城市代码和类别代码

@end
