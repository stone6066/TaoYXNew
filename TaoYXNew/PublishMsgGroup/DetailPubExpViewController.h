//
//  DetailPubExpViewController.h
//  TaoYXNew
//
//  Created by tianan-apple on 16/1/8.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RadioButton;
@class HZAreaPickerView;

@interface DetailPubExpViewController : UIViewController
@property(nonatomic,strong)UITextField *ATxtF;
@property(nonatomic,strong)UITextField *BTxtF;
@property(nonatomic,strong)UITextField *CTxtF;
@property(nonatomic,strong)UITextField *DTxtF;
@property(nonatomic,strong)UITextField *ETxtF;
@property(nonatomic,strong)UITextField *FTxtF;
@property(nonatomic,strong)UITextField *GTxtF;
@property(nonatomic,strong)UITextField *HTxtF;

@property(nonatomic,strong)UILabel *ALbl;
@property(nonatomic,strong)UILabel *BLbl;
@property(nonatomic,strong)UILabel *CLbl;
@property(nonatomic,strong)UILabel *DLbl;
@property(nonatomic,strong)UILabel *ELbl;
@property(nonatomic,strong)UILabel *FLbl;
@property(nonatomic,strong)UILabel *GLbl;
@property(nonatomic,strong)UILabel *HLbl;
@property(nonatomic,strong)UILabel *ILbl;
@property(nonatomic,strong)UILabel *JLbl;
@property(nonatomic,strong)UILabel *KLbl;
@property(nonatomic,strong)UILabel *LLbl;
@property(nonatomic,strong)UILabel *MLbl;
@property(nonatomic,strong)UILabel *NLbl;

@property(nonatomic,strong)UIDatePicker *datePick;
@property(nonatomic,strong)RadioButton *rb1;
@property(nonatomic,strong)RadioButton *rb2;

@property(nonatomic,strong)UITextView *detailTxt;
@property(nonatomic,strong)UILabel *areaLbl;
@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UIProgressView *progressView;
@property (strong, nonatomic) HZAreaPickerView *locatePicker;
@property (strong, nonatomic) NSString *areaValue, *cityValue;
@property (strong, nonatomic) UIScrollView *MainView;
@property(nonatomic,strong)UILabel *upLoad;
@property(nonatomic,assign)NSInteger showType;//1修改 0新增
@property(nonatomic,copy)NSString *detailId;//id
@property (nonatomic, strong) UISwipeGestureRecognizer *rightSwipeGestureRecognizer;
@end
