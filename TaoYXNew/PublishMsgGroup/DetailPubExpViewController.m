//
//  DetailPubExpViewController.m
//  TaoYXNew
//
//  Created by tianan-apple on 16/1/8.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "DetailPubExpViewController.h"
#import "PublicDefine.h"
#import "QuartzCore/QuartzCore.h"
#import "StdUploadFileApi.h"
#import "PopViewController.h"
#import "LoginViewController.h"
#import "RadioButton.h"
#import "HZAreaPickerView.h"
#import "DPAPI.h"
#import "stdPubFunc.h"
#import "CarExpressDeal.h"

@interface DetailPubExpViewController ()<UITextFieldDelegate,UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,uploadProgressDelegate,NSURLConnectionDelegate,UIWebViewDelegate,RadioButtonDelegate,HZAreaPickerDelegate, HZAreaPickerDatasource,DPRequestDelegate>
{
    BOOL isFullScreen;
    NSString *imgFullpath;
    NSURLConnection *_goodsconnection;
    NSMutableData   *_goodsresponseData;
    NSInteger AreaFlag;//0出发地 1目的地
    NSString *startProvince;
    NSString *startCity;
    NSString *startCounty;
    NSString *endProvince;
    NSString *endCity;
    NSString *endCounty;
    NSString *sendTime;
    NSString *expType;//1车源，0货源
}

@end

@implementation DetailPubExpViewController
@synthesize locatePicker=_locatePicker;
@synthesize areaValue=_areaValue, cityValue=_cityValue;
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
    viewTitle.text=@"发布物流信息";
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
    //back.backgroundColor=[UIColor yellowColor];
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
//   NSString*ss=@"http://192.168.0.38:8080/nct/common.htm?ut=logintest&loginname=shitiedong";
//    [self loadWebView:ss];
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
-(void)clickUpbtn{
//    NSString*ss=@"http://192.168.0.38:8080/nct/common.htm?ut=islogin";
//    [self stdPostInfo:ss];
    
    
//    NSString *Path = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentImage.png"];
//    NSLog(@"Path:%@",Path);
//    StdUploadFileApi *upRequst=[[StdUploadFileApi alloc]init];
//    upRequst.delegate=self;
//    [upRequst stdUploadFileWithProgress:@"http://www.baidu.com/" filePath:Path fileName:@"currentImage.png" mimeType:@"image/jpeg"];
//    [self loadProgress];
    if (0==[self checkInfoComplet]) {
        [stdPubFunc stdShowMessage:@"信息不完整，请完善后上传"];
    }
    else
    [self createRequest];
    
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

#pragma mark - 区域选择完毕后返回
- (void)createPopver:(NSInteger)clickIndex{
    //    PopViewController *pvc = [[PopViewController alloc]init];
    //    [self.navigationController pushViewController:pvc animated:YES];
    
    PopViewController *pvc = [[PopViewController alloc]init];
    pvc.hidesBottomBarWhenPushed=YES;
    pvc.navigationItem.hidesBackButton=YES;
    [pvc setDataType:clickIndex];//0区域列表
    pvc.TypeChangeBlock = ^(PopViewController *aqrvc,NSString *qrString,NSString *idString,NSInteger qtType){
        [aqrvc dismissViewControllerAnimated:NO completion:nil];
        [_areaLbl setText:qrString];
    };
    pvc.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:pvc animated:YES];
}

