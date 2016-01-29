//
//  CmpModel.h
//  TaoYXNew
//
//  Created by tianan-apple on 15/12/24.
//  Copyright © 2015年 tianan-apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CmpModel : NSObject
@property (nonatomic,copy)NSString *empName;//商超名字
@property (nonatomic,copy)NSString *areaName;//地区
@property (nonatomic,copy)NSString *images;//图片url
@property (nonatomic,copy)NSString *contact;//联系人
@property (nonatomic,copy)NSString *phone;//电话
@property (nonatomic,copy)NSString *mobile;//移动电话
@property (nonatomic,copy)NSString *address;//地址
@property (nonatomic,copy)NSString *empDesc;//商超详情
@property (nonatomic,copy)NSString *empId;
@property (nonatomic,copy)NSString *areaId;
@property (nonatomic,copy)NSString *fax;
- (NSArray *)asignModelWithDict:(NSDictionary *)dict;
- (NSArray *)asignDetailModelWithDict:(NSDictionary *)mydict;
@end
