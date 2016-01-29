//
//  DetailPubSupplyViewController.h
//  TaoYXNew
//
//  Created by tianan-apple on 16/1/8.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RadioButton;
@interface DetailPubSupplyViewController : UIViewController
@property(nonatomic,strong)UITextField *ATxtF;
@property(nonatomic,strong)UITextField *BTxtF;
@property(nonatomic,strong)UITextField *CTxtF;
@property(nonatomic,strong)UITextField *DTxtF;
@property(nonatomic,strong)UITextField *ETxtF;
//@property(nonatomic,strong)UITextField *FTxtF;
@property(nonatomic,strong)UITextView *detailTxt;
@property(nonatomic,strong)UILabel *areaLbl;
@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UIProgressView *progressView;
@property(nonatomic,strong)UILabel *ALbl;
@property(nonatomic,strong)UILabel *BLbl;
@property(nonatomic,strong)UILabel *CLbl;
@property(nonatomic,strong)UILabel *DLbl;
@property(nonatomic,strong)RadioButton *rb1;
@property(nonatomic,strong)RadioButton *rb2;
@property(nonatomic,copy)NSString *supplyType;//供求类型 0供应 1求购
@property(nonatomic,copy)NSString *typeId;//品名id
@property(nonatomic,copy)NSString *areaId;//区域id
@property(nonatomic,strong)UILabel *upLoad;
@property(nonatomic,assign)NSInteger showType;//1修改 0新增
@property(nonatomic,copy)NSString *detailId;//id
@property(nonatomic,copy)NSString *supplyId;//id


@property(nonatomic,strong)UILabel *detailLbl;
@property(nonatomic,strong)UIButton *detailBtn;
@property (nonatomic, strong) UISwipeGestureRecognizer *rightSwipeGestureRecognizer;

@end
