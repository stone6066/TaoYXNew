//
//  MySupplyOrderDeal.h
//  TaoYXNew
//
//  Created by tianan-apple on 16/1/20.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MySupplyOrderDeal : NSObject
@property (nonatomic,copy)NSString * supplyOrderId;//单据id
@property (nonatomic,copy)NSString * supplyOrderFlag;//抢单状态
@property (nonatomic,copy)NSString * supplyType;//1求购
@property (nonatomic,copy)NSString * title;
@property (nonatomic,copy)NSString * supplyPrice;//供求价格
@property (nonatomic,copy)NSString * supplyUnit;//供求单位
@property (nonatomic,copy)NSString * supplyOrderPrice;//我的报价
@property (nonatomic,copy)NSString * supplyOrderNum;//我的数量
@property (nonatomic,copy)NSString * supplyValidate;//有效日期
@property (nonatomic,copy)NSString * images;//图片

- (NSArray *)asignModelWithDict:(NSDictionary *)dict;
@end
