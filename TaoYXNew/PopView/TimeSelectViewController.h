//
//  TimeSelectViewController.h
//  TaoYXNew
//
//  Created by tianan-apple on 15/12/21.
//  Copyright © 2015年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimeSelectViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView* tableView;
@property (nonatomic, copy) void (^TimeChangeBlock) (TimeSelectViewController *,NSString *);

@end
