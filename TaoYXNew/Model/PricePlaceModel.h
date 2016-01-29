//
//  PricePlaceModel.h
//  TaoYXNew
//
//  Created by tianan-apple on 15/12/25.
//  Copyright © 2015年 tianan-apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PricePlaceModel : NSObject
@property (nonatomic,copy)NSString *title;//标题
@property (nonatomic,copy)NSString *areaName;//地区
@property (nonatomic,copy)NSString *images;//图片url
@property (nonatomic,copy)NSString *contact;//联系人
@property (nonatomic,copy)NSString *phone;//电话
@property (nonatomic,copy)NSString *mobile;//移动电话
@property (nonatomic,copy)NSString *address;//地址

@property (nonatomic,copy)NSString *price;//商超详情
@property (nonatomic,copy)NSString *publicTime;//发布时间
@property (nonatomic,copy)NSString *priceId;//ID
@property (nonatomic,copy)NSString *pricenum;//ID


@property (nonatomic,copy)NSString *areaId;
@property (nonatomic,copy)NSString *typeId;
@property (nonatomic,copy)NSString *brandId;
@property (nonatomic,copy)NSString *brandName;

@property (nonatomic,copy)NSString *mprice;
@property (nonatomic,copy)NSString *unit;
@property (nonatomic,copy)NSString *pubId;
@property (nonatomic,copy)NSString *publisher;
@property (nonatomic,copy)NSString *mareaName;
@property (nonatomic,copy)NSString *origin;
@property (nonatomic,copy)NSString *typeName;
@property (nonatomic,copy)NSString *empDesc;

- (NSArray *)asignModelWithDict:(NSDictionary *)dict;
- (NSArray *)asignDetailModelWithDict:(NSDictionary *)dict;
@end
