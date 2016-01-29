//
//  PlaceTypeTableViewCell.m
//  TaoYXNew
//
//  Created by tianan-apple on 15/12/18.
//  Copyright © 2015年 tianan-apple. All rights reserved.
//

#import "PlaceTypeTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "PricePlaceModel.h"

@implementation PlaceTypeTableViewCell

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
        
        _fromPlace=[[UILabel alloc]initWithFrame:CGRectMake(73,0,CellWidth-105,20)];
        _fromPlace.font=[UIFont systemFontOfSize:13];
        [self addSubview:_fromPlace];
        
        _toPlace=[[UILabel alloc]initWithFrame:CGRectMake(73,30,CellWidth-105,20)];
        _toPlace.font=[UIFont systemFontOfSize:13];
        [self addSubview:_toPlace];
        
        
        
        _supplyPerson=[[UILabel alloc]initWithFrame:CGRectMake(73, 60, CellWidth-105, 20)];
        _supplyPerson.font=[UIFont systemFontOfSize:13];
        [_supplyPerson setTextColor:[UIColor redColor]];
        [self addSubview:_supplyPerson];
        
        
//        _supplyTel=[[UILabel alloc]initWithFrame:CGRectMake(103, 60, CellWidth-105, 20)];
//        _supplyTel.font=[UIFont systemFontOfSize:13];
//        [self addSubview:_supplyTel];
        
        _supplyImg=[[UIImageView alloc]initWithFrame:CGRectMake(2, 4, 60, 55)];
        [self addSubview:_supplyImg];
        
//        _carDetail=[[UILabel alloc]initWithFrame:CGRectMake(0, 75, CellWidth, 40)];
//        _carDetail.font=[UIFont systemFontOfSize:12];
//        [_carDetail setLineBreakMode:NSLineBreakByWordWrapping];
//        [_carDetail setNumberOfLines:2];
//        [_carDetail setTextColor:[UIColor lightGrayColor]];
//        [self addSubview:_carDetail];
        
        _startTime=[[UILabel alloc]initWithFrame:CGRectMake(0,80,CellWidth,20)];
        _startTime.font=[UIFont systemFontOfSize:12];
        [_startTime setTextColor:[UIColor lightGrayColor]];
        [self addSubview:_startTime];
    }
    return self;
}


-(void)showUiSupplyCell:(PricePlaceModel*)NModel{

    _fromPlace.text=NModel.title;
    
    
    _toPlace.text=NModel.areaName;
    
    
    _supplyPerson.text=NModel.price;
    
    _carDetail.text=NModel.address;
    
    _startTime.text=[NSString stringWithFormat:@"%@%@",@"发布时间：",NModel.publicTime];
    _supplyImg.image=[UIImage imageNamed:@"priceInfo"];

    //_cellUrl=NModel.empDesc;
    _priceId=NModel.priceId;
}

-(PricePlaceModel*)praseModelWithCell:(PlaceTypeTableViewCell *)cell{
    PricePlaceModel *nm = [[PricePlaceModel alloc]init];
    nm.empDesc=cell.cellUrl;
    nm.title=cell.fromPlace.text;
    nm.areaName=cell.toPlace.text;
    nm.price=cell.supplyPerson.text;
    nm.address=cell.carDetail.text;
    nm.publicTime=cell.startTime.text;
    nm.priceId=cell.priceId;
    return nm;
}
@end
