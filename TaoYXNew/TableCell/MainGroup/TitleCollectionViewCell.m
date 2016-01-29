//
//  TitleCollectionViewCell.m
//  TaoYXNew
//
//  Created by tianan-apple on 15/12/7.
//  Copyright © 2015年 tianan-apple. All rights reserved.
//

#import "TitleCollectionViewCell.h"
#import "PublicDefine.h"

@implementation TitleCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //
        _backView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, fDeviceWidth, 35)];
        _backView1.backgroundColor=[UIColor whiteColor];
        
        _labTitle=[[UILabel alloc]initWithFrame:CGRectMake(35, 0, fDeviceWidth, 35)];
        //[_labTitle setText:_CellTitle];
        [_labTitle setTextColor:TitleCollectionColor];
        [_backView1 addSubview:_labTitle];
        _backView1.backgroundColor=[UIColor whiteColor];
        
        UIImageView *myicon=[[UIImageView alloc]initWithFrame:CGRectMake(10, 8, 20, 20)];
        myicon.image=[UIImage imageNamed:@"farm"];
        [_backView1 addSubview:myicon];
        
        [self addSubview:_backView1];
    }
    return self;
}

-(void)setlabtitleTxt:(NSString*)lblstr{
    [_labTitle setText:lblstr];
}
//- (id)initWithFrame:(CGRect)frame cellTitle:(NSString*)titleStr
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        //
//        _backView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, fDeviceWidth, 35)];
//        _backView1.backgroundColor=[UIColor whiteColor];
//        
//        UILabel *labTitle=[[UILabel alloc]initWithFrame:CGRectMake(35, 0, fDeviceWidth, 35)];
//        [labTitle setText:titleStr];
//        [labTitle setTextColor:TitleCollectionColor];
//        [_backView1 addSubview:labTitle];
//        _backView1.backgroundColor=[UIColor whiteColor];
//        
//        UIImageView *myicon=[[UIImageView alloc]initWithFrame:CGRectMake(10, 8, 20, 20)];
//        myicon.image=[UIImage imageNamed:@"farm"];
//        [_backView1 addSubview:myicon];
//        
//        [self addSubview:_backView1];
//    }
//    return self;
//}
@end