-(void)clickAreabtn{
    [self createPopver:0];
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
//myType=0 车源
-(void)setExpState:(NSInteger)myType{
    if (0==myType) {
        _ELbl.text=@"发车日期:";
        _FLbl.text=@"车牌号:";
        _GLbl.text=@"车类型:";
        _HLbl.text=@"车载重:";
        _ILbl.text=@"车长:";
        expType=@"1";
    }
    else{
        _ELbl.text=@"发货日期:";
        _FLbl.text=@"货品名:";
        _GLbl.text=@"货类型:";
        _HLbl.text=@"货重量:";
        _ILbl.text=@"货体积:";
        expType=@"0";
    }
}
-(void)radioButtonSelectedAtIndex:(NSUInteger)index inGroup:(NSString *)groupId{
    [self setExpState:index];
}

-(void)clickTimebtn{
    UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(-25, 0, 320, 216)];
    datePicker.datePickerMode =UIDatePickerModeDateAndTime;
    //UIDatePickerModeDate;
    NSLocale *locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    datePicker.locale = locale;
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"\n\n\n\n\n\n\n\n\n\n\n\n" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alert.view addSubview:datePicker];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
        
        //实例化一个NSDateFormatter对象
        
        [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];//设定时间格式
        
        NSString *dateString = [dateFormat stringFromDate:datePicker.date];
        
        //求出当天的时间字符串
        _KLbl.text=dateString;
        sendTime=dateString;
        //NSLog(@"%@",dateString);
        
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        　 }];
    
    [alert addAction:ok];
    
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:^{ }];
}



#pragma mark - HZAreaPicker delegate
-(void)pickerDidChaneStatus:(HZAreaPickerView *)picker
{
    if (picker.pickerStyle == HZAreaPickerWithStateAndCityAndDistrict) {
        self.areaValue = [NSString stringWithFormat:@"%@ %@ %@", picker.locate.state, picker.locate.city, picker.locate.district];
        
    } else{
        self.cityValue = [NSString stringWithFormat:@"%@ %@", picker.locate.state, picker.locate.city];
    }
    if (self.areaValue.length>0) {
        if (AreaFlag==0) {
            _LLbl.text=self.areaValue;
            startProvince=picker.locate.state;
            startCity=picker.locate.city;
            startCounty=picker.locate.district;
        }
        else{
            _NLbl.text=self.areaValue;
            endProvince=picker.locate.state;
            endCity=picker.locate.city;
            endCounty=picker.locate.district;
        }
    }
}

-(NSArray *)areaPickerData:(HZAreaPickerView *)picker
{
    NSArray *data;
    if (picker.pickerStyle == HZAreaPickerWithStateAndCityAndDistrict) {
        data = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"AreaList.plist" ofType:nil]] ;
    } else{
        data = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"city.plist" ofType:nil]];
    }
    return data;
}



-(void)cancelLocatePicker
{
    [self.locatePicker cancelPicker];
    self.locatePicker.delegate = nil;
    self.locatePicker = nil;
}

