//
//  LocalStationTableViewCell.h
//  TaoYXNew
//
//  Created by tianan-apple on 15/12/17.
//  Copyright © 2015年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LocalStationDeal;
@class stdCallBtn;
@interface LocalStationTableViewCell : UITableViewCell


@property(nonatomic,strong)UILabel *logEmpName;//名称
@property(nonatomic,strong)UILabel *business;//项目
@property(nonatomic,strong)UILabel *mobile;//联系电话
@property(nonatomic,strong)UILabel *publicTime;//发布时间

@property(nonatomic,strong)UIImageView *supplyImg;//图片描述
@property(nonatomic,strong)UILabel *carDetail;//
@property(nonatomic,strong)NSString *infoDesc;//详情
@property(nonatomic,strong)UILabel *addr;//地址
@property(nonatomic,strong)UILabel *supplyPerson;//发布人
@property(nonatomic,strong)NSString *cellUrl;//详情链接
@property(nonatomic,strong)stdCallBtn *telLbl;//可点击拨号
-(LocalStationDeal*)praseModelWithCell:(LocalStationTableViewCell *)cell;
-(void)showUiSupplyCell:(LocalStationDeal*)NModel;
@end
