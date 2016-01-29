//
//  HomeCollectionViewCell.h
//  TaoYXNew
//
//  Created by tianan-apple on 15/12/7.
//  Copyright © 2015年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HomeModel;
@interface HomeCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (nonatomic,copy)NSString *deal_id;
- (void)showUIWithModel:(HomeModel *)model;
-(HomeModel*)praseModelWithCell:(HomeCollectionViewCell *)cell;
@end
