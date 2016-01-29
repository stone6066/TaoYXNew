//
//  GoodsInfoTableViewCell.m
//  TaoYXNew
//
//  Created by tianan-apple on 15/12/17.
//  Copyright © 2015年 tianan-apple. All rights reserved.
//

#import "GoodsInfoTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "CarExpressDeal.h"
#import "stdCallBtn.h"

@implementation GoodsInfoTableViewCell

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
        _goodsName=[[UILabel alloc]initWithFrame:CGRectMake(103,0,CellWidth-105,20)];
        _goodsName.font=[UIFont systemFontOfSize:13];
        [self addSubview:_goodsName];
        
        
        _fromPlace=[[UILabel alloc]initWithFrame:CGRectMake(103,20,CellWidth-105,20)];
        _fromPlace.font=[UIFont systemFontOfSize:13];
        [self addSubview:_fromPlace];
        
        _toPlace=[[UILabel alloc]initWithFrame:CGRectMake(103,40,CellWidth-105,20)];
        _toPlace.font=[UIFont systemFontOfSize:13];
        [self addSubview:_toPlace];
        
        
        
        _supplyPerson=[[UILabel alloc]initWithFrame:CGRectMake(103, 60, CellWidth-105, 20)];
        _supplyPerson.font=[UIFont systemFontOfSize:13];
        [self addSubview:_supplyPerson];
        
        _supplyTel=[[UILabel alloc]initWithFrame:CGRectMake(103, 80, CellWidth-105, 20)];
        _supplyTel.font=[UIFont systemFontOfSize:13];
        //[self addSubview:_supplyTel];
        
        _telLbl=[[stdCallBtn alloc]initWithFrame:CGRectMake(103, 80, CellWidth-105, 20)];
        [self addSubview:_telLbl];
        
        _supplyImg=[[UIImageView alloc]initWithFrame:CGRectMake(2, 4, 80, 70)];
        [self addSubview:_supplyImg];
        
        _carDetail=[[UILabel alloc]initWithFrame:CGRectMake(0, 93, CellWidth, 20)];
        _carDetail.font=[UIFont systemFontOfSize:12];
//        [_carDetail setLineBreakMode:NSLineBreakByWordWrapping];
//        [_carDetail setNumberOfLines:2];
        [_carDetail setTextColor:[UIColor lightGrayColor]];
        [self addSubview:_carDetail];
        
        _startTime=[[UILabel alloc]initWithFrame:CGRectMake(0,110,CellWidth,20)];
        _startTime.font=[UIFont systemFontOfSize:12];
        [_startTime setTextColor:[UIColor lightGrayColor]];
        [self addSubview:_startTime];
    }
    return self;
}


-(void)showUiSupplyCell:(CarExpressDeal*)NModel{
    _goodsName.text=[NSString stringWithFormat:@"%@%@",@"货品名：",NModel.goodsName];
    
    _fromPlace.text=[NSString stringWithFormat:@"%@%@%@%@",@"出发地：",NModel.startProvince,NModel.startCity,NModel.startCounty];
    
    _toPlace.text=[NSString stringWithFormat:@"%@%@%@%@",@"目的地：",NModel.endProvicen,NModel.endCity,NModel.endCounty];
    
    _supplyPerson.text=[NSString stringWithFormat:@"%@%@",@"联系人：",NModel.contact];
    
    _carDetail.text=NModel.infoDesc;//[NSString stringWithFormat:@"%@,%@",NModel.infoDesc];
    //NModel.infoDesc;
    
    _supplyTel.text=[NSString stringWithFormat:@"%@%@",@"联系电话：",NModel.mobile];
    
    [_telLbl setLblText:_supplyTel.text];
    
    _startTime.text=NModel.publicTime;;
    
    _supplyImg.image=[UIImage imageNamed:@"goods"];
    
    
    _cellUrl=NModel.deal_url;
    _expId=NModel.expId;
}

-(CarExpressDeal*)praseModelWithCell:(GoodsInfoTableViewCell *)cell{
    CarExpressDeal *nm = [[CarExpressDeal alloc]init];
    nm.deal_url=cell.cellUrl;
    nm.deal_url=cell.cellUrl;
    nm.startCity=_fromPlace.text;
    nm.endCity=_toPlace.text;
    nm.contact=_supplyPerson.text;
    nm.mobile=_supplyTel.text;
    nm.infoDesc=_carDetail.text;
    nm.publicTime=_startTime.text;
    nm.goodsName=_goodsName.text;
    nm.expId=_expId;
    return nm;
}

@end
