//
//  GrapListViewController.h
//  TaoYXNew
//
//  Created by tianan-apple on 16/1/18.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GrapListViewController : UIViewController
@property(nonatomic,strong)UITextField *ATxtF;
@property(nonatomic,strong)UITextField *BTxtF;
@property(nonatomic,strong)UITextField *CTxtF;
@property(nonatomic,strong)UITextField *DTxtF;
@property(nonatomic,strong)UITextField *ETxtF;
@property(nonatomic,strong)UITextView *detailTxt;
@property(nonatomic,strong)UIProgressView *progressView;
@property(nonatomic,copy)NSString *supplyId;
@property(nonatomic,assign)NSInteger showType;//1修改 0新增
@property(nonatomic,copy)NSString *detailId;//id
@property(nonatomic,copy)UIButton *publishBtn;//id
@property(nonatomic,copy)NSString *supplyType;
@property (nonatomic, strong) UISwipeGestureRecognizer *rightSwipeGestureRecognizer;
@end