-(void)clickStartbtn{
    AreaFlag=0;
    self.locatePicker = [[HZAreaPickerView alloc] initWithStyle:HZAreaPickerWithStateAndCityAndDistrict
                                                    withDelegate:self
                                                   andDatasource:self];
    [self.locatePicker showInView:_MainView];
}
-(void)clickeEndbtn{
    AreaFlag=1;
    self.locatePicker = [[HZAreaPickerView alloc] initWithStyle:HZAreaPickerWithStateAndCityAndDistrict
                                                   withDelegate:self
                                                  andDatasource:self];
    [self.locatePicker showInView:_MainView];
}
-(void)loadContentView{
    _MainView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, TopSeachHigh, fDeviceWidth, fDeviceHeight-TopSeachHigh)];
    
    UILabel *infotype=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 70, 30)];
    infotype.text=@"信息类型:";
    [infotype setFont:[UIFont systemFontOfSize:13]];
    [_MainView addSubview:infotype];
    
    UILabel *carlbl=[[UILabel alloc]initWithFrame:CGRectMake(100, 10, 40, 30)];
    carlbl.text=@"车源";
    [carlbl setFont:[UIFont systemFontOfSize:13]];
    [_MainView addSubview:carlbl];
    
    UILabel *goodslbl=[[UILabel alloc]initWithFrame:CGRectMake(180, 10, 40, 30)];
    goodslbl.text=@"货源";
    [goodslbl setFont:[UIFont systemFontOfSize:13]];
    [_MainView addSubview:goodslbl];
    
    _rb1 = [[RadioButton alloc] initWithGroupId:@"first group" index:0];
    _rb2 = [[RadioButton alloc] initWithGroupId:@"first group" index:1];
    _rb1.frame = CGRectMake(80,14,22,22);
    _rb2.frame = CGRectMake(160,14,22,22);
    [_rb1 setBtnState:YES];
    expType=@"1";
    [_MainView addSubview:_rb1];
    [_MainView addSubview:_rb2];
    [RadioButton addObserverForGroupId:@"first group" observer:self];
    
    float topY=60;
    float ScrollHeigh=0;
    float txtFWidth=fDeviceWidth-120;
    float txtFLeftX=90;
    float txtFHeigh=30;
    float lblWidth=70;
    CGFloat Fontsize=13;
    
    
    
    _ALbl=[[UILabel alloc]initWithFrame:CGRectMake(10, topY, 70, txtFHeigh)];
    _ALbl.text=@"联系人:";
    [_ALbl setFont:[UIFont systemFontOfSize:Fontsize]];
    [_MainView addSubview:_ALbl];
    _ATxtF = [[UITextField alloc] initWithFrame:CGRectMake(txtFLeftX, topY, txtFWidth, txtFHeigh)];
    [self stdInitTxtF:_ATxtF hintxt:@""];
    [_MainView addSubview:_ATxtF];
    
    _BLbl=[[UILabel alloc]initWithFrame:CGRectMake(10, topY+40, lblWidth, txtFHeigh)];
    _BLbl.text=@"手机:";
    [_BLbl setFont:[UIFont systemFontOfSize:Fontsize]];
    [_MainView addSubview:_BLbl];
    _BTxtF = [[UITextField alloc] initWithFrame:CGRectMake(txtFLeftX, topY+40, txtFWidth, txtFHeigh)];
    _BTxtF.keyboardType=UIKeyboardTypeNumbersAndPunctuation;
    [self stdInitTxtF:_BTxtF hintxt:@""];
    [_MainView addSubview:_BTxtF];
    
    _CLbl=[[UILabel alloc]initWithFrame:CGRectMake(10, topY+80, lblWidth, txtFHeigh)];
    _CLbl.text=@"出发地:";
    [_CLbl setFont:[UIFont systemFontOfSize:Fontsize]];
    [_MainView addSubview:_CLbl];
    
    _LLbl=[[UILabel alloc]initWithFrame:CGRectMake(txtFLeftX, topY+80, fDeviceWidth-txtFLeftX-20, txtFHeigh)];
    _LLbl.text=@"点击选择地区";
    [_LLbl setFont:[UIFont systemFontOfSize:Fontsize]];
    [_MainView addSubview:_LLbl];
    
    UIButton *ABtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [ABtn setFrame:CGRectMake(txtFLeftX, topY+80, lblWidth+100, txtFHeigh)];
    [ABtn addTarget:self action:@selector(clickStartbtn) forControlEvents:UIControlEventTouchUpInside];
    [_MainView addSubview:ABtn];
    
    
    _DLbl=[[UILabel alloc]initWithFrame:CGRectMake(10, topY+120, lblWidth, txtFHeigh)];
    _DLbl.text=@"到达地:";
    [_DLbl setFont:[UIFont systemFontOfSize:Fontsize]];
    [_MainView addSubview:_DLbl];
    _NLbl=[[UILabel alloc]initWithFrame:CGRectMake(txtFLeftX, topY+120, fDeviceWidth-txtFLeftX-20, txtFHeigh)];
    _NLbl.text=@"点击选择地区";
    [_NLbl setFont:[UIFont systemFontOfSize:Fontsize]];
    [_MainView addSubview:_NLbl];
    
    UIButton *DBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [DBtn setFrame:CGRectMake(txtFLeftX, topY+120, lblWidth+100, txtFHeigh)];
    [DBtn addTarget:self action:@selector(clickeEndbtn) forControlEvents:UIControlEventTouchUpInside];
    [_MainView addSubview:DBtn];
    
    

    _ELbl=[[UILabel alloc]initWithFrame:CGRectMake(10, topY+160, lblWidth, txtFHeigh)];
    _ELbl.text=@"发车日期:";
    [_ELbl setFont:[UIFont systemFontOfSize:Fontsize]];
    [_MainView addSubview:_ELbl];
    
    _KLbl=[[UILabel alloc]initWithFrame:CGRectMake(txtFLeftX, topY+160, lblWidth+80, txtFHeigh)];
    _KLbl.text=@"点击选择日期";
    [_KLbl setFont:[UIFont systemFontOfSize:Fontsize]];
    [_MainView addSubview:_KLbl];
    
    UIButton *CBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [CBtn setFrame:CGRectMake(txtFLeftX, topY+160, lblWidth+100, txtFHeigh)];
    [CBtn addTarget:self action:@selector(clickTimebtn) forControlEvents:UIControlEventTouchUpInside];
    [_MainView addSubview:CBtn];
    
