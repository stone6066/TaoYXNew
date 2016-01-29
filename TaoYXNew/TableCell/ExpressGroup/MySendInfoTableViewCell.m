//
//  MySendInfoTableViewCell.m
//  TaoYXNew
//
//  Created by tianan-apple on 15/12/17.
//  Copyright © 2015年 tianan-apple. All rights reserved.
//

#import "MySendInfoTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "dealModel.h"

@implementation MySendInfoTableViewCell

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
        
        _fromPlace=[[UILabel alloc]initWithFrame:CGRectMake(103,0,CellWidth-105,20)];
        _fromPlace.font=[UIFont systemFontOfSize:13];
        [self addSubview:_fromPlace];
        
        _toPlace=[[UILabel alloc]initWithFrame:CGRectMake(103,20,CellWidth-105,20)];
        _toPlace.font=[UIFont systemFontOfSize:13];
        [self addSubview:_toPlace];
        
        
        
        _supplyPerson=[[UILabel alloc]initWithFrame:CGRectMake(103, 40, CellWidth-105, 20)];
        _supplyPerson.font=[UIFont systemFontOfSize:13];
        [self addSubview:_supplyPerson];
        
        _supplyTel=[[UILabel alloc]initWithFrame:CGRectMake(103, 60, CellWidth-105, 20)];
        _supplyTel.font=[UIFont systemFontOfSize:13];
        [self addSubview:_supplyTel];
        
        _supplyImg=[[UIImageView alloc]initWithFrame:CGRectMake(2, 4, 100, 70)];
        [self addSubview:_supplyImg];
        
        _carDetail=[[UILabel alloc]initWithFrame:CGRectMake(0, 75, CellWidth, 40)];
        _carDetail.font=[UIFont systemFontOfSize:12];
        [_carDetail setLineBreakMode:NSLineBreakByWordWrapping];
        [_carDetail setNumberOfLines:2];
        [_carDetail setTextColor:[UIColor lightGrayColor]];
        [self addSubview:_carDetail];
        
        _startTime=[[UILabel alloc]initWithFrame:CGRectMake(0,107,CellWidth,20)];
        _startTime.font=[UIFont systemFontOfSize:12];
        [_startTime setTextColor:[UIColor lightGrayColor]];
        [self addSubview:_startTime];
    }
    return self;
}


-(void)showUiSupplyCell:(dealModel*)NModel{
    NSString *strtmp=[NSString stringWithFormat:@"%@%@",@"出发地：",@"银川"];
    _fromPlace.text=strtmp;
    
    strtmp=[NSString stringWithFormat:@"%@%@",@"目的地：",NModel.city];
    _toPlace.text=strtmp;
    
    strtmp=[NSString stringWithFormat:@"%@%@",@"联系人：",@"擎天柱"];
    _supplyPerson.text=strtmp;
    
    _carDetail.text=NModel.Description;
    
    strtmp=[NSString stringWithFormat:@"%@%@",@"联系电话：",@"13900110123"];
    _supplyTel.text=strtmp;
    
    _startTime.text=@"发布时间：12-12 11:50";
    [_supplyImg sd_setImageWithStr:NModel.s_image_url];
    _cellUrl=NModel.deal_url;
}

-(dealModel*)praseModelWithCell:(MySendInfoTableViewCell *)cell{
    dealModel *nm = [[dealModel alloc]init];
    nm.deal_url=cell.cellUrl;
    
    return nm;
}
@end
