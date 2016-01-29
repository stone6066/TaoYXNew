//
//  MyOrderPriceDeal.h
//  TaoYXNew
//
//  Created by tianan-apple on 16/1/21.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyOrderPriceDeal : NSObject
@property (nonatomic,copy)NSString *supplyType;
@property (nonatomic,copy)NSString *supplyOrderPrice;
@property (nonatomic,copy)NSString *supplyOrderNum;
@property(nonatomic,copy)NSString *supplyOrderValidate;
@property (nonatomic,copy)NSString *supplyOrderFlag;
@property (nonatomic,copy)NSString *mobile;
@property (nonatomic,copy)NSString *createTime;
@property (nonatomic,copy)NSString *supplyOrderId;
@property (nonatomic,copy)NSString *supplyId;
@property (nonatomic,copy)NSString *supplyPrice;
@property (nonatomic,copy)NSString *supplyUnit;
@property (nonatomic,copy)NSString *contact;
@property (nonatomic,copy)NSString *memo;
@property (nonatomic,copy)NSString *pubId;
@property (nonatomic,copy)NSString *publisher;
@property (nonatomic,copy)NSString *phone;


- (NSArray *)asignModelWithDict:(NSDictionary *)dict;
@end
