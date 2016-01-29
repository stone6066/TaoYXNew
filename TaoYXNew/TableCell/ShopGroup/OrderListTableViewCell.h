//
//  OrderListTableViewCell.h
//  TaoYXNew
//
//  Created by tianan-apple on 15/12/16.
//  Copyright © 2015年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class dealModel;
@interface OrderListTableViewCell : UITableViewCell
@property(nonatomic,strong)UILabel *supplyType;//出售，求购
@property(nonatomic,strong)UIImageView *supplyImg;//图片描述
@property(nonatomic,strong)UILabel *supplyDetail;//细节说明
@property(nonatomic,strong)NSString *cellUrl;//详情链接
@property(nonatomic,strong)UILabel *supplyTitle;//标题
@property(nonatomic,strong)UILabel *supplyPerson;//发布人
@property(nonatomic,strong)UILabel *supplyTel;//联系电话

-(dealModel*)praseModelWithCell:(OrderListTableViewCell *)cell;
-(void)showUiSupplyCell:(dealModel*)NModel;

@end
