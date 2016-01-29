//
//  OrderListTableViewCell.m
//  TaoYXNew
//
//  Created by tianan-apple on 15/12/16.
//  Copyright © 2015年 tianan-apple. All rights reserved.
//

#import "OrderListTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "dealModel.h"
@implementation OrderListTableViewCell

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
        
        
        _supplyTitle=[[UILabel alloc]initWithFrame:CGRectMake(2,0,CellWidth,40)];
        _supplyTitle.font=[UIFont systemFontOfSize:15];
        [_supplyTitle setLineBreakMode:NSLineBreakByWordWrapping];
        [_supplyTitle setNumberOfLines:0];
        [self addSubview:_supplyTitle];
        
       
        
        _supplyDetail=[[UILabel alloc]initWithFrame:CGRectMake(2, 40, CellWidth, 40)];
        _supplyDetail.font=[UIFont systemFontOfSize:12];
        [_supplyDetail setLineBreakMode:NSLineBreakByWordWrapping];
        [_supplyDetail setNumberOfLines:0];
        [_supplyDetail setTextColor:[UIColor lightGrayColor]];
        [self addSubview:_supplyDetail];
        
        
        _supplyPerson=[[UILabel alloc]initWithFrame:CGRectMake(2, 80, 120, 20)];
        _supplyPerson.font=[UIFont systemFontOfSize:13];
        [_supplyPerson setTextColor:[UIColor redColor]];
        [self addSubview:_supplyPerson];
        
        
    }
    return self;
}


-(void)showUiSupplyCell:(dealModel*)NModel{
    
    _supplyTitle.text=NModel.title;
    
    _supplyDetail.text=NModel.Description;
    
    NSString *strtmp=[NSString stringWithFormat:@"%@%@",@"金额：",NModel.current_price];
    _supplyPerson.text=strtmp;
    _cellUrl=NModel.deal_url;
}

-(dealModel*)praseModelWithCell:(OrderListTableViewCell *)cell{
    dealModel *nm = [[dealModel alloc]init];
    nm.deal_url=cell.cellUrl;
    
    return nm;
}
@end
