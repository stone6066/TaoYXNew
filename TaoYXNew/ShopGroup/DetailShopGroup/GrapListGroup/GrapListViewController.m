//
//  GrapListViewController.m
//  TaoYXNew
//
//  Created by tianan-apple on 16/1/18.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "GrapListViewController.h"
#import "PublicDefine.h"
#import "DPAPI.h"
#import "stdPubFunc.h"
#import "MyOrderPriceDeal.h"

@interface GrapListViewController ()<UITextFieldDelegate,UITextViewDelegate,DPRequestDelegate>

@end

@implementation GrapListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadTopNavView];
    [self loadContentView];
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    if (_showType==1) {
        [self DetailNetRequest:_detailId];
    }
    [self stdRightGesture];
}

-(void)stdRightGesture{
    self.rightSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    self.rightSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:self.rightSwipeGestureRecognizer];
}
- (void)handleSwipes:(UISwipeGestureRecognizer *)sender
{
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//顶部导航条
-(void)loadTopNavView{
    UIView *topView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, TopSeachHigh)];
    topView.backgroundColor=topSearchBgdColor;
    
    UIImageView *backimg=[[UIImageView alloc]initWithFrame:CGRectMake(8, 24, 60, 24)];
    backimg.image=[UIImage imageNamed:@"bar_back"];
    [topView addSubview:backimg];
    //返回按钮
    UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
    [back setFrame:CGRectMake(0, 22, 70, 42)];
    [back addTarget:self action:@selector(clickleftbtn) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:back];
    
    //标题
    UILabel *titleLbl=[[UILabel alloc]initWithFrame:CGRectMake(fDeviceWidth/2-40, 30, 80, 20)];
    [titleLbl setText:@"我的报价"];
    [titleLbl setTextColor:[UIColor whiteColor]];
    titleLbl.font=[UIFont systemFontOfSize:18];
    [topView addSubview:titleLbl];
    
    [self.view addSubview:topView];
    
}
-(void)clickleftbtn{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)stdInitTxtF:(UITextField*)txtF hintxt:(NSString*)hintstr{
    txtF.backgroundColor = [UIColor clearColor];
    [txtF setTintColor:[UIColor blueColor]];
    [txtF setFont:[UIFont systemFontOfSize:13]];
    txtF.textAlignment = UITextAutocorrectionTypeDefault;//UITextAlignmentCenter;
    txtF.textColor=tabTxtColor;
    txtF.layer.borderColor = [UIColor lightGrayColor].CGColor; // set color as you want.
    txtF.layer.borderWidth = 1.0f; // set borderWidth as you want.
    txtF.attributedPlaceholder=[[NSAttributedString alloc]initWithString:hintstr attributes:@{NSForegroundColorAttributeName: tabTxtColor}];
    txtF.delegate=self;
}

