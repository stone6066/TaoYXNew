//
//  LocalStationTableViewCell.m
//  TaoYXNew
//
//  Created by tianan-apple on 15/12/17.
//  Copyright © 2015年 tianan-apple. All rights reserved.
//

#import "LocalStationTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "LocalStationDeal.h"
#import "stdCallBtn.h"
@implementation LocalStationTableViewCell

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
        
        _business=[[UILabel alloc]initWithFrame:CGRectMake(83,30,CellWidth-105,20)];
        _business.font=[UIFont systemFontOfSize:13];
        [self addSubview:_business];
        
        _mobile=[[UILabel alloc]initWithFrame:CGRectMake(83, 60, CellWidth-105, 20)];
        _mobile.font=[UIFont systemFontOfSize:13];
        //[self addSubview:_mobile];
        _telLbl=[[stdCallBtn alloc]initWithFrame:CGRectMake(83, 60, CellWidth-105, 20)];
        [self addSubview:_telLbl];
        
//        _publicTime=[[UILabel alloc]initWithFrame:CGRectMake(0,107,CellWidth,20)];
//        _publicTime.font=[UIFont systemFontOfSize:12];
//        [_publicTime setTextColor:[UIColor lightGrayColor]];
//        [self addSubview:_publicTime];

        
        _addr=[[UILabel alloc]initWithFrame:CGRectMake(0, 75, CellWidth, 40)];
        _addr.font=[UIFont systemFontOfSize:12];
        [_addr setLineBreakMode:NSLineBreakByWordWrapping];
        [_addr setNumberOfLines:2];
        [_addr setTextColor:[UIColor lightGrayColor]];
        [self addSubview:_addr];

        
        
        
        _supplyImg=[[UIImageView alloc]initWithFrame:CGRectMake(2, 4, 70, 60)];
        
        [self addSubview:_supplyImg];
        

        
           }
    return self;
}


-(void)showUiSupplyCell:(LocalStationDeal*)NModel{
    
    _logEmpName.text=[NSString stringWithFormat:@"%@%@",@"名称：",NModel.logEmpName];
    _business.text=[NSString stringWithFormat:@"%@%@",@"主营：",NModel.business];
    _mobile.text=[NSString stringWithFormat:@"%@%@",@"电话：",NModel.mobile];
    _addr.text=[NSString stringWithFormat:@"%@%@",@"地址：",NModel.address];
    _supplyImg.image=[UIImage imageNamed:@"station"];
    [_telLbl setLblText:_mobile.text];
    _infoDesc=NModel.infoDesc;
    _cellUrl=NModel.deal_url;
}

-(LocalStationDeal*)praseModelWithCell:(LocalStationTableViewCell *)cell{
    LocalStationDeal *nm = [[LocalStationDeal alloc]init];
    nm.deal_url=cell.cellUrl;

    return nm;
}

@end