//    _datePick=[[UIDatePicker alloc]initWithFrame:CGRectMake(txtFLeftX, topY+160, 500, 300)];
//    _datePick.datePickerMode=UIDatePickerModeDateAndTime;
//    [MainView addSubview:_datePick];
    
    _FLbl=[[UILabel alloc]initWithFrame:CGRectMake(10, topY+200, lblWidth, txtFHeigh)];
    _FLbl.text=@"车牌号:";
    [_FLbl setFont:[UIFont systemFontOfSize:Fontsize]];
    [_MainView addSubview:_FLbl];
    
    _CTxtF = [[UITextField alloc] initWithFrame:CGRectMake(txtFLeftX, topY+200, txtFWidth, txtFHeigh)];
    [self stdInitTxtF:_CTxtF hintxt:@""];
    [_MainView addSubview:_CTxtF];
    
    _GLbl=[[UILabel alloc]initWithFrame:CGRectMake(10, topY+240, lblWidth, txtFHeigh)];
    _GLbl.text=@"车类型:";
    [_GLbl setFont:[UIFont systemFontOfSize:Fontsize]];
    [_MainView addSubview:_GLbl];
    
    _DTxtF = [[UITextField alloc] initWithFrame:CGRectMake(txtFLeftX, topY+240, txtFWidth, txtFHeigh)];
    [self stdInitTxtF:_DTxtF hintxt:@""];
    [_MainView addSubview:_DTxtF];
    
    _HLbl=[[UILabel alloc]initWithFrame:CGRectMake(10, topY+280, lblWidth, txtFHeigh)];
    _HLbl.text=@"车载重:";
    [_HLbl setFont:[UIFont systemFontOfSize:Fontsize]];
    [_MainView addSubview:_HLbl];
    _ETxtF = [[UITextField alloc] initWithFrame:CGRectMake(txtFLeftX, topY+280, txtFWidth, txtFHeigh)];
    _ETxtF.keyboardType=UIKeyboardTypeNumbersAndPunctuation;
    [self stdInitTxtF:_ETxtF hintxt:@"单位：吨"];
    [_MainView addSubview:_ETxtF];
    
    
    _ILbl=[[UILabel alloc]initWithFrame:CGRectMake(10, topY+320, lblWidth, txtFHeigh)];
    _ILbl.text=@"车长:";
    [_ILbl setFont:[UIFont systemFontOfSize:Fontsize]];
    [_MainView addSubview:_ILbl];
    _FTxtF = [[UITextField alloc] initWithFrame:CGRectMake(txtFLeftX, topY+320, txtFWidth, txtFHeigh)];
    _FTxtF.keyboardType=UIKeyboardTypeNumbersAndPunctuation;
    [self stdInitTxtF:_FTxtF hintxt:@"单位：米"];
    [_MainView addSubview:_FTxtF];
    
    _JLbl=[[UILabel alloc]initWithFrame:CGRectMake(10, topY+360, 80, txtFHeigh)];
    _JLbl.text=@"备注:";
    [_JLbl setFont:[UIFont systemFontOfSize:Fontsize]];
    [_MainView addSubview:_JLbl];
    _detailTxt = [[UITextView alloc] initWithFrame:CGRectMake(txtFLeftX, topY+380, txtFWidth, 120)];
    _detailTxt.backgroundColor = [UIColor clearColor];
    [_detailTxt setTintColor:[UIColor blueColor]];
    _detailTxt.textAlignment = UITextAutocorrectionTypeDefault;//UITextAlignmentCenter;
    _detailTxt.textColor=tabTxtColor;
    _detailTxt.layer.borderColor = [UIColor lightGrayColor].CGColor; // set color as you want.
    _detailTxt.layer.borderWidth = 1.0f; // set borderWidth as you want.
    _detailTxt.delegate=self;
    [_MainView addSubview:_detailTxt];
    ScrollHeigh=topY+540;
    [_MainView setContentSize:CGSizeMake(fDeviceWidth, ScrollHeigh)];
    [self.view addSubview:_MainView];
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
    [_CTxtF resignFirstResponder];
    [_DTxtF resignFirstResponder];
    [_ETxtF resignFirstResponder];
    [_FTxtF resignFirstResponder];
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
    if ([_FTxtF isFirstResponder]) {
        [_FTxtF resignFirstResponder];
    }
    if ([_detailTxt isFirstResponder]) {
        [_detailTxt resignFirstResponder];
    }
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
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



