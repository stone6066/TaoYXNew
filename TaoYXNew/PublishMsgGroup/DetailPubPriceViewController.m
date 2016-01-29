//
//  DetailPubPriceViewController.m
//  TaoYXNew
//
//  Created by tianan-apple on 16/1/8.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "DetailPubPriceViewController.h"
#import "PublicDefine.h"
#import "QuartzCore/QuartzCore.h"
#import "StdUploadFileApi.h"
#import "PusMsgPopViewController.h"
#import "PopMsgUnitViewController.h"
#import "DPAPI.h"
#import "Reachability.h"
#import "stdPubFunc.h"
#import "PricePlaceModel.h"

@interface DetailPubPriceViewController ()<UITextFieldDelegate,UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,uploadProgressDelegate,DPRequestDelegate>
{
    BOOL isFullScreen;
    NSString *imgFullpath;
}
@end

@implementation DetailPubPriceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadNavTopView];
    [self loadContentView];
    imgFullpath=@"";
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
    // Do any additional setup after loading the view.
    
    if (_showType==1) {
        [self DetailNetRequest:_detailId];
    }
    
    [self stdRightGesture];
    // Do any additional setup after loading the view.
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

- (void)loadNavTopView
{
    UIView *topSearch=[[UIView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, TopSeachHigh)];
    topSearch.backgroundColor=topSearchBgdColor;
    
    UILabel *viewTitle=[[UILabel alloc]initWithFrame:CGRectMake(fDeviceWidth/2-60, 20, 200, 40)];
    viewTitle.text=@"发布价格行情";
    [viewTitle setTextColor:[UIColor whiteColor]];
    [viewTitle setFont:[UIFont systemFontOfSize:16]];
    [topSearch addSubview:viewTitle];
    
    UIImageView *backimg=[[UIImageView alloc]initWithFrame:CGRectMake(8, 24, 60, 24)];
    backimg.image=[UIImage imageNamed:@"bar_back"];
    [topSearch addSubview:backimg];
    //返回按钮plus.jpg
    UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
    [back setFrame:CGRectMake(0, 22, 70, 44)];
    [back addTarget:self action:@selector(clickleftbtn) forControlEvents:UIControlEventTouchUpInside];
    [topSearch addSubview:back];
    
    UIImageView *plusimg=[[UIImageView alloc]initWithFrame:CGRectMake(fDeviceWidth-28, 28, 18, 18)];
    plusimg.image=[UIImage imageNamed:@"upload"];
    [topSearch addSubview:plusimg];
    
    _upLoad=[[UILabel alloc]initWithFrame:CGRectMake(fDeviceWidth-60, 20, 40, 40)];
    _upLoad.text=@"上传";
    [_upLoad setTextColor:[UIColor whiteColor]];
    [_upLoad setFont:[UIFont systemFontOfSize:16]];
    [topSearch addSubview:_upLoad];
    
    UIButton *upLoadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [upLoadBtn setFrame:CGRectMake(fDeviceWidth-60, 20, 60, 44)];
    [upLoadBtn addTarget:self action:@selector(clickUpbtn) forControlEvents:UIControlEventTouchUpInside];
    [topSearch addSubview:upLoadBtn];
    
    [self.view addSubview:topSearch];
}

