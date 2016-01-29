//
//  TitleCollectionViewCell.h
//  TaoYXNew
//
//  Created by tianan-apple on 15/12/7.
//  Copyright © 2015年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TitleCollectionViewCell : UICollectionViewCell
{
    UIView *_backView1;
    UIView *_backView2;
}
@property(nonatomic,strong)UILabel *labTitle;
-(void)setlabtitleTxt:(NSString*)lblstr;
@end
