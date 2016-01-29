//
//  MsgCommonViewController.h
//  TaoYXNew
//
//  Created by tianan-apple on 16/1/7.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MsgCommonViewController : UIViewController
@property(nonatomic,copy)NSString *msgId;//消息ID

@property(nonatomic,strong)UILabel *sTitle;//标题
@property(nonatomic,strong)UILabel *sTime;//时间
@property(nonatomic,strong)NSString *sDesc;//详情

@property (nonatomic, strong) UISwipeGestureRecognizer *rightSwipeGestureRecognizer;
@end
