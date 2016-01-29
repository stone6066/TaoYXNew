//
//  MyGrapDeal.h
//  TaoYXNew
//
//  Created by tianan-apple on 16/1/22.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyGrapDeal : NSObject

@property (nonatomic,copy)NSString *contact;
@property (nonatomic,copy)NSString *createTime;//抢单日期
@property (nonatomic,copy)NSString *memo;
@property (nonatomic,copy)NSString *mobile;
@property (nonatomic,copy)NSString *phone;
@property (nonatomic,copy)NSString *pubId;
@property (nonatomic,copy)NSString *publisher;
@property (nonatomic,copy)NSString *images;
@property (nonatomic,copy)NSString *supplyId;//求购单id
@property (nonatomic,copy)NSString *supplyOrderId;//报价单id
@property (nonatomic,copy)NSString *supplyOrderNum;
@property (nonatomic,copy)NSString *supplyOrderPrice;
@property (nonatomic,copy)NSString *supplyOrderFlag;
- (NSArray *)asignModelWithDict:(NSDictionary *)dict;
@end
