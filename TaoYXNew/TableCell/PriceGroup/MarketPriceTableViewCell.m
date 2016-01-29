//
//  MarketPriceTableViewCell.m
//  TaoYXNew
//
//  Created by tianan-apple on 15/12/18.
//  Copyright © 2015年 tianan-apple. All rights reserved.
//

#import "MarketPriceTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "MarkectDeal.h"
@implementation MarketPriceTableViewCell

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
        
        _fromPlace=[[UILabel alloc]initWithFrame:CGRectMake(5,0,CellWidth-5,35)];
        _fromPlace.font=[UIFont systemFontOfSize:13];
        [_fromPlace setLineBreakMode:NSLineBreakByWordWrapping];
        [_fromPlace setNumberOfLines:0];
        [self addSubview:_fromPlace];
        
        float timeY=_fromPlace.frame.size.height;
        _startTime=[[UILabel alloc]initWithFrame:CGRectMake(5,timeY+2,CellWidth-5,20)];
        _startTime.font=[UIFont systemFontOfSize:12];
        [_startTime setTextColor:[UIColor lightGrayColor]];
        [self addSubview:_startTime];
    }
    return self;
}


-(void)showUiSupplyCell:(MarkectDeal*)NModel{

    _fromPlace.text=NModel.title;
    _startTime.text=NModel.publicTime;
    _cellUrl=NModel.cellUrl;
    _priceInfoId=NModel.priceInfoId;
}

-(MarkectDeal*)praseModelWithCell:(MarketPriceTableViewCell *)cell{
    MarkectDeal *nm = [[MarkectDeal alloc]init];
    //nm.cellUrl=cell.cellUrl;
    nm.title=_fromPlace.text;
    nm.publicTime=_startTime.text;
    nm.priceInfoId=_priceInfoId;
    return nm;
}
@end
