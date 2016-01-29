//
//  ExpressViewController.h
//  TaoYXNew
//
//  Created by tianan-apple on 15/12/16.
//  Copyright © 2015年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExpressViewController : UIViewController
@property(nonatomic,copy)NSString *topTitle;
@property(nonatomic,copy)NSMutableArray *TitleArr;
@property(nonatomic,assign)NSInteger viewType;//显示类型
@property (nonatomic, strong) UISwipeGestureRecognizer *rightSwipeGestureRecognizer;
-(void)setTopTitle:(NSString *)topTitle;
-(void)setTitleArr:(NSMutableArray *)TitleArr;
@end
