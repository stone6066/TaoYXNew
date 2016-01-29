//
//  MyGrapTableViewCell.m
//  TaoYXNew
//
//  Created by tianan-apple on 16/1/22.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "MyGrapTableViewCell.h"
#import "stdCallBtn.h"
#import "MyGrapDeal.h"
#import "UIImageView+WebCache.h"

@implementation MyGrapTableViewCell

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
        _images=[[UIImageView alloc]initWithFrame:CGRectMake(2, 12, 70, 60)];
        [self addSubview:_images];
        
        _contact=[[UILabel alloc]initWithFrame:CGRectMake(75,0,CellWidth-105,20)];
        _contact.font=[UIFont systemFontOfSize:13];
        [self addSubview:_contact];
        
        _supplyOrderPrice=[[UILabel alloc]initWithFrame:CGRectMake(75,20,CellWidth-105,20)];
        _supplyOrderPrice.font=[UIFont systemFontOfSize:13];
        [self addSubview:_supplyOrderPrice];
        
        _supplyOrderNum=[[UILabel alloc]initWithFrame:CGRectMake(75,40,CellWidth-105,20)];
        _supplyOrderNum.font=[UIFont systemFontOfSize:13];
        [self addSubview:_supplyOrderNum];
        
        _phone=[[stdCallBtn alloc]initWithFrame:CGRectMake(75, 60, 190, 20)];
        [self addSubview:_phone];
        
        _supplyOrderFlag=[[UILabel alloc]initWithFrame:CGRectMake(75,80,CellWidth-105,20)];
        _supplyOrderFlag.font=[UIFont systemFontOfSize:13];
        [self addSubview:_supplyOrderFlag];
        
        _createTime=[[UILabel alloc]initWithFrame:CGRectMake(75,100,CellWidth-105,20)];
        _createTime.font=[UIFont systemFontOfSize:13];
        [self addSubview:_createTime];
        
        _memo=[[UILabel alloc]initWithFrame:CGRectMake(75,120,CellWidth-105,20)];
        _memo.font=[UIFont systemFontOfSize:13];
        [self addSubview:_memo];
        
    }
    return self;
}

-(void)showUiSupplyCell:(MyGrapDeal*)NModel{

    _contact.text=[NSString stringWithFormat:@"%@%@",@"联系人：",NModel.contact];
    _supplyOrderPrice.text=[NSString stringWithFormat:@"%@%@",@"对方报价（元）：",NModel.supplyOrderPrice];
    _supplyOrderNum.text=[NSString stringWithFormat:@"%@%@",@"数量：",NModel.supplyOrderNum];
    
    [_phone setLblText:[NSString stringWithFormat:@"%@%@",@"联系电话：",NModel.mobile]];
    _createTime.text=[NSString stringWithFormat:@"%@%@",@"抢单日期：",NModel.createTime];
    _memo.text=[NSString stringWithFormat:@"%@%@",@"备注：",NModel.memo];
    if ([NModel.supplyOrderFlag isEqualToString:@"0"]) {
        _supplyOrderFlag.text=@"中单状态：抢单中";
    }
    else if ([NModel.supplyOrderFlag isEqualToString:@"1"]) {
        _supplyOrderFlag.text=@"中单状态：中单";
    }
    else  {
        _supplyOrderFlag.text=@"中单状态：未中单";
    }
    [_images sd_setImageWithStr:NModel.images];
    
    _pubId=NModel.pubId;
    _publisher=NModel.publisher;
    _supplyId=NModel.supplyId;
    _supplyOrderId=NModel.supplyOrderId;
    
}
@end
