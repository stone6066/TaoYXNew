//
//  MsgSettingViewController.h
//  TaoYXNew
//
//  Created by tianan-apple on 16/1/6.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MsgSettingViewController : UIViewController
{
    NSMutableArray *TypeCheckboxes;
    NSMutableArray *CityCheckboxes;
}
@property(nonatomic,strong)UIView *backView1;
@property(nonatomic,copy)NSString *topTitle;
@property (nonatomic, strong) UISwipeGestureRecognizer *rightSwipeGestureRecognizer;
@end
