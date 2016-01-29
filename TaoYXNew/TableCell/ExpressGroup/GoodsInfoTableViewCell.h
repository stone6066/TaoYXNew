//
//  GoodsInfoTableViewCell.h
//  TaoYXNew
//
//  Created by tianan-apple on 15/12/17.
//  Copyright © 2015年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CarExpressDeal;
@class stdCallBtn;

@interface GoodsInfoTableViewCell : UITableViewCell
@property(nonatomic,strong)UILabel *goodsName;//货品名
@property(nonatomic,strong)UILabel *fromPlace;//出发地
@property(nonatomic,strong)UIImageView *supplyImg;//图片描述
@property(nonatomic,strong)UILabel *carDetail;//货品描述
@property(nonatomic,strong)NSString *cellUrl;//详情链接
@property(nonatomic,strong)UILabel *toPlace;//标题
@property(nonatomic,strong)UILabel *supplyPerson;//发布人
@property(nonatomic,strong)UILabel *supplyTel;//联系电话
@property(nonatomic,strong)UILabel *startTime;//发布时间

@property(nonatomic,strong)stdCallBtn *telLbl;//可点击拨号
@property(nonatomic,strong)NSString *expId;//id

-(CarExpressDeal*)praseModelWithCell:(GoodsInfoTableViewCell *)cell;
-(void)showUiSupplyCell:(CarExpressDeal*)NModel;
@end
