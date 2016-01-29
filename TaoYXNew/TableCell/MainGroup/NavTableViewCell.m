//
//  NavTableViewCell.m
//  TaoYXNew
//
//  Created by tianan-apple on 15/12/9.
//  Copyright © 2015年 tianan-apple. All rights reserved.
//

#import "NavTableViewCell.h"
#import "NavModel.h"
#import "UIImageView+WebCache.h"

@implementation NavTableViewCell

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
        
        _newsTitle=[[UILabel alloc]initWithFrame:CGRectMake(2,5,CellWidth,40)];
        _newsTitle.font=[UIFont systemFontOfSize:20];
        [self addSubview:_newsTitle];
        
        _newsImg=[[UIImageView alloc]initWithFrame:CGRectMake(2, 50, CellWidth, 150)];
        [self addSubview:_newsImg];
        
        _newsDetail=[[UILabel alloc]initWithFrame:CGRectMake(2, 190, CellWidth, 80)];
        _newsDetail.font=[UIFont systemFontOfSize:15];
        [_newsDetail setLineBreakMode:NSLineBreakByWordWrapping];
        [_newsDetail setNumberOfLines:0];
        [_newsDetail setTextColor:[UIColor lightGrayColor]];
        [self addSubview:_newsDetail];
        
    }
    return self;
}

-(void)showUiNewsCell:(NavModel*)NModel{
    _newsTitle.text=NModel.newsTitle;
    _newsDetail.text=NModel.newsDetail;
    [_newsImg sd_setImageWithStr:NModel.newsImgUrl];
    _cellUrl=NModel.cellUrl;
}

-(NavModel*)praseModelWithCell:(NavTableViewCell *)cell{
    NavModel *nm = [[NavModel alloc]init];
    nm.cellUrl=cell.cellUrl;
    
    return nm;
}
@end
