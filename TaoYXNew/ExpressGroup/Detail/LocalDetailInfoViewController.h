//
//  LocalDetailInfoViewController.h
//  TaoYXNew
//
//  Created by tianan-apple on 16/1/11.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocalDetailInfoViewController : UIViewController
@property(nonatomic,strong)UILabel *logEmpName;//名称
@property(nonatomic,strong)UILabel *business;//项目
@property(nonatomic,strong)UILabel *mobile;//联系电话
@property(nonatomic,strong)UILabel *publicTime;//发布时间
@property(nonatomic,strong)NSString *descInfo;//详情描述
@property(nonatomic,strong)NSString *cellUrl;//详情链接
@property (nonatomic, strong) UISwipeGestureRecognizer *rightSwipeGestureRecognizer;
@end
