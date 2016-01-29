//
//  PopMsgUnitViewController.h
//  TaoYXNew
//
//  Created by tianan-apple on 16/1/14.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopMsgUnitViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView* tableView;
@property (nonatomic, copy) void (^TimeChangeBlock) (PopMsgUnitViewController *,NSString *);

@end
