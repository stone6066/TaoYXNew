//
//  MsgPopModel.h
//  TaoYXNew
//
//  Created by tianan-apple on 16/1/14.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MsgPopModel : NSObject
//图标
@property (copy,nonatomic)NSString * highlighted_icon;
@property (copy,nonatomic)NSString * small_highlighted_icon;
@property (copy,nonatomic)NSString * icon;
@property (copy,nonatomic)NSString * small_icon;
//名称
@property (copy,nonatomic)NSString * name;
//子数据数组
@property (strong,nonatomic)NSArray * subcategories;

@property (copy,nonatomic)NSString * dataid;

- (NSArray *)loadPlistData:(NSInteger)datatype;
- (NSArray *)asignModelWithDict:(NSDictionary *)dict;

@end
