//
//  MsgPriceDeal.h
//  TaoYXNew
//
//  Created by tianan-apple on 16/1/7.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//



#import <Foundation/Foundation.h>

@interface MsgPriceDeal : NSObject
@property (nonatomic,copy)NSString *typeName;
@property (nonatomic,copy)NSString *origin;
@property (nonatomic,copy)NSString *areaName;
@property(nonatomic,copy)NSString *brandName;
@property (nonatomic,copy)NSString *typeId;
@property (nonatomic,copy)NSString *brandId;
@property (nonatomic,copy)NSString *pubId;
@property (nonatomic,copy)NSString *priceDesc;
@property (nonatomic,copy)NSString *publisher;
@property (nonatomic,copy)NSString *price;
@property (nonatomic,copy)NSString *unit;
@property (nonatomic,copy)NSString *areaId;
@property (nonatomic,copy)NSString *priceId;
@property (nonatomic,copy)NSString *createTime;

- (NSArray *)asignModelWithDict:(NSDictionary *)dict;
@end