-(void)loadContentView{
    UIScrollView *MainView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, TopSeachHigh, fDeviceWidth, fDeviceHeight-TopSeachHigh)];
    
    float topY=10;
    float ScrollHeigh=0;
    float txtFWidth=fDeviceWidth-120;
    float txtFLeftX=90;
    float txtFHeigh=30;
    float lblWidth=70;
    CGFloat Fontsize=13;
    UILabel *typelbl=[[UILabel alloc]initWithFrame:CGRectMake(10, topY, 70, txtFHeigh)];
    typelbl.text=@"我的报价:";
    [typelbl setFont:[UIFont systemFontOfSize:Fontsize]];
    [MainView addSubview:typelbl];
    
    _ATxtF = [[UITextField alloc] initWithFrame:CGRectMake(txtFLeftX, topY, txtFWidth, txtFHeigh)];
    _ATxtF.keyboardType=UIKeyboardTypeNumbersAndPunctuation;
    [self stdInitTxtF:_ATxtF hintxt:@"价格：如 23.50"];
    [MainView addSubview:_ATxtF];
    
    UILabel *ulbl=[[UILabel alloc]initWithFrame:CGRectMake(txtFLeftX+txtFWidth+5, topY, 20, txtFHeigh)];
    ulbl.text=@"元";
    [ulbl setFont:[UIFont systemFontOfSize:Fontsize]];
    [MainView addSubview:ulbl];
    
    UILabel *Dlbl=[[UILabel alloc]initWithFrame:CGRectMake(10, topY+40, lblWidth, txtFHeigh)];
    Dlbl.text=@"提供数量:";
    [Dlbl setFont:[UIFont systemFontOfSize:Fontsize]];
    [MainView addSubview:Dlbl];
    _BTxtF = [[UITextField alloc] initWithFrame:CGRectMake(txtFLeftX, topY+40, txtFWidth, txtFHeigh)];
    _BTxtF.keyboardType=UIKeyboardTypeNumbersAndPunctuation;
    [self stdInitTxtF:_BTxtF hintxt:@"数量：整数"];
    [MainView addSubview:_BTxtF];
    
    UILabel *Elbl=[[UILabel alloc]initWithFrame:CGRectMake(10, topY+80, lblWidth, txtFHeigh)];
    Elbl.text=@"联系人:";
    [Elbl setFont:[UIFont systemFontOfSize:Fontsize]];
    [MainView addSubview:Elbl];
    _CTxtF = [[UITextField alloc] initWithFrame:CGRectMake(txtFLeftX, topY+80, txtFWidth, txtFHeigh)];
    [self stdInitTxtF:_CTxtF hintxt:@"联系人"];
    [MainView addSubview:_CTxtF];
    
    
    UILabel *Flbl=[[UILabel alloc]initWithFrame:CGRectMake(10, topY+120, lblWidth, txtFHeigh)];
    Flbl.text=@"手机:";
    [Flbl setFont:[UIFont systemFontOfSize:Fontsize]];
    [MainView addSubview:Flbl];
    _DTxtF = [[UITextField alloc] initWithFrame:CGRectMake(txtFLeftX, topY+120, txtFWidth, txtFHeigh)];
    _DTxtF.keyboardType=UIKeyboardTypeNumbersAndPunctuation;
    [self stdInitTxtF:_DTxtF hintxt:@"手机号码"];
    [MainView addSubview:_DTxtF];
    
    UILabel *Glbl=[[UILabel alloc]initWithFrame:CGRectMake(10, topY+160, lblWidth, txtFHeigh)];
    Glbl.text=@"联系电话";
    [Glbl setFont:[UIFont systemFontOfSize:Fontsize]];
    [MainView addSubview:Glbl];
    _ETxtF = [[UITextField alloc] initWithFrame:CGRectMake(txtFLeftX, topY+160, txtFWidth, txtFHeigh)];
    _ETxtF.keyboardType=UIKeyboardTypeNumbersAndPunctuation;
    [self stdInitTxtF:_ETxtF hintxt:@"电话号码"];
    [MainView addSubview:_ETxtF];

    
    UILabel *detaillbl=[[UILabel alloc]initWithFrame:CGRectMake(10, topY+200, 80, txtFHeigh)];
    detaillbl.text=@"备注说明:";
    [detaillbl setFont:[UIFont systemFontOfSize:Fontsize]];
    [MainView addSubview:detaillbl];
    _detailTxt = [[UITextView alloc] initWithFrame:CGRectMake(txtFLeftX, topY+210, txtFWidth, 120)];
    _detailTxt.backgroundColor = [UIColor clearColor];
    [_detailTxt setTintColor:[UIColor blueColor]];
    _detailTxt.textAlignment = UITextAutocorrectionTypeDefault;//UITextAlignmentCenter;
    _detailTxt.textColor=tabTxtColor;
    _detailTxt.layer.borderColor = [UIColor lightGrayColor].CGColor; // set color as you want.
    _detailTxt.layer.borderWidth = 1.0f; // set borderWidth as you want.
    _detailTxt.delegate=self;
    [MainView addSubview:_detailTxt];
    
    
     _publishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_publishBtn setFrame:CGRectMake(fDeviceWidth/2-60, topY+350, 120, 30)];
    [_publishBtn addTarget:self action:@selector(clickPubbtn) forControlEvents:UIControlEventTouchUpInside];
    [_publishBtn setTitle:@"发  布" forState:UIControlStateNormal];
    [_publishBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _publishBtn.backgroundColor=topSearchBgdColor;
    [MainView addSubview:_publishBtn];
    
    
    ScrollHeigh=topY+480;
    [MainView setContentSize:CGSizeMake(fDeviceWidth, ScrollHeigh)];
    [self.view addSubview:MainView];
}


-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [_ATxtF resignFirstResponder];
    [_BTxtF resignFirstResponder];
    [_CTxtF resignFirstResponder];
    [_DTxtF resignFirstResponder];
    [_ETxtF resignFirstResponder];
    
    [_detailTxt resignFirstResponder];
}

