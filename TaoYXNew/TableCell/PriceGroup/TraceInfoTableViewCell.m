//
//  TraceInfoTableViewCell.m
//  TaoYXNew
//
//  Created by tianan-apple on 15/12/18.
//  Copyright © 2015年 tianan-apple. All rights reserved.
//

#import "TraceInfoTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "TraceInfoDeal.h"

@implementation TraceInfoTableViewCell

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
        
    }
    return self;
}


-(void)showUiSupplyCell:(TraceInfoDeal*)NModel{
    
    _fromPlace.text=NModel.title;
    _cellUrl=NModel.empDesc;
    _publicTime=NModel.publicTime;
    _priceInfoId=NModel.priceInfoId;
}

-(TraceInfoDeal*)praseModelWithCell:(TraceInfoTableViewCell *)cell{
    TraceInfoDeal *nm = [[TraceInfoDeal alloc]init];
    nm.empDesc=cell.cellUrl;
    nm.title=_fromPlace.text;
    nm.publicTime=_publicTime;
     nm.priceInfoId=_priceInfoId;
    return nm;
}
@end
