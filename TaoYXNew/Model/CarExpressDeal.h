//
//  CarExpressDeal.h
//  TaoYXNew
//
//  Created by tianan-apple on 15/12/28.
//  Copyright © 2015年 tianan-apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarExpressDeal : NSObject
@property (nonatomic,copy)NSString *startProvince;//出发省
@property (nonatomic,copy)NSString *startCity;//出发市
@property (nonatomic,copy)NSString *startCounty;//出发县
@property (nonatomic,copy)NSString *endProvicen;//目的省
@property (nonatomic,copy)NSString *endCity;//目的市
@property (nonatomic,copy)NSString *endCounty;//目的县
@property (nonatomic,copy)NSString *images;//图片url
@property (nonatomic,copy)NSString *contact;//联系人
@property (nonatomic,copy)NSString *mobile;//移动电话
@property (nonatomic,copy)NSString *publicTime;//发布时间
@property (nonatomic,copy)NSString *infoDesc;//详情
@property (nonatomic,copy)NSString *deal_url;//详情url
@property (nonatomic,copy)NSString *carCode;//车牌
@property (nonatomic,copy)NSString *goodsName;//货品名
@property (nonatomic,copy)NSString *expId;//信息id
@property (nonatomic,copy)NSString *logInfoType;//类型 1车 0货
@property (nonatomic,copy)NSString *vehicleType;//车类型
@property (nonatomic,copy)NSString *vehicleLength;//车长
@property (nonatomic,copy)NSString *vehicleLoad;//车载重

@property (nonatomic,copy)NSString *goodsVolume;//货体积
@property (nonatomic,copy)NSString *goodsWeight;//货重
@property (nonatomic,copy)NSString *goodsType;//货重
- (NSArray *)asignModelWithDict:(NSDictionary *)dict;
- (NSArray *)asignDetailModelWithDict:(NSDictionary *)dict;
@end
