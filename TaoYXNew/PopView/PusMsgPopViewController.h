//
//  PusMsgPopViewController.h
//  TaoYXNew
// 显示的时候不带全部
//  Created by tianan-apple on 16/1/14.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PusMsgPopViewController : UIViewController
@property (nonatomic, copy) void (^TypeChangeBlock) (PusMsgPopViewController *,NSString *,NSString*,NSInteger,NSString*,NSString*);
@property (nonatomic,assign)NSInteger dataType;//显示的菜单数据类型 0区域 1类别
@end