-(void)stdPostInfo:(NSString*)urlStr{
    // NSURLConnection *stdConnection;
    LoginViewController *lv=[[LoginViewController alloc]init];
    ;
   // NSString *infoUrl=@"";
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
   // [request setValue:[lv readSession] forKey:@"JSESSIONID"];
    _goodsconnection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
}

-(void)loadWebView:(NSString*)urlStr{
    UIWebView *DescView=[[UIWebView alloc]initWithFrame:CGRectMake(0, TopSeachHigh+120, fDeviceWidth, fDeviceHeight-TopSeachHigh-120)];
    [DescView setDelegate:self];
     NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    [DescView loadRequest:request];
    [self.view addSubview: DescView];
    
}
#pragma mark - NSURLConnection Delegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    _goodsresponseData = [[NSMutableData alloc] init];
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_goodsresponseData appendData:data];
    NSLog(@"%@",_goodsresponseData);
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse
{
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)theConnection
{
    _goodsresponseData = nil;
    [_goodsconnection cancel];
    _goodsconnection = nil;
    NSLog(@"加入购物车成功");
   
}

- (void)connection:(NSURLConnection *)theConnection didFailWithError:(NSError *)error
{
    _goodsresponseData = nil;
    [_goodsconnection cancel];
    _goodsconnection = nil;
}


-(NSInteger)checkInfoComplet{

    if (expType.length<1) {
        return 0;
    }
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
    if (_FTxtF.text.length<1) {
        return 0;
    }
    if ([_LLbl.text isEqualToString:@"点击选择地区"]) {
        return 0;
    }
    if ([_NLbl.text isEqualToString:@"点击选择地区"]) {
        return 0;
    }
    if ([_KLbl.text isEqualToString:@"点击选择日期"]) {
        return 0;
    }
    return 1;
}


-(NSMutableDictionary*)makeCarUploadData{
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    if (_showType==1) {
        [params setValue:@"modifyloginfo" forKey:@"ut"];
        [params setValue:_detailId forKey:@"logInfoId"];
    }
    else
        [params setValue:@"sendloginfo" forKey:@"ut"];
    [params setValue:expType forKey:@"logInfoType"];
    [params setValue:_ATxtF.text forKey:@"customerName"];
    [params setValue:_BTxtF.text forKey:@"telphone"];
    [params setValue:_CTxtF.text forKey:@"carCode"];
    [params setValue:_DTxtF.text forKey:@"vehicleType"];
    [params setValue:_ETxtF.text forKey:@"vehicleLoad"];
    [params setValue:_FTxtF.text forKey:@"vehicleLength"];
    [params setValue:_detailTxt.text forKey:@"logInfoDesc"];
    
    [params setValue:startProvince forKey:@"startProvince"];
    [params setValue:startCity forKey:@"startCity"];
    [params setValue:startCounty forKey:@"startCounty"];
    
    [params setValue:endProvince forKey:@"endProvicen"];
    [params setValue:endCity forKey:@"endCity"];
    [params setValue:endCounty forKey:@"endCounty"];
    
    [params setValue:sendTime forKey:@"sTime"];
    
    return params;
}


