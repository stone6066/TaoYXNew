//
//  ChangeCityViewController.h
//  TaoYXNew
//
//  Created by tianan-apple on 15/12/7.
//  Copyright © 2015年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangeCityViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView* tableView;
@property(nonatomic,assign)NSInteger cityType;
@property (nonatomic, copy) void (^CityChangeBlock) (ChangeCityViewController *,NSString *);

-(void)setCityType:(NSInteger)cityType;
@end
