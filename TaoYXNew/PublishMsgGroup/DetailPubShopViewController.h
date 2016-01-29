//
//  DetailPubShopViewController.h
//  TaoYXNew
//
//  Created by tianan-apple on 16/1/9.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailPubShopViewController : UIViewController
@property(nonatomic,strong)UITextField *ATxtF;
@property(nonatomic,strong)UITextField *BTxtF;
@property(nonatomic,strong)UITextField *CTxtF;
@property(nonatomic,strong)UITextField *DTxtF;
@property(nonatomic,strong)UITextField *ETxtF;
@property(nonatomic,strong)UITextField *FTxtF;
@property(nonatomic,strong)UITextView *detailTxt;
@property(nonatomic,strong)UILabel *areaLbl;
@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UIProgressView *progressView;
@property(nonatomic,copy)NSString *areaId;
@property(nonatomic,assign)NSInteger showType;//1修改 0新增
@property(nonatomic,copy)NSString *detailId;//id
@property (nonatomic, strong) UISwipeGestureRecognizer *rightSwipeGestureRecognizer;
@end