-(void)clickleftbtn{
    [self.navigationController popViewControllerAnimated:YES];
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

//上传数据
- (void)CreateRequest{
    DPAPI *api = [[DPAPI alloc]init];
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
    UIView *view = (UIView*)[self.view viewWithTag:108];
    [view removeFromSuperview];
    [stdPubFunc stdShowMessage:@"上传错误"];
}

//[params setValue:_ATxtF.text forKey:@"origin"];
//[params setValue:_brandId forKey:@"brandId"];
//[params setValue:_ALbl.text forKey:@"brandName"];
//[params setValue:_typeId forKey:@"typeId"];
//[params setValue:_typeName forKey:@"typeName"];
//[params setValue:_areaId forKey:@"areaId"];
//[params setValue:_BLbl.text forKey:@"areaName"];
//[params setValue:_BTxtF.text forKey:@"price"];
//[params setValue:_CLbl.text forKey:@"unit"];
//[params setValue:_detailTxt.text forKey:@"priceDesc"];

-(NSInteger)checkInfoComplet{
    
    if (_ATxtF.text.length<1) {
        return 0;
    }
    if (_BTxtF.text.length<1) {
        return 0;
    }
    if ([_ALbl.text isEqualToString:@"点击选择品名"]) {
        return 0;
    }
    if ([_BLbl.text isEqualToString:@"点击选择区域"]) {
        return 0;
    }
    if ([_CLbl.text isEqualToString:@"点击选择单位"]) {
        return 0;
    }
    if (_brandId.length<1) {
        return 0;
    }
    if (_typeId.length<1) {
        return 0;
    }
    if (_typeName.length<1) {
        return 0;
    }
    if (_areaId.length<1) {
        return 0;
    }
        return 1;
}

-(NSMutableDictionary*)makePriceUploadData{
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    //[params setValue:@"priceadd" forKey:@"ut"];
    
    if (_showType==1) {
        [params setValue:@"modifyprice" forKey:@"ut"];
        [params setValue:_detailId forKey:@"priceId"];
    }
    else
        [params setValue:@"priceadd" forKey:@"ut"];

    
    [params setValue:_ATxtF.text forKey:@"origin"];
    [params setValue:_brandId forKey:@"brandId"];
    [params setValue:_ALbl.text forKey:@"brandName"];
    [params setValue:_typeId forKey:@"typeId"];
    [params setValue:_typeName forKey:@"typeName"];
    [params setValue:_areaId forKey:@"areaId"];
    [params setValue:_BLbl.text forKey:@"areaName"];
    [params setValue:_BTxtF.text forKey:@"price"];
    [params setValue:_CLbl.text forKey:@"unit"];
    [params setValue:_detailTxt.text forKey:@"priceDesc"];
    
    return params;
}

-(void)clickUpbtn{
    if (0==[self checkInfoComplet]) {
        [stdPubFunc stdShowMessage:@"信息不完整，请完善后上传"];
    }
    else
    [self CreateRequest];
}
#pragma mark StdUploadFileApi delegate
-(void)stdUploadProgress:(float)progress{
    [_progressView setProgress:progress];
    if (progress>0.99) {
        UIView *view = (UIView*)[self.view viewWithTag:108];
        [view removeFromSuperview];
    }
    
    NSLog(@"上传进度：%f",progress);
}
-(void)stdUploadError:(NSError *)err
{
    //NSLog(@"%@",err);
}

-(void)stdUploadSucc:(NSURLResponse *)Response responseObject:(id)respObject{
    // NSLog(@"%@----%@",Response,respObject);
}
//单位选择
-(void)unitListSelect{
    PopMsgUnitViewController *timeView=[[PopMsgUnitViewController alloc]init];
    timeView.hidesBottomBarWhenPushed=YES;
    timeView.navigationItem.hidesBackButton=YES;
    //[timeView setCityType:_VersionType];
    timeView.TimeChangeBlock = ^(PopMsgUnitViewController *aqrvc,NSString *qrString){
        [aqrvc dismissViewControllerAnimated:NO completion:nil];
        [_CLbl setText:qrString];
    };
    timeView.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:timeView animated:YES];
}