-(void)sortHiddenKeyBoard
{
    if ([_ATxtF isFirstResponder]) {
        [_ATxtF resignFirstResponder];
    }
    if ([_BTxtF isFirstResponder]) {
        [_BTxtF resignFirstResponder];
    }
    if ([_CTxtF isFirstResponder]) {
        [_CTxtF resignFirstResponder];
    }
    if ([_DTxtF isFirstResponder]) {
        [_DTxtF resignFirstResponder];
    }
    if ([_ETxtF isFirstResponder]) {
        [_ETxtF resignFirstResponder];
    }
    if ([_detailTxt isFirstResponder]) {
        [_detailTxt resignFirstResponder];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder]; //这句代码可以隐藏 键盘
    return YES;
}
-(BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    [textView resignFirstResponder]; //这句代码可以隐藏 键盘
    return YES;
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

-(NSMutableDictionary*)makePriceUploadData{
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    
    if (_showType==1) {
        [params setValue:@"mmodifysupplyorder" forKey:@"ut"];
        [params setValue:_detailId forKey:@"supplyOrderId"];
        [params setValue:_supplyType forKey:@"supplyType"];
    }
    else
    {
        [params setValue:@"maddsupplyorder" forKey:@"ut"];
        [params setValue:@"1" forKey:@"supplyType"];
    }

    
    [params setValue:_supplyId forKey:@"supplyId"];
    
    
    [params setValue:_ATxtF.text forKey:@"supplyOrderPrice"];
    [params setValue:_BTxtF.text forKey:@"supplyOrderNum"];
   
    [params setValue:_CTxtF.text forKey:@"contact"];
    [params setValue:_DTxtF.text forKey:@"mobile"];
    [params setValue:_ETxtF.text forKey:@"phone"];
    [params setValue:_detailTxt.text forKey:@"memo"];
    //[params setValue:_ALbl.text forKey:@"supplyPrice"];
    //[params setValue:_typeId forKey:@"supplyUnit"];
     //[params setValue:_BLbl.text forKey:@"valDate"];
    return params;
}

-(NSInteger)checkInfoComplet{
    
    if (_ATxtF.text.length<1) {
        return 0;
    }
    if (_BTxtF.text.length<1) {
        return 0;
    }
    if (_CTxtF.text.length<1) {
        return 0;
    }
    if (_DTxtF.text.length<1) {
        return 0;
    }
    if (_ETxtF.text.length<1) {
        return 0;
    }
    if (_supplyId.length<1) {
        return 0;
    }
    return 1;
}

-(void)clickPubbtn{
    if ([self checkInfoComplet]==1) {
        [self CreateRequest];
    }
    else
    {
        [stdPubFunc stdShowMessage:@"信息不完整，请完善后上传"];
    }
}
//上传数据
- (void)CreateRequest{
    DPAPI *api = [[DPAPI alloc]init];
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    //[params setValue:@"typeandbrand" forKey:@"ut"];
    
    
    
    [api setAllwaysFlash:@"1"];
    
    [api postRequestWithURL: NetUrl params:[self makePriceUploadData] delegate:self];
    [self loadProgress];
    [_progressView setProgress:80];
}

-(void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result
{
    UIView *view = (UIView*)[self.view viewWithTag:108];
    [view removeFromSuperview];
    NSDictionary *dict = result;
    NSString *upResult=[dict objectForKey:@"msg"];
    if ([upResult isEqualToString:@"ok"]) {
        [stdPubFunc stdShowMessage:@"上传成功"];
    }
    else
        [stdPubFunc stdShowMessage:@"上传失败"];
}

-(void)request:(DPRequest *)request didFailWithError:(NSError *)error
{
    //NSLog(@"上传错误:%@",error);
    UIView *view = (UIView*)[self.view viewWithTag:108];
    [view removeFromSuperview];
    [stdPubFunc stdShowMessage:@"上传错误"];
}

-(void)loadProgress{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, TopSeachHigh, fDeviceWidth, fDeviceHeight)];
    [view setTag:108];
    [view setBackgroundColor:[UIColor blackColor]];
    [view setAlpha:0.5];
    
    
    _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(fDeviceWidth/2-75, 180, 150, 20)];
    _progressView.transform = CGAffineTransformMakeScale(1.0f,2.0f);
    [_progressView setProgressViewStyle:UIProgressViewStyleDefault]; //设置进度条类型
    [view addSubview:_progressView];
    
    [self.view addSubview:view];
    
}
-(void)setSupplyId:(NSString *)supplyId
{
    _supplyId=supplyId;
}

-(void)setDetailId:(NSString *)detailId{
    _detailId=detailId;
}
-(void)setShowType:(NSInteger)showType{
    _showType=showType;
}


-(void)DetailNetRequest:(NSString*)detailId{
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setValue:@"msupplyorderdetail" forKey:@"ut"];
    [params setValue:detailId forKey:@"id"];
    DPAPI *api = [[DPAPI alloc]init];
    
    [api loginRequestWithURL:NetUrl params:params delegate:self];
    
}

-(void)loginrequest:(DPRequest *)request didFinishLoadingWithResult:(id)result{
    MyOrderPriceDeal *dm=[[MyOrderPriceDeal alloc]init];
    NSDictionary *dict = result;
    NSArray *datatmp;
    datatmp=[dm asignModelWithDict:dict];
    [self initContent:datatmp];
     //NSLog(@"%@",result);
}


-(void)initContent:(NSArray *)contentArr{
    MyOrderPriceDeal *mydm=[[MyOrderPriceDeal alloc]init];
    if (contentArr.count>0) {
        [_publishBtn setTitle:@"修  改" forState:UIControlStateNormal];
        mydm=contentArr[0];
        _ATxtF.text=mydm.supplyOrderPrice;
        _BTxtF.text=mydm.supplyOrderNum;
        _CTxtF.text=mydm.contact;
        _DTxtF.text=mydm.mobile;
        _ETxtF.text=mydm.phone;
        _detailTxt.text=mydm.memo;
        _supplyId=mydm.supplyId;
        _supplyType=mydm.supplyType;
    }
    
}

@end
