//
//  MessageListTableViewCell.h
//  TaoYXNew
//
//  Created by tianan-apple on 16/1/6.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MessageListCellModel;
@class MarkectDeal;

@interface MessageListTableViewCell : UITableViewCell
@property(nonatomic,strong)UILabel *msgTxt;//消息内容
@property(nonatomic,strong)UILabel *msgTime;//时间
@property(nonatomic,strong)NSString *detailId;//消息id
@property(nonatomic,strong)NSString *msgId;//消息id
@property(nonatomic,strong)NSString *msgType;//消息type
-(MessageListCellModel*)praseModelWithCell:(MessageListTableViewCell *)cell;
-(void)showUiSupplyCell:(MessageListCellModel*)NModel;
-(MarkectDeal*)prasePriceModelWithCell:(MessageListTableViewCell *)cell;

@end