-(NSString*)getMyCityCode:(NSString *)cityName
{
    NSString *file;
    
    file = [[NSBundle mainBundle]pathForResource:@"msgCities.plist" ofType:nil];
    
    
    //加载plist为数组
    NSArray *plistArray = [NSArray arrayWithContentsOfFile:file];
    NSDictionary *citydict=[[NSDictionary alloc]init];
    NSString *city_code=nil;
    for (NSDictionary *dict in plistArray)
    {
        citydict=[dict objectForKey:@"citycode"];
        
        city_code=[citydict objectForKey:cityName];
        if (city_code.length>0) {
            return city_code;
        }
    }
    
    return @"0";
}
#pragma mark - 区域选择完毕后返回
- (void)createPopver:(NSInteger)clickIndex{
    //    PopViewController *pvc = [[PopViewController alloc]init];
    //    [self.navigationController pushViewController:pvc animated:YES];
    
    PusMsgPopViewController *pvc = [[PusMsgPopViewController alloc]init];
    pvc.hidesBottomBarWhenPushed=YES;
    pvc.navigationItem.hidesBackButton=YES;
    [pvc setDataType:clickIndex];//0区域列表
    pvc.TypeChangeBlock = ^(PusMsgPopViewController *aqrvc,NSString *qrString,NSString *idString,NSInteger qtType,NSString*myTypeName,NSString* myTypeId){
        [aqrvc dismissViewControllerAnimated:NO completion:nil];
        if (clickIndex==0) {
            [_BLbl setText:qrString];
            _areaId=[self getMyCityCode:qrString];
            NSLog(@"%@",idString);
        }
        else
        {
        [_ALbl setText:qrString];
            _brandId=idString;
            _typeName=myTypeName;
            _typeId=myTypeId;
            NSLog(@"%@",idString);
        }
    };
    pvc.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:pvc animated:YES];
}

//下载分类数据
- (void)typeCreateRequest{
    DPAPI *api = [[DPAPI alloc]init];
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setValue:@"typeandbrand" forKey:@"ut"];
    
    [api setAllwaysFlash:@"1"];
    
    [api typeRequestWithURL: NetUrl params:params delegate:self];
}

-(void)typerequest:(DPRequest *)request didFinishLoadingWithResult:(id)result
{
    NSDictionary *dict = result;
    
    [self saveTypeInfo:dict];
    [self createPopver:1];
    
}

-(NSDictionary*)readTypeInfo{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSDictionary * NSUserDefaults = [user objectForKey:NSUserTypeData];
    return NSUserDefaults;
}

-(void)saveTypeInfo:(NSDictionary*)myData{
    
    if(![[myData objectForKey:@"data"] isEqual:[NSNull null]])
    {
        NSDictionary *dataTmp=[myData objectForKey:@"data"];
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        [user setObject:dataTmp forKey:NSUserTypeData];
        [user synchronize];
    }
}



-(void)clickAreabtn{
    [self createPopver:0];
}

