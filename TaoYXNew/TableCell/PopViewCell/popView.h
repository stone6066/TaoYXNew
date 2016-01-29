//
//  popView.h
//  团购项目
//
//  Created by lb on 15/5/27.
//  Copyright (c) 2015年 lbcoder. All rights reserved.
//
// 1. 声明一个协议
// 2. 声明协议中的方法
// 3. 声明一个遵守协议的id类型的指针
// 4. 实现协议方法

#import <UIKit/UIKit.h>
@class popView;

@protocol MyPopviewDataSource <NSObject>

//制定协议方法

//left tablevie 行数
- (NSInteger)numberOfRowsInLeftTable:(popView *)popView;

//left 标题
- (NSString *)popView:(popView *)popView titleForRow:(int)row;

//left 图标
- (NSString *)popView:(popView *)popView imageForRow:(int)row;

//left 子数据
- (NSArray *)popView:(popView *)popView subDataForRow:(int)row;

@end

@protocol MyPopviewDelegate <NSObject>

//选择左侧表时调用
- (void)popView:(popView *)popView didSelectRowAtLeftTable:(int)row;

//选择右侧表时调用
- (void)popView:(popView *)popView didSelectRowAtRightTable:(int)row;

@end

@interface popView : UIView

@property (nonatomic,strong)NSArray *categoryArr;

@property (nonatomic,assign)id<MyPopviewDataSource> dataSource;

@property (nonatomic,assign)id<MyPopviewDelegate> delegate;

+ (popView*)makePopView;

@end
