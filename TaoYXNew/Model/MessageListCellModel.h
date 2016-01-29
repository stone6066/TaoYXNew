//
//  MessageListCellModel.h
//  TaoYXNew
//
//  Created by tianan-apple on 16/1/6.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageListCellModel : NSObject
@property (nonatomic,copy)NSString *msgId;
@property (nonatomic,copy)NSString *msgType;
@property (nonatomic,copy)NSString *closingdate;
@property (nonatomic,copy)NSString *createtime;
@property (nonatomic,copy)NSString *area;
@property (nonatomic,copy)NSString *detailId;
@property (nonatomic,copy)NSString *describe;
- (NSArray *)asignModelWithDict:(NSDictionary *)dict;
@end
