//
//  ShopListTableViewCell.h
//  TaoYXNew
//
//  Created by tianan-apple on 15/12/16.
//  Copyright © 2015年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CmpModel;
@class stdCallBtn;
@interface ShopListTableViewCell : UITableViewCell
@property(nonatomic,strong)UILabel *supplyType;//出售，求购
@property(nonatomic,strong)UIImageView *supplyImg;//图片描述
@property(nonatomic,strong)UILabel *supplyDetail;//细节说明
@property(nonatomic,strong)NSString *cellUrl;//详情链接
@property(nonatomic,strong)UILabel *supplyTitle;//标题
@property(nonatomic,strong)UILabel *supplyPerson;//发布人
@property(nonatomic,strong)UILabel *supplyTel;//联系电话
@property(nonatomic,strong)stdCallBtn *telLbl;//可点击拨号
-(CmpModel*)praseModelWithCell:(ShopListTableViewCell *)cell;
-(void)showUiSupplyCell:(CmpModel*)NModel;
@end
