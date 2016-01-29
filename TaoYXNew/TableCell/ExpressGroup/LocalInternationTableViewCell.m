//
//  LocalInternationTableViewCell.m
//  TaoYXNew
//
//  Created by tianan-apple on 15/12/17.
//  Copyright © 2015年 tianan-apple. All rights reserved.
//

#import "LocalInternationTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "InternationExpDeal.h"
#import "stdCallBtn.h"

@implementation LocalInternationTableViewCell

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
        
        
        _logEmpName=[[UILabel alloc]initWithFrame:CGRectMake(83,0,CellWidth-105,20)];
        _logEmpName.font=[UIFont systemFontOfSize:13];
        [self addSubview:_logEmpName];
        
        _line=[[UILabel alloc]initWithFrame:CGRectMake(83,30,CellWidth-105,20)];
        _line.font=[UIFont systemFontOfSize:13];
        [self addSubview:_line];
        
        _mobile=[[UILabel alloc]initWithFrame:CGRectMake(83, 60, CellWidth-105, 20)];
        _mobile.font=[UIFont systemFontOfSize:13];
        //[self addSubview:_mobile];
        
        _telLbl=[[stdCallBtn alloc]initWithFrame:CGRectMake(83, 60, CellWidth-105, 20)];
        [self addSubview:_telLbl];
        
        _address=[[UILabel alloc]initWithFrame:CGRectMake(0, 75, CellWidth, 40)];
        _address.font=[UIFont systemFontOfSize:12];
        [_address setLineBreakMode:NSLineBreakByWordWrapping];
        [_address setNumberOfLines:2];
        [_address setTextColor:[UIColor lightGrayColor]];
        [self addSubview:_address];
        
        
        
        
        _supplyImg=[[UIImageView alloc]initWithFrame:CGRectMake(2, 4, 70, 60)];
        [self addSubview:_supplyImg];
        
        
        
    }
    return self;
}


-(void)showUiSupplyCell:(InternationExpDeal*)NModel{
    _logEmpName.text=[NSString stringWithFormat:@"%@%@",@"名称：",NModel.logEmpName];
    
    _line.text=[NSString stringWithFormat:@"%@%@",@"线路：",NModel.line];
    
    _mobile.text=[NSString stringWithFormat:@"%@%@",@"电话：",NModel.mobile];
    [_telLbl setLblText:_mobile.text];
    _address.text=[NSString stringWithFormat:@"%@%@",@"地址：",NModel.address];
    
    _supplyImg.image=[UIImage imageNamed:@"station"];
    
    _cellUrl=NModel.deal_url;
}

-(InternationExpDeal*)praseModelWithCell:(LocalInternationTableViewCell *)cell{
    InternationExpDeal *nm = [[InternationExpDeal alloc]init];
    nm.deal_url=cell.cellUrl;
    
    return nm;
}

@end
