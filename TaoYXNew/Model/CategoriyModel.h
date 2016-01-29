//
//  CategoriyModel.h
//  团购项目
//
//  Created by lb on 15/5/28.
//  Copyright (c) 2015年 lbcoder. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CategoriyModel : NSObject

#pragma mark - 声明属性



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
