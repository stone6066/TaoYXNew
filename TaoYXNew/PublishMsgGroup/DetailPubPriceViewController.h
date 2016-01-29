//
//  DetailPubPriceViewController.h
//  TaoYXNew
//
//  Created by tianan-apple on 16/1/8.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailPubPriceViewController : UIViewController
@property(nonatomic,strong)UITextField *ATxtF;
@property(nonatomic,strong)UITextField *BTxtF;
//@property(nonatomic,strong)UITextField *CTxtF;
//@property(nonatomic,strong)UITextField *DTxtF;
//@property(nonatomic,strong)UITextField *ETxtF;
//@property(nonatomic,strong)UITextField *FTxtF;
@property(nonatomic,strong)UITextView *detailTxt;
@property(nonatomic,strong)UILabel *ALbl;
@property(nonatomic,strong)UILabel *BLbl;
@property(nonatomic,strong)UILabel *CLbl;
@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UIProgressView *progressView;

@property(nonatomic,copy)NSString *typeId;//品名id
@property(nonatomic,copy)NSString *typeName;//品名id
@property(nonatomic,copy)NSString *brandId;//品名id

@property(nonatomic,copy)NSString *areaId;//区域id


@property(nonatomic,assign)NSInteger showType;//1修改 0新增
@property(nonatomic,copy)NSString *detailId;//id
@property(nonatomic,strong)UILabel *upLoad;
@property (nonatomic, strong) UISwipeGestureRecognizer *rightSwipeGestureRecognizer;
@end
