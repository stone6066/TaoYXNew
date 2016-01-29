//
//  MsgExpressDeal.h
//  TaoYXNew
//
//  Created by tianan-apple on 16/1/7.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MsgExpressDeal : NSObject

@property (nonatomic,copy)NSString *goodsVolume;//货物体积 立方米
@property (nonatomic,copy)NSString *vehicleLength;//车长
@property (nonatomic,copy)NSString *vehicleType;//车型
@property(nonatomic,copy)NSString *goodsWeight;//货物重量 吨
@property (nonatomic,copy)NSString *logInfoType;//0货源 1车源
@property (nonatomic,copy)NSString *logInfoDesc;//物流描述
@property (nonatomic,copy)NSString *vehicleLoad;//车载重 吨
@property (nonatomic,copy)NSString *sendTime;//出发时间

@property (nonatomic,copy)NSString *startProvince;//出发省份
@property (nonatomic,copy)NSString *startCity;//出发城市
@property (nonatomic,copy)NSString *startCounty;//开始地区

@property (nonatomic,copy)NSString *endProvicen;//目的省份
@property (nonatomic,copy)NSString *endCity;//目的城市
@property (nonatomic,copy)NSString *endCounty;//目的区域

@property (nonatomic,copy)NSString *logInfoId;//
@property (nonatomic,copy)NSString *telphone;//电话
@property (nonatomic,copy)NSString *carCode;//车牌号
@property (nonatomic,copy)NSString *goodsType;//货物种类
@property (nonatomic,copy)NSString *goodsName;//货物名称
@property (nonatomic,copy)NSString *createTime;//发布时间
@property (nonatomic,copy)NSString *customerName;//联系人
- (NSArray *)asignModelWithDict:(NSDictionary *)dict;
@end
