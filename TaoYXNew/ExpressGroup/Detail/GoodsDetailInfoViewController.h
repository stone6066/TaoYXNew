//
//  GoodsDetailInfoViewController.h
//  TaoYXNew
//
//  Created by tianan-apple on 16/1/11.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CarExpressDeal;
@class stdCallBtn;

@interface GoodsDetailInfoViewController : UIViewController
@property (nonatomic,strong)UILabel *detailDesc;//货物或者车源描述
@property (nonatomic,strong)UILabel *logInfoType;//0货源 1车源
@property (nonatomic,strong)UILabel *logInfoDesc;//物流描述
@property (nonatomic,strong)UILabel *sendTime;//出发时间
@property (nonatomic,strong)UILabel *startPlace;//出发地
@property (nonatomic,strong)UILabel *endPlace;//目的地
@property (nonatomic,strong)UILabel *telphone;//电话
@property (nonatomic,strong)UILabel *carCode;//车牌号

@property (nonatomic,strong)UILabel *createTime;//发布时间
@property (nonatomic,strong)UILabel *customerName;//联系人

@property(nonatomic,copy)CarExpressDeal *ViewData;
@property(nonatomic,strong)stdCallBtn *telLbl;//可点击拨号
@property (nonatomic, strong) UISwipeGestureRecognizer *rightSwipeGestureRecognizer;
@end
