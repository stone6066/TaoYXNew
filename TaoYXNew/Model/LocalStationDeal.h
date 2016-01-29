//
//  LocalStationDeal.h
//  TaoYXNew
//
//  Created by tianan-apple on 15/12/28.
//  Copyright © 2015年 tianan-apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocalStationDeal : NSObject
@property (nonatomic,copy)NSString *logEmpName;//名称
@property (nonatomic,copy)NSString *business;//主营项目
@property (nonatomic,copy)NSString *mobile;//移动电话
@property (nonatomic,copy)NSString *infoDesc;//详情
@property (nonatomic,copy)NSString *deal_url;//详情url
@property (nonatomic,copy)NSString *address;//地址
- (NSArray *)asignModelWithDict:(NSDictionary *)dict;

@end