-(NSMutableDictionary*)makeGoodsUploadData{
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    if (_showType==1) {
        [params setValue:@"modifyloginfo" forKey:@"ut"];
        [params setValue:_detailId forKey:@"logInfoId"];
    }
    else
     [params setValue:@"sendloginfo" forKey:@"ut"];
    [params setValue:expType forKey:@"logInfoType"];
    [params setValue:_ATxtF.text forKey:@"customerName"];
    [params setValue:_BTxtF.text forKey:@"telphone"];
    [params setValue:_CTxtF.text forKey:@"goodsName"];
    [params setValue:_DTxtF.text forKey:@"goodsType"];
    [params setValue:_ETxtF.text forKey:@"goodsWeight"];
    [params setValue:_FTxtF.text forKey:@"goodsVolume"];
    [params setValue:_detailTxt.text forKey:@"logInfoDesc"];
    
    [params setValue:startProvince forKey:@"startProvince"];
    [params setValue:startCity forKey:@"startCity"];
    [params setValue:startCounty forKey:@"startCounty"];
    
    [params setValue:endProvince forKey:@"endProvicen"];
    [params setValue:endCity forKey:@"endCity"];
    [params setValue:endCounty forKey:@"endCounty"];
    
    [params setValue:sendTime forKey:@"sTime"];
    
    return params;
}

# pragma 网络请求
- (void)createRequest{
    DPAPI *api = [[DPAPI alloc]init];
    [api setAllwaysFlash:@"1"];
    if ([expType isEqualToString:@"1"]) {//车源
        [api postRequestWithURL: NetUrl params:[self makeCarUploadData] delegate:self];
    }
    else
        [api postRequestWithURL: NetUrl params:[self makeGoodsUploadData] delegate:self];
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

-(void)setShowType:(NSInteger)showType{
    _showType=showType;
}

-(void)setDetailId:(NSString *)detailId{
    _detailId=detailId;
}
-(void)DetailNetRequest:(NSString*)detailId{
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setValue:@"loginfodetail" forKey:@"ut"];
    [params setValue:detailId forKey:@"id"];
    DPAPI *api = [[DPAPI alloc]init];
    
    [api loginRequestWithURL:NetUrl params:params delegate:self];

}

-(void)loginrequest:(DPRequest *)request didFinishLoadingWithResult:(id)result{
    CarExpressDeal *dm=[[CarExpressDeal alloc]init];
    NSDictionary *dict = result;
    NSArray *datatmp;
    datatmp=[dm asignDetailModelWithDict:dict];
    [self initContent:datatmp];
   // NSLog(@"%@",result);
}



-(void)initContent:(NSArray *)contentArr{
    CarExpressDeal *mydm=[[CarExpressDeal alloc]init];
    if (contentArr.count>0) {
         _upLoad.text=@"修改";
         mydm=contentArr[0];
        expType=mydm.logInfoType;
        if ([expType isEqualToString:@"1"]) {
            //[self setExpState:0];
            [_rb1 setBtnState:YES];
            _CTxtF.text=mydm.carCode;
            _DTxtF.text=mydm.vehicleType;
            _ETxtF.text=mydm.vehicleLoad;
            _FTxtF.text=mydm.vehicleLength;
        }
        else
        {
            //[self setExpState:1];
            [_rb2 setBtnState:YES];
            _CTxtF.text=mydm.goodsName;
            _DTxtF.text=mydm.goodsType;
            _ETxtF.text=mydm.goodsWeight;
            _FTxtF.text=mydm.goodsVolume;
        }
        _ATxtF.text=mydm.contact;
        _BTxtF.text=mydm.mobile;
       
        _detailTxt.text=mydm.infoDesc;
        sendTime=mydm.publicTime;
        _KLbl.text=sendTime;
        
        //出发地
        startProvince=mydm.startProvince;
        startCity=mydm.startCity;
        startCounty=mydm.startCounty;
        _LLbl.text=[NSString stringWithFormat:@"%@ %@ %@",startProvince,startCity,startCounty];
        
        //目的地
        endProvince=mydm.endProvicen;
        endCity=mydm.endCity;
        endCounty=mydm.endCounty;
        _NLbl.text=[NSString stringWithFormat:@"%@ %@ %@",endProvince,endCity,endCounty];

    }
   
}
@end
