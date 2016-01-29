//
//  SupplyTableViewCell.m
//  TaoYXNew
//
//  Created by tianan-apple on 15/12/16.
//  Copyright © 2015年 tianan-apple. All rights reserved.
//

#import "SupplyTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "SupplyModel.h"
#import "PublicDefine.h"
#import "stdCallBtn.h"

@implementation SupplyTableViewCell

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
        
        _supplyTitle=[[UILabel alloc]initWithFrame:CGRectMake(75,0,CellWidth-105,40)];
        _supplyTitle.font=[UIFont systemFontOfSize:15];
        [_supplyTitle setLineBreakMode:NSLineBreakByWordWrapping];
        [_supplyTitle setNumberOfLines:2];
        [self addSubview:_supplyTitle];

        
        
//        _supplyDetail=[[UILabel alloc]initWithFrame:CGRectMake(0, 78, CellWidth, 40)];
//        _supplyDetail.font=[UIFont systemFontOfSize:12];
//        [_supplyDetail setLineBreakMode:NSLineBreakByWordWrapping];
//        [_supplyDetail setNumberOfLines:0];
//        [_supplyDetail setTextColor:[UIColor lightGrayColor]];
//        [self addSubview:_supplyDetail];
        
        _supplyDetail=[[UILabel alloc]initWithFrame:CGRectMake(75, 35, 120, 20)];
        _supplyDetail.font=[UIFont systemFontOfSize:13];
        [self addSubview:_supplyDetail];
        
        
        _supplyPerson=[[UILabel alloc]initWithFrame:CGRectMake(75, 55, 120, 20)];
        _supplyPerson.font=[UIFont systemFontOfSize:13];
        [self addSubview:_supplyPerson];
        
        _supplyPrice=[[UILabel alloc]initWithFrame:CGRectMake(75, 75, 120, 20)];
        _supplyPrice.font=[UIFont systemFontOfSize:13];
        [self addSubview:_supplyPrice];
        
        _supplyTel=[[UILabel alloc]initWithFrame:CGRectMake(75, 75, 190, 20)];
        _supplyTel.font=[UIFont systemFontOfSize:13];
        //[self addSubview:_supplyTel];
        _telLbl=[[stdCallBtn alloc]initWithFrame:CGRectMake(75, 95, 190, 20)];
        [self addSubview:_telLbl];
        
        
        
    }
    return self;
}


-(void)showUiSupplyCell:(SupplyModel*)NModel{
    NSString *strtmp=[NSString stringWithFormat:@"%@%@%@%@",@"【",NModel.supplyType,@"】",NModel.title];
    _supplyTitle.text=strtmp;
   
    strtmp=[NSString stringWithFormat:@"%@%@",@"联系人：",NModel.name];
    _supplyPerson.text=strtmp;
    
    _supplyDetail.text=[NSString stringWithFormat:@"%@%@",@"类别：",NModel.brandName];
    
    
    strtmp=[NSString stringWithFormat:@"%@%@",@"联系电话：",NModel.phone];
    _supplyTel.text=strtmp;
    
    _supplyPrice.text=NModel.supplyPrice;//[NSString stringWithFormat:@"%@%@",@"价格：",NModel.supplyPrice];
    
    
    [_telLbl setLblText:_supplyTel.text];
    [_supplyImg sd_setImageWithStr:NModel.images];

    _cellUrl=NModel.supplyDesc;
    _supplyId=NModel.supplyId;
    _pubId=NModel.pubId;
}

-(SupplyModel*)praseModelWithCell:(SupplyTableViewCell *)cell{
    SupplyModel *nm = [[SupplyModel alloc]init];
    nm.supplyDesc=cell.cellUrl;
    nm.supplyType=cell.supplyTitle.text;
    nm.name=cell.supplyPerson.text;
    nm.brandName=cell.supplyDetail.text;
    nm.phone=cell.supplyTel.text;
    nm.supplyId=cell.supplyId;
    nm.supplyPrice=cell.supplyPrice.text;
    nm.pubId=cell.pubId;
    return nm;
}

@end
