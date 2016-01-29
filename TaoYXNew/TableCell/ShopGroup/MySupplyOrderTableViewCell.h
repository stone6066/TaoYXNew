//
//  MySupplyOrderTableViewCell.h
//  TaoYXNew
//
//  Created by tianan-apple on 16/1/20.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MySupplyOrderDeal;

@interface MySupplyOrderTableViewCell : UITableViewCell
@property (nonatomic,copy)NSString * supplyOrderId;//单据id
@property (nonatomic,copy)NSString * supplyOrderFlag;//抢单状态

@property(nonatomic,strong)UIImageView *supplyImg;//图片描述
@property(nonatomic,strong)UILabel *supplyTitle;//标题
@property(nonatomic,strong)UILabel *supplyState;//单据状态
@property(nonatomic,strong)UILabel *supplyPrice;//供求价格
@property(nonatomic,strong)UILabel *supplyOrderPrice;//我的报价
@property(nonatomic,strong)UILabel *supplyOrderNum;//我的数量
@property(nonatomic,strong)UILabel *supplyValidate;//有效日期

-(void)showUiSupplyCell:(MySupplyOrderDeal*)NModel;
-(MySupplyOrderDeal*)praseModelWithCell:(MySupplyOrderTableViewCell *)cell;
@end