-(void)clickTypebtn{
    DPAPI *api = [[DPAPI alloc]init];
    if ([api GetNetState]==0) {
        [self createPopver:1];//无网络，直接读取缓存
    }
    else
        [self typeCreateRequest];
}
-(void)clickUnitbtn{
    [self unitListSelect];
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
    typelbl.text=@"原产地:";
    [typelbl setFont:[UIFont systemFontOfSize:Fontsize]];
    [MainView addSubview:typelbl];
    
    _ATxtF = [[UITextField alloc] initWithFrame:CGRectMake(txtFLeftX, topY, txtFWidth, txtFHeigh)];
    [self stdInitTxtF:_ATxtF hintxt:@""];
    [MainView addSubview:_ATxtF];
    
    UILabel *Albl=[[UILabel alloc]initWithFrame:CGRectMake(10, topY+40, lblWidth, txtFHeigh)];
    Albl.text=@"品名:";
    [Albl setFont:[UIFont systemFontOfSize:Fontsize]];
    [MainView addSubview:Albl];
    
    _ALbl=[[UILabel alloc]initWithFrame:CGRectMake(txtFLeftX, topY+40, lblWidth+30, txtFHeigh)];
    _ALbl.text=@"点击选择品名";
    [_ALbl setFont:[UIFont systemFontOfSize:Fontsize]];
    [MainView addSubview:_ALbl];
    
    UIButton *ABtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [ABtn setFrame:CGRectMake(70, topY+40, 120, txtFHeigh)];
    [ABtn addTarget:self action:@selector(clickTypebtn) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:ABtn];
    
    
    UILabel *Blbl=[[UILabel alloc]initWithFrame:CGRectMake(10, topY+80, lblWidth, txtFHeigh)];
    Blbl.text=@"所属区域:";
    [Blbl setFont:[UIFont systemFontOfSize:Fontsize]];
    [MainView addSubview:Blbl];
    
    _BLbl=[[UILabel alloc]initWithFrame:CGRectMake(txtFLeftX, topY+80, lblWidth+30, txtFHeigh)];
    _BLbl.text=@"点击选择区域";
    [_BLbl setFont:[UIFont systemFontOfSize:Fontsize]];
    [MainView addSubview:_BLbl];
    
    UIButton *CBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [CBtn setFrame:CGRectMake(70, topY+80, 120, txtFHeigh)];
    [CBtn addTarget:self action:@selector(clickAreabtn) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:CBtn];
    
    
    UILabel *Dlbl=[[UILabel alloc]initWithFrame:CGRectMake(10, topY+120, lblWidth, txtFHeigh)];
    Dlbl.text=@"价格:";
    [Dlbl setFont:[UIFont systemFontOfSize:Fontsize]];
    [MainView addSubview:Dlbl];
    _BTxtF = [[UITextField alloc] initWithFrame:CGRectMake(txtFLeftX, topY+120, txtFWidth, txtFHeigh)];
    
    _BTxtF.keyboardType=UIKeyboardTypeNumbersAndPunctuation;
    [self stdInitTxtF:_BTxtF hintxt:@"价格：如 23.50"];
    [MainView addSubview:_BTxtF];
    
    
    UILabel *ulbl=[[UILabel alloc]initWithFrame:CGRectMake(txtFLeftX+txtFWidth+5, topY+120, 20, txtFHeigh)];
    ulbl.text=@"元";
    [ulbl setFont:[UIFont systemFontOfSize:Fontsize]];
    [MainView addSubview:ulbl];
    
    
    UILabel *Elbl=[[UILabel alloc]initWithFrame:CGRectMake(10, topY+160, lblWidth, txtFHeigh)];
    Elbl.text=@"单位:";
    [Elbl setFont:[UIFont systemFontOfSize:Fontsize]];
    [MainView addSubview:Elbl];
    
    _CLbl=[[UILabel alloc]initWithFrame:CGRectMake(txtFLeftX, topY+160, lblWidth+30, txtFHeigh)];
    _CLbl.text=@"点击选择单位";
    [_CLbl setFont:[UIFont systemFontOfSize:Fontsize]];
    [MainView addSubview:_CLbl];
    UIButton *DBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [DBtn setFrame:CGRectMake(70, topY+160, 120, txtFHeigh)];
    [DBtn addTarget:self action:@selector(clickUnitbtn) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:DBtn];
    
    
    //上传缩略图
//    UILabel *addPiclbl=[[UILabel alloc]initWithFrame:CGRectMake(10, topY+340, 80, txtFHeigh)];
//    addPiclbl.text=@"添加照片";
//    [addPiclbl setFont:[UIFont systemFontOfSize:Fontsize]];
//    [MainView addSubview:addPiclbl];
//    
//    UIImageView *addimag=[[UIImageView alloc]initWithFrame:CGRectMake(70, topY+345, 20, 20)];
//    addimag.image=[UIImage imageNamed:@"plus"];
//    [MainView addSubview:addimag];
    
    
//    _imageView=[[UIImageView alloc]initWithFrame:CGRectMake(txtFLeftX, topY+480, 120, 120)];
//    [MainView addSubview:_imageView];
    
    UIButton *upLoadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [upLoadBtn setFrame:CGRectMake(0, topY+340, fDeviceWidth-100, 40)];
    [upLoadBtn addTarget:self action:@selector(clickAddbtn) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:upLoadBtn];
    
    UILabel *detaillbl=[[UILabel alloc]initWithFrame:CGRectMake(10, topY+200, 80, txtFHeigh)];
    detaillbl.text=@"详细介绍:";
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
    ScrollHeigh=topY+480;
    [MainView setContentSize:CGSizeMake(fDeviceWidth, ScrollHeigh)];
    [self.view addSubview:MainView];
}

