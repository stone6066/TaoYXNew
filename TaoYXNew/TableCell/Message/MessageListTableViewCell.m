//
//  MessageListTableViewCell.m
//  TaoYXNew
//
//  Created by tianan-apple on 16/1/6.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "MessageListTableViewCell.h"
#import "MessageListCellModel.h"
#import "MarkectDeal.h"

@implementation MessageListTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        CGFloat CellWidth= self.contentView.frame.size.width-4;
        
        
        _msgTxt=[[UILabel alloc]initWithFrame:CGRectMake(2,0,CellWidth,40)];
        _msgTxt.font=[UIFont systemFontOfSize:15];
        [_msgTxt setLineBreakMode:NSLineBreakByWordWrapping];
        [_msgTxt setNumberOfLines:0];
        [self addSubview:_msgTxt];
        
        
        _msgTime=[[UILabel alloc]initWithFrame:CGRectMake(2, 40, 120, 20)];
        _msgTime.font=[UIFont systemFontOfSize:13];
        [_msgTime setTextColor:[UIColor lightGrayColor]];
        [self addSubview:_msgTime];
        
        
    }
    return self;
}


-(void)showUiSupplyCell:(MessageListCellModel*)NModel{
    
    _msgTxt.text=NModel.describe;
    
    _msgTime.text=NModel.createtime;
    
    _detailId=NModel.detailId;
    _msgId=NModel.msgId;
    _msgType=NModel.msgType;
}

-(MessageListCellModel*)praseModelWithCell:(MessageListTableViewCell *)cell{
    MessageListCellModel *nm = [[MessageListCellModel alloc]init];
    nm.detailId=cell.detailId;
    nm.msgId=cell.msgId;
    nm.msgType=cell.msgType;
    return nm;
}


-(MarkectDeal*)prasePriceModelWithCell:(MessageListTableViewCell *)cell{
    MarkectDeal *nm = [[MarkectDeal alloc]init];
    nm.priceInfoId=cell.detailId;
    nm.title=cell.msgTxt.text;
    nm.publicTime=cell.msgTime.text;
    return nm;
}

@end
