//
//  MyGrapTableViewCell.h
//  TaoYXNew
//
//  Created by tianan-apple on 16/1/22.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class stdCallBtn;
@class MyGrapDeal;
@interface MyGrapTableViewCell : UITableViewCell
@property (nonatomic,strong)UILabel *contact;
@property (nonatomic,strong)UILabel *createTime;//抢单日期
@property (nonatomic,strong)UILabel *memo;
@property (nonatomic,strong)UILabel *mobile;
@property (nonatomic,strong)stdCallBtn *phone;
@property (nonatomic,strong)UILabel *supplyOrderNum;
@property (nonatomic,strong)UILabel *supplyOrderPrice;
@property (nonatomic,strong)UILabel *supplyOrderFlag;
@property (nonatomic,copy)UIImageView *images;

@property (nonatomic,copy)NSString *pubId;
@property (nonatomic,copy)NSString *publisher;

@property (nonatomic,copy)NSString *supplyId;//求购单id
@property (nonatomic,copy)NSString *supplyOrderId;//报价单id
-(void)showUiSupplyCell:(MyGrapDeal*)NModel;
@end
