//
//  MySupplyOrderTableViewCell.m
//  TaoYXNew
//
//  Created by tianan-apple on 16/1/20.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "MySupplyOrderTableViewCell.h"
#import "PublicDefine.h"
#import "MySupplyOrderDeal.h"
#import "UIImageView+WebCache.h"

@implementation MySupplyOrderTableViewCell

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
        _supplyImg=[[UIImageView alloc]initWithFrame:CGRectMake(2, 12, 70, 60)];
        [self addSubview:_supplyImg];
        
        _supplyTitle=[[UILabel alloc]initWithFrame:CGRectMake(75,0,CellWidth-105,20)];
        _supplyTitle.font=[UIFont systemFontOfSize:13];
        [_supplyTitle setLineBreakMode:NSLineBreakByWordWrapping];
        [_supplyTitle setNumberOfLines:2];
        [self addSubview:_supplyTitle];
        
        
        
        _supplyState=[[UILabel alloc]initWithFrame:CGRectMake(75, 20, 120, 20)];
        _supplyState.font=[UIFont systemFontOfSize:13];
        [self addSubview:_supplyState];
        
        
        _supplyPrice=[[UILabel alloc]initWithFrame:CGRectMake(75, 40, 120, 20)];
        _supplyPrice.font=[UIFont systemFontOfSize:13];
        [self addSubview:_supplyPrice];
        
        _supplyOrderPrice=[[UILabel alloc]initWithFrame:CGRectMake(75, 60, 120, 20)];
        _supplyOrderPrice.font=[UIFont systemFontOfSize:13];
        [self addSubview:_supplyOrderPrice];
        
        _supplyOrderNum=[[UILabel alloc]initWithFrame:CGRectMake(75, 80, 190, 20)];
        _supplyOrderNum.font=[UIFont systemFontOfSize:13];
        [self addSubview:_supplyOrderNum];
        
        
        _supplyValidate=[[UILabel alloc]initWithFrame:CGRectMake(75, 100, 190, 20)];
        _supplyValidate.font=[UIFont systemFontOfSize:13];
        [self addSubview:_supplyValidate];
        
    }
    return self;
}


-(void)showUiSupplyCell:(MySupplyOrderDeal*)NModel{
   
    _supplyTitle.text=[NSString stringWithFormat:@"%@%@%@%@",@"【",NModel.supplyType,@"】",NModel.title];

    _supplyState.text=[NSString stringWithFormat:@"%@%@",@"抢单状态：",NModel.supplyOrderFlag];

    _supplyPrice.text=[NSString stringWithFormat:@"%@%@%@%@",@"供求价格：",NModel.supplyPrice,@"/",NModel.supplyUnit];

    _supplyOrderPrice.text=[NSString stringWithFormat:@"%@%@",@"我的报价：",NModel.supplyOrderPrice];
    
    _supplyOrderNum.text=[NSString stringWithFormat:@"%@%@",@"我的数量：",NModel.supplyOrderNum];
    
    _supplyValidate.text=[NSString stringWithFormat:@"%@%@",@"有效日期：",NModel.supplyValidate];
    
    [_supplyImg sd_setImageWithStr:NModel.images];
    
    _supplyOrderId=NModel.supplyOrderId;
    
   }

-(MySupplyOrderDeal*)praseModelWithCell:(MySupplyOrderTableViewCell *)cell{
    MySupplyOrderDeal *nm = [[MySupplyOrderDeal alloc]init];
    nm.supplyOrderId=cell.supplyOrderId;
    return nm;
}
@end
