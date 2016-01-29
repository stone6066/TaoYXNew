//
//  ShopListTableViewCell.m
//  TaoYXNew
//
//  Created by tianan-apple on 15/12/16.
//  Copyright © 2015年 tianan-apple. All rights reserved.
//

#import "ShopListTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "CmpModel.h"
#import "stdCallBtn.h"
@implementation ShopListTableViewCell

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
        
        
        _supplyTitle=[[UILabel alloc]initWithFrame:CGRectMake(73,0,CellWidth-105,40)];
        _supplyTitle.font=[UIFont systemFontOfSize:15];
        [_supplyTitle setLineBreakMode:NSLineBreakByWordWrapping];
        [_supplyTitle setNumberOfLines:2];
        [self addSubview:_supplyTitle];
        
        _supplyImg=[[UIImageView alloc]initWithFrame:CGRectMake(2, 12, 70, 60)];
        [self addSubview:_supplyImg];
        
        _supplyDetail=[[UILabel alloc]initWithFrame:CGRectMake(0, 78, CellWidth, 40)];
        _supplyDetail.font=[UIFont systemFontOfSize:12];
        [_supplyDetail setLineBreakMode:NSLineBreakByWordWrapping];
        [_supplyDetail setNumberOfLines:0];
        [_supplyDetail setTextColor:[UIColor lightGrayColor]];
        [self addSubview:_supplyDetail];
        
        
        _supplyPerson=[[UILabel alloc]initWithFrame:CGRectMake(75, 41, 120, 20)];
        _supplyPerson.font=[UIFont systemFontOfSize:13];
        [self addSubview:_supplyPerson];
        
        _supplyTel=[[UILabel alloc]initWithFrame:CGRectMake(75, 63, 190, 20)];
        _supplyTel.font=[UIFont systemFontOfSize:13];
        //[self addSubview:_supplyTel];
        _telLbl=[[stdCallBtn alloc]initWithFrame:CGRectMake(75, 63, 190, 20)];
        [self addSubview:_telLbl];
    }
    return self;
}


-(void)showUiSupplyCell:(CmpModel*)NModel{
    //NSString *strtmp=[NSString stringWithFormat:@"%@%@%@%@",@"【",NModel.supplyType,@"】",NModel.title];
    _supplyTitle.text=NModel.empName;
    
    NSString *strtmp=[NSString stringWithFormat:@"%@%@",@"联系人：",NModel.contact];
    _supplyPerson.text=strtmp;
    _supplyDetail.text=NModel.address;
    
    if (NModel.phone.length>0) {
        strtmp=[NSString stringWithFormat:@"%@%@",@"联系电话：",NModel.phone];
    }
    else
         strtmp=[NSString stringWithFormat:@"%@%@",@"联系电话：",NModel.mobile];
    _supplyTel.text=strtmp;
    [_telLbl setLblText:_supplyTel.text];
    [_supplyImg sd_setImageWithStr:NModel.images];
    _cellUrl=NModel.empDesc;
}

-(CmpModel*)praseModelWithCell:(ShopListTableViewCell *)cell{
    CmpModel *nm = [[CmpModel alloc]init];
    nm.empDesc=cell.cellUrl;
    nm.empName=_supplyTitle.text;
    nm.address=_supplyDetail.text;
    nm.contact=_supplyPerson.text;
    nm.phone=_supplyTel.text;
    
    return nm;
}

@end
