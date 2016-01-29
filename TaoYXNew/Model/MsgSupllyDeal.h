//
//  MsgSupllyDeal.h
//  TaoYXNew
//
//  Created by tianan-apple on 16/1/6.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MsgSupllyDeal : NSObject
@property (nonatomic,copy)NSString *title;
//deal_id
@property (nonatomic,copy)NSString *deal_id;
//name
@property (nonatomic,copy)NSString *name;

@property(nonatomic,copy)NSString *send_time;

@property (nonatomic,copy)NSString *phone;

@property (nonatomic,copy)NSString *supplyType;

@property (nonatomic,copy)NSString *supplyDesc;

@property (nonatomic,copy)NSString *images;

@property (nonatomic,copy)NSString *brandName;

- (NSArray *)asignModelWithDict:(NSDictionary *)dict;
@end
