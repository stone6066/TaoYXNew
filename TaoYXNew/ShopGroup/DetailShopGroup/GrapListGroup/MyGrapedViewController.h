//
//  MyGrapedViewController.h
//  TaoYXNew
//
//  Created by tianan-apple on 16/1/22.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyGrapedViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *TableView;
@property(nonatomic,strong)UIButton *topBtn;
@property(nonatomic,copy)NSString *supplyId;
@property (nonatomic, strong) UISwipeGestureRecognizer *rightSwipeGestureRecognizer;
- (instancetype)init:(NSString*)mid;
@end
