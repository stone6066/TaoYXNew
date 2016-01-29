//
//  DetailTraceViewController.h
//  TaoYXNew
//
//  Created by tianan-apple on 16/1/7.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TraceInfoDeal;

@interface DetailTraceViewController : UIViewController
@property (nonatomic,strong)UILabel *stitle;//标题
@property (nonatomic,strong)UILabel *publicTime;//发布时间
@property (nonatomic,copy)NSString *empDesc;//详情

@property (nonatomic,copy)TraceInfoDeal *traceData;
@property (nonatomic, strong) UISwipeGestureRecognizer *rightSwipeGestureRecognizer;
@end
