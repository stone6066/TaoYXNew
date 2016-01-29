//
//  HomeCollectionViewCell.m
//  TaoYXNew
//
//  Created by tianan-apple on 15/12/7.
//  Copyright © 2015年 tianan-apple. All rights reserved.
//

#import "HomeCollectionViewCell.h"
#import "PublicDefine.h"
#import "UIImageView+WebCache.h"
#import "HomeModel.h"
@implementation HomeCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)showUIWithModel:(HomeModel *)model{
    self.title.text=model.title;
    self.price.text=model.price;
    self.deal_id=model.dealurl;
    if(![model.imageurl isEqual:[NSNull null]])
        [self.imageV sd_setImageWithStr:model.imageurl];
    else {
        self.imageV.image=[UIImage imageNamed:DefaultsImage];
    }
}

-(HomeModel*)praseModelWithCell:(HomeCollectionViewCell *)cell{
    HomeModel *dm = [[HomeModel alloc]init];
    dm.title=cell.title.text;
    //dm.Description=cell.price.text;
    dm.dealurl=cell.deal_id;
    return dm;
}
@end
