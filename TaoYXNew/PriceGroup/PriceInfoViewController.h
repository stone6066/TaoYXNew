//
//  PriceInfoViewController.h
//  TaoYXNew
//
//  Created by tianan-apple on 15/12/17.
//  Copyright © 2015年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PriceInfoViewController : UIViewController
@property(nonatomic,copy)NSString *topTitle;
@property(nonatomic,copy)NSMutableArray *TitleArr;
@property (nonatomic, strong) UISwipeGestureRecognizer *rightSwipeGestureRecognizer;
//@property(nonatomic,strong)UILabel *PlaceLbl;
//@property(nonatomic,strong)UILabel *TypeLbl;
//@property(nonatomic,strong)UILabel *TimeLbl;
//@property(nonatomic,strong)UIButton *PlaceBtn;
//@property(nonatomic,strong)UIButton *MarketBtn;
//@property(nonatomic,strong)UIButton *TraceBtn;
@end