#pragma mark - actionsheet delegate
-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 255) {
        
        NSUInteger sourceType = 0;
        
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            switch (buttonIndex) {
                case 0:
                    // 取消
                    return;
                case 1:
                    // 相机
                    
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                    
                case 2:
                    // 相册
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
            }
        }
        else {
            if (buttonIndex == 0) {
                
                return;
            } else {
                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            }
        }
        // 跳转到相机或相册页面
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        
        imagePickerController.delegate = self;
        
        imagePickerController.allowsEditing = YES;
        
        imagePickerController.sourceType = sourceType;
        
        [self presentViewController:imagePickerController animated:YES completion:^{}];
        
    }
}

//从相册中选取图片或拍照
- (void)btnActionForEditPortrait:(id) sender {
    UIActionSheet *sheet;
    
    // 判断是否支持相机
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        sheet  = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"拍照",@"从相册选择", nil];
    }
    else {
        
        sheet = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"从相册选择", nil];
    }
    
    sheet.tag = 255;
    
    [sheet showInView:self.view];
}

#pragma mark - 保存图片至沙盒
- (void) saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.5);
    // 获取沙盒目录
    
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    
    // 将图片写入文件
    imgFullpath=fullPath;
    NSLog(@"fullPath:%@",fullPath);
    [imageData writeToFile:fullPath atomically:NO];
}

#pragma mark - image picker delegte
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    [self saveImage:image withName:@"currentImage.png"];
    
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentImage.png"];
    
    UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
    
    isFullScreen = NO;
    [self.imageView setImage:savedImage];
    
    self.imageView.tag = 100;
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:^{}];
}
-(void)clickAddbtn{
    NSLog(@"添加照片");
    [self btnActionForEditPortrait:nil];
}

-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [_ATxtF resignFirstResponder];
    [_BTxtF resignFirstResponder];
//    [_CTxtF resignFirstResponder];
//    [_DTxtF resignFirstResponder];
//    [_ETxtF resignFirstResponder];
//    [_FTxtF resignFirstResponder];
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
//    if ([_CTxtF isFirstResponder]) {
//        [_CTxtF resignFirstResponder];
//    }
//    if ([_DTxtF isFirstResponder]) {
//        [_DTxtF resignFirstResponder];
//    }
//    if ([_ETxtF isFirstResponder]) {
//        [_ETxtF resignFirstResponder];
//    }
//    if ([_FTxtF isFirstResponder]) {
//        [_FTxtF resignFirstResponder];
//    }
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

-(void)setShowType:(NSInteger)showType{
    _showType=showType;
}

-(void)setDetailId:(NSString *)detailId{
    _detailId=detailId;
}

-(void)DetailNetRequest:(NSString*)detailId{
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setValue:@"pricedetail" forKey:@"ut"];
    [params setValue:detailId forKey:@"id"];
    DPAPI *api = [[DPAPI alloc]init];
    
    [api loginRequestWithURL:NetUrl params:params delegate:self];
    
}

-(void)loginrequest:(DPRequest *)request didFinishLoadingWithResult:(id)result{
    PricePlaceModel *dm=[[PricePlaceModel alloc]init];
    NSDictionary *dict = result;
    NSArray *datatmp;
    datatmp=[dm asignDetailModelWithDict:dict];
    [self initContent:datatmp];
    //NSLog(@"%@",result);
}

-(void)initContent:(NSArray *)contentArr{
    PricePlaceModel *mydm=[[PricePlaceModel alloc]init];
    if (contentArr.count>0) {
        _upLoad.text=@"修改";
        mydm=contentArr[0];
        
        _typeId=mydm.brandId;
        _areaId=mydm.areaId;
        _brandId=mydm.brandId;
        _typeName=mydm.typeName;
        
        
        
        _ATxtF.text=mydm.origin;
        _BTxtF.text=mydm.pricenum;
        
        
        _ALbl.text=mydm.brandName;
        _BLbl.text=mydm.mareaName;
        _CLbl.text=mydm.unit;
        _detailTxt.text=mydm.empDesc;
        
        
    }
    
}


@end
