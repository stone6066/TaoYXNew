//
//  MesPriceViewController.h
//  TaoYXNew
//
//  Created by tianan-apple on 16/1/6.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MesPriceViewController : UIViewController
@property (nonatomic,strong)UILabel *typeName;
@property (nonatomic,strong)UILabel *origin;
@property (nonatomic,strong)UILabel *areaName;
@property(nonatomic,strong)UILabel *brandName;
@property (nonatomic,strong)UILabel *typeId;
@property (nonatomic,strong)UILabel *brandId;
@property (nonatomic,strong)UILabel *pubId;
@property (nonatomic,strong)NSString *priceDesc;
@property (nonatomic,strong)UILabel *publisher;
@property (nonatomic,strong)UILabel *price;
@property (nonatomic,strong)UILabel *unit;
@property (nonatomic,strong)UILabel *areaId;
@property (nonatomic,strong)UILabel *priceId;
@property (nonatomic,strong)UILabel *createTime;

@property(nonatomic,copy)NSString *msgId;//消息ID

@property (nonatomic, strong) UISwipeGestureRecognizer *rightSwipeGestureRecognizer;
@end
