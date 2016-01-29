//
//  LocalLongTableViewCell.h
//  TaoYXNew
//
//  Created by tianan-apple on 15/12/17.
//  Copyright © 2015年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LongExpressDeal;
@class stdCallBtn;
@interface LocalLongTableViewCell : UITableViewCell
@property(nonatomic,strong)UILabel *logEmpName;//名称
@property(nonatomic,strong)UILabel *line;//线路
@property(nonatomic,strong)UILabel *mobile;//联系电话
@property(nonatomic,strong)UILabel *address;//地址
@property(nonatomic,strong)UIImageView *supplyImg;//图片描述
@property(nonatomic,strong)NSString *cellUrl;//详情链接
@property(nonatomic,strong)stdCallBtn *telLbl;//可点击拨号
-(LongExpressDeal*)praseModelWithCell:(LocalLongTableViewCell *)cell;
-(void)showUiSupplyCell:(LongExpressDeal*)NModel;
@end
