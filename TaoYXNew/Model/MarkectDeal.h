//
//  MarkectDeal.h
//  TaoYXNew
//
//  Created by tianan-apple on 15/12/28.
//  Copyright © 2015年 tianan-apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MarkectDeal : NSObject
@property (nonatomic,copy)NSString *title;//标题
@property (nonatomic,copy)NSString *publicTime;//发布时间
@property (nonatomic,copy)NSString *empDesc;//详情
@property (nonatomic,copy)NSString *cellUrl;
@property (nonatomic,copy)NSString *priceInfoId;
- (NSArray *)asignModelWithDict:(NSDictionary *)dict;
- (NSArray *)asignDetailModelWithDict:(NSDictionary *)dict;
@end
