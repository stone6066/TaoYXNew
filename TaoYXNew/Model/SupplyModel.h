//
//  SupplyModel.h
//  TaoYXNew
//
//  Created by tianan-apple on 15/12/31.
//  Copyright © 2015年 tianan-apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SupplyModel : NSObject
@property (nonatomic,copy)NSString *title;
//deal_id
@property (nonatomic,copy)NSString *deal_id;
//name
@property (nonatomic,copy)NSString *name;

@property(nonatomic,copy)NSString *send_time;//有效期

@property (nonatomic,copy)NSString *phone;

@property (nonatomic,copy)NSString *supplyType;

@property (nonatomic,copy)NSString *supplyDesc;

@property (nonatomic,copy)NSString *images;

@property (nonatomic,copy)NSString *brandName;

@property (nonatomic,copy)NSString *supplyId;

@property (nonatomic,copy)NSString *supplyPrice;

@property (nonatomic,copy)NSString *brandId;
@property (nonatomic,copy)NSString *areaName;
@property (nonatomic,copy)NSString *areaId;
@property (nonatomic,copy)NSString *supplySpecName;
@property (nonatomic,copy)NSString *supplyUnit;
@property (nonatomic,copy)NSString *supplyValidate;
@property (nonatomic,copy)NSString *pubId;

- (NSArray *)asignModelWithDict:(NSDictionary *)dict;
- (NSArray *)asignDetailModelWithDict:(NSDictionary *)mydict;
@end
