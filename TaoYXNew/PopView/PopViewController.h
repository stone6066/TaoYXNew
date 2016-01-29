//
//  PopViewController.h
//  团购项目
//
//  Created by lb on 15/5/27.
//  Copyright (c) 2015年 lbcoder. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopViewController : UIViewController
@property (nonatomic, copy) void (^TypeChangeBlock) (PopViewController *,NSString *,NSString*,NSInteger);
@property (nonatomic,assign)NSInteger dataType;//显示的菜单数据类型 0区域 1类别
@end
