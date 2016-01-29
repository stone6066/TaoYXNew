//
//  NavTableViewCell.h
//  TaoYXNew
//
//  Created by tianan-apple on 15/12/9.
//  Copyright © 2015年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NavModel;

@interface NavTableViewCell : UITableViewCell
@property(nonatomic,strong)UILabel *newsTitle;
@property(nonatomic,strong)UIImageView *newsImg;
@property(nonatomic,strong)UILabel *newsDetail;
@property(nonatomic,strong)NSString *cellUrl;
-(void)showUiNewsCell:(NavModel*)NModel;
-(NavModel*)praseModelWithCell:(NavTableViewCell *)cell;
@end
