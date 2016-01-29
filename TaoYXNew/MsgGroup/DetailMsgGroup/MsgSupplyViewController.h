//
//  MsgSupplyViewController.h
//  TaoYXNew
//
//  Created by tianan-apple on 16/1/6.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MsgSupplyViewController : UIViewController
@property(nonatomic,strong)UILabel *sTitle;//标题
@property(nonatomic,strong)UILabel *areaName;//地区
@property(nonatomic,strong)UILabel *sPrice;//价格
@property(nonatomic,strong)UILabel *sTime;//发布时间
@property(nonatomic,strong)UIImageView *images;//图片
@property(nonatomic,strong)UILabel *sPhone;//电话
@property(nonatomic,strong)UILabel *sPerson;//联系人
@property(nonatomic,strong)UILabel *sType;//联系人
@property(nonatomic,copy)NSString *supplyDesc;//详细描述
@property(nonatomic,copy)NSString *msgId;//消息ID
@property (nonatomic, strong) UISwipeGestureRecognizer *rightSwipeGestureRecognizer;
@end
