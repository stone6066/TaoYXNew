//
//  DetailPubSupplyViewController.m
//  TaoYXNew
//
//  Created by tianan-apple on 16/1/8.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "DetailPubSupplyViewController.h"
#import "PublicDefine.h"
#import "QuartzCore/QuartzCore.h"
#import "StdUploadFileApi.h"
#import "PopViewController.h"
#import "RadioButton.h"
#import "DPAPI.h"
#import "PusMsgPopViewController.h"
#import "PopMsgUnitViewController.h"
#import "stdPubFunc.h"
#import "SupplyModel.h"
#import "UIImageView+WebCache.h"
#import "MyGrapedViewController.h"

@interface DetailPubSupplyViewController ()<UITextFieldDelegate,UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,uploadProgressDelegate,RadioButtonDelegate,DPRequestDelegate>
{
    BOOL isFullScreen;
    NSString *imgFullpath;
    //NSString *supplyType;//1车源，0货源
}
@end

@implementation DetailPubSupplyViewController

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
    viewTitle.text=@"发布供求信息";
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


-(void)clickUpbtn{
    if (0==[self checkInfoComplet]) {
        [stdPubFunc stdShowMessage:@"信息不完整，请完善后上传"];
    }
    else{
        NSString *Path = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentImage.png"];
        //NSLog(@"Path:%@",Path);
        StdUploadFileApi *upRequst=[[StdUploadFileApi alloc]init];
        upRequst.delegate=self;
        
        [self loadProgress];
        if (_imageView.image) {
        [upRequst stdUploadFileWithProgress:NetUrl filePath:Path fileName:@"currentImage.png" mimeType:@"image/jpeg" pragram:[self makeSupplyUploadData]];
        
        }
        else
        {
            [upRequst stdUploadFileWithProgress:NetUrl filePath:@"" fileName:@"currentImage.png" mimeType:@"image/jpeg" pragram:[self makeSupplyUploadData]];
        }
    }
}
#pragma mark StdUploadFileApi delegate
-(void)stdUploadProgress:(float)progress{
    [_progressView setProgress:progress];
    
}
-(void)stdUploadError:(NSError *)err
{
    UIView *view = (UIView*)[self.view viewWithTag:108];
    [view removeFromSuperview];
   [stdPubFunc stdShowMessage:@"上传错误"];
}

-(void)stdUploadSucc:(NSURLResponse *)Response responseObject:(id)respObject{
    NSDictionary *dict=respObject;
    NSString *rtStr=[dict objectForKey:@"msg"];
    UIView *view = (UIView*)[self.view viewWithTag:108];
    [view removeFromSuperview];

    if ([rtStr isEqualToString:@"ok"]) {
        [stdPubFunc stdShowMessage:@"上传成功"];
    }
    else
         [stdPubFunc stdShowMessage:@"上传失败"];
    
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
    PusMsgPopViewController *pvc = [[PusMsgPopViewController alloc]init];
    pvc.hidesBottomBarWhenPushed=YES;
    pvc.navigationItem.hidesBackButton=YES;
    [pvc setDataType:clickIndex];//0区域列表
    pvc.TypeChangeBlock = ^(PusMsgPopViewController *aqrvc,NSString *qrString,NSString *idString,NSInteger qtType,NSString*myTypeName,NSString* myTypeId){
        [aqrvc dismissViewControllerAnimated:NO completion:nil];
        if (clickIndex==0) {
            [_BLbl setText:qrString];
            _areaId=[self getMyCityCode:qrString];
            NSLog(@"区域id：%@",_areaId);
        }
        else
        {
            [_ALbl setText:qrString];
            _typeId=idString;
            NSLog(@"品名id：%@",idString);
        }
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

//0供应 1求购

-(void)setExpState:(NSInteger)myType{
    if (0==myType) {
        _supplyType=@"0";
    }
    else{
        _supplyType=@"1";
    }
}

-(void)radioButtonSelectedAtIndex:(NSUInteger)index inGroup:(NSString *)groupId{
    [self setExpState:index];
}


-(void)clickTypebtn{
    DPAPI *api = [[DPAPI alloc]init];
    if ([api GetNetState]==0) {
        [self createPopver:1];//无网络，直接读取缓存
    }
    else
        [self typeCreateRequest];
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

-(void)clickUnitbtn{
    [self unitListSelect];
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

-(void)clickTimebtn{
    UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(-25, 0, 320, 216)];
    datePicker.datePickerMode =UIDatePickerModeDate;
    //UIDatePickerModeDate;
    NSLocale *locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    datePicker.locale = locale;
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"\n\n\n\n\n\n\n\n\n\n\n\n" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alert.view addSubview:datePicker];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
        
        //实例化一个NSDateFormatter对象
        
        [dateFormat setDateFormat:@"yyyy-MM-dd"];//设定时间格式
        
        NSString *dateString = [dateFormat stringFromDate:datePicker.date];
        
        //求出当天的时间字符串
        _DLbl.text=dateString;
        //sendTime=dateString;
        //NSLog(@"%@",dateString);
        
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        　 }];
    
    [alert addAction:ok];
    
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:^{ }];
}


-(NSMutableDictionary*)makeSupplyUploadData{
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    if (_showType==1) {
        [params setValue:_detailId forKey:@"supplyId"];
    }
    [params setValue:@"saveSupply" forKey:@"ut"];
    //[params setValue:@"saveSupply" forKey:@"ut"];
    //[params setValue:_supplyType forKey:@"type"];
    
    [params setValue:_ATxtF.text forKey:@"title"];
    [params setValue:_typeId forKey:@"brandId"];
    [params setValue:_ALbl.text forKey:@"brandName"];
    [params setValue:_areaId forKey:@"areaId"];
    [params setValue:_BLbl.text forKey:@"areaName"];
    [params setValue:_BTxtF.text forKey:@"supplySpecName"];//单位规格
    
    [params setValue:_CTxtF.text forKey:@"supplyPrice"];
    [params setValue:_CLbl.text forKey:@"supplyUnit"];
    [params setValue:_DLbl.text forKey:@"validate"];
    [params setValue:_supplyType forKey:@"supplyType"];
    
    [params setValue:_DTxtF.text forKey:@"contact"];
    [params setValue:_ETxtF.text forKey:@"phone"];
    [params setValue:_detailTxt.text forKey:@"supplyDesc"];
    
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
   
   
    if (_areaId.length<1) {
        return 0;
    }
    if (_typeId.length<1) {
        return 0;
    }
    if (_supplyType.length<1) {
        return 0;
    }
    
    if (_ALbl.text.length<1) {
        return 0;
    }
    if (_BLbl.text.length<1) {
        return 0;
    }
    if (_CLbl.text.length<1) {
        return 0;
    }
    return 1;
}


-(void)loadContentView{
    UIScrollView *MainView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, TopSeachHigh, fDeviceWidth, fDeviceHeight-TopSeachHigh)];
    
    
    UILabel *infotype=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 70, 30)];
    infotype.text=@"供求类型:";
    [infotype setFont:[UIFont systemFontOfSize:13]];
    [MainView addSubview:infotype];
    
    UILabel *carlbl=[[UILabel alloc]initWithFrame:CGRectMake(105, 10, 40, 30)];
    carlbl.text=@"供应";
    [carlbl setFont:[UIFont systemFontOfSize:13]];
    [MainView addSubview:carlbl];
    
    UILabel *goodslbl=[[UILabel alloc]initWithFrame:CGRectMake(180, 10, 40, 30)];
    goodslbl.text=@"求购";
    [goodslbl setFont:[UIFont systemFontOfSize:13]];
    [MainView addSubview:goodslbl];
    
    _rb1 = [[RadioButton alloc] initWithGroupId:@"first group" index:0];
    _rb2 = [[RadioButton alloc] initWithGroupId:@"first group" index:1];
    _rb1.frame = CGRectMake(85,14,22,22);
    _rb2.frame = CGRectMake(160,14,22,22);
    [_rb1 setBtnState:YES];
    _supplyType=@"0";
    [MainView addSubview:_rb1];
    [MainView addSubview:_rb2];
    [RadioButton addObserverForGroupId:@"first group" observer:self];
    
    _detailLbl=[[UILabel alloc]initWithFrame:CGRectMake(fDeviceWidth-100, 10, 80, 30)];
    _detailLbl.hidden=YES;
    [MainView addSubview:_detailLbl];
    _detailBtn=[[UIButton alloc]initWithFrame:CGRectMake(fDeviceWidth-100, 10, 80, 30)];
    _detailBtn.hidden=YES;
    [_detailBtn addTarget:self action:@selector(clickDetailBtn) forControlEvents:UIControlEventTouchUpInside];
    
    [MainView addSubview:_detailBtn];
    
    float topY=10;
    float ScrollHeigh=0;
    float txtFWidth=fDeviceWidth-120;
    float txtFLeftX=90;
    float txtFHeigh=30;
    float lblWidth=70;
    CGFloat Fontsize=13;
    UILabel *typelbl=[[UILabel alloc]initWithFrame:CGRectMake(10, topY+40, 70, txtFHeigh)];
    typelbl.text=@"供求主题:";
    [typelbl setFont:[UIFont systemFontOfSize:Fontsize]];
    [MainView addSubview:typelbl];
    
    _ATxtF = [[UITextField alloc] initWithFrame:CGRectMake(txtFLeftX, topY+40, txtFWidth, txtFHeigh)];
    [self stdInitTxtF:_ATxtF hintxt:@"供求主题信息"];
    [MainView addSubview:_ATxtF];

    
    UILabel *Albl=[[UILabel alloc]initWithFrame:CGRectMake(10, topY+80, lblWidth, txtFHeigh)];
    Albl.text=@"品名:";
    [Albl setFont:[UIFont systemFontOfSize:Fontsize]];
    [MainView addSubview:Albl];
    
    _ALbl=[[UILabel alloc]initWithFrame:CGRectMake(txtFLeftX, topY+80, lblWidth+30, txtFHeigh)];
    _ALbl.text=@"点击选择品名";
    [_ALbl setFont:[UIFont systemFontOfSize:Fontsize]];
    [MainView addSubview:_ALbl];
    
    UIButton *ABtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [ABtn setFrame:CGRectMake(70, topY+80, 120, txtFHeigh)];
    [ABtn addTarget:self action:@selector(clickTypebtn) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:ABtn];
    
    UILabel *Blbl=[[UILabel alloc]initWithFrame:CGRectMake(10, topY+120, lblWidth, txtFHeigh)];
    Blbl.text=@"所属区域:";
    [Blbl setFont:[UIFont systemFontOfSize:Fontsize]];
    [MainView addSubview:Blbl];
    
    _BLbl=[[UILabel alloc]initWithFrame:CGRectMake(txtFLeftX, topY+120, lblWidth+30, txtFHeigh)];
    _BLbl.text=@"点击选择区域";
    [_BLbl setFont:[UIFont systemFontOfSize:Fontsize]];
    [MainView addSubview:_BLbl];
    
    UIButton *CBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [CBtn setFrame:CGRectMake(70, topY+120, 120, txtFHeigh)];
    [CBtn addTarget:self action:@selector(clickAreabtn) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:CBtn];
    
    
    UILabel *plbl=[[UILabel alloc]initWithFrame:CGRectMake(10, topY+160, 70, txtFHeigh)];
    plbl.text=@"规格:";
    [plbl setFont:[UIFont systemFontOfSize:Fontsize]];
    [MainView addSubview:plbl];
    
    _BTxtF = [[UITextField alloc] initWithFrame:CGRectMake(txtFLeftX, topY+160, txtFWidth, txtFHeigh)];
    [self stdInitTxtF:_BTxtF hintxt:@"规格"];
    [MainView addSubview:_BTxtF];
    
    UILabel *prlbl=[[UILabel alloc]initWithFrame:CGRectMake(10, topY+200, 70, txtFHeigh)];
    prlbl.text=@"价格:";
    [prlbl setFont:[UIFont systemFontOfSize:Fontsize]];
    [MainView addSubview:prlbl];
    
    _CTxtF = [[UITextField alloc] initWithFrame:CGRectMake(txtFLeftX, topY+200, txtFWidth, txtFHeigh)];
    [self stdInitTxtF:_CTxtF hintxt:@"价格如：23.50"];
    _CTxtF.keyboardType=UIKeyboardTypeNumbersAndPunctuation;
    [MainView addSubview:_CTxtF];
    
    UILabel *ulbl=[[UILabel alloc]initWithFrame:CGRectMake(txtFLeftX+txtFWidth+5, topY+200, 20, txtFHeigh)];
    ulbl.text=@"元";
    [ulbl setFont:[UIFont systemFontOfSize:Fontsize]];
    [MainView addSubview:ulbl];
    
    UILabel *Elbl=[[UILabel alloc]initWithFrame:CGRectMake(10, topY+240, lblWidth, txtFHeigh)];
    Elbl.text=@"单位:";
    [Elbl setFont:[UIFont systemFontOfSize:Fontsize]];
    [MainView addSubview:Elbl];
    
    _CLbl=[[UILabel alloc]initWithFrame:CGRectMake(txtFLeftX, topY+240, lblWidth+30, txtFHeigh)];
    _CLbl.text=@"点击选择单位";
    [_CLbl setFont:[UIFont systemFontOfSize:Fontsize]];
    [MainView addSubview:_CLbl];
    UIButton *DBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [DBtn setFrame:CGRectMake(70, topY+240, 120, txtFHeigh)];
    [DBtn addTarget:self action:@selector(clickUnitbtn) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:DBtn];
    
    UILabel *perlbl=[[UILabel alloc]initWithFrame:CGRectMake(10, topY+280, 70, txtFHeigh)];
    perlbl.text=@"联系人:";
    [perlbl setFont:[UIFont systemFontOfSize:Fontsize]];
    [MainView addSubview:perlbl];
    
    _DTxtF = [[UITextField alloc] initWithFrame:CGRectMake(txtFLeftX, topY+280, txtFWidth, txtFHeigh)];
    [self stdInitTxtF:_DTxtF hintxt:@"联系人"];
    [MainView addSubview:_DTxtF];
    
    UILabel *pholbl=[[UILabel alloc]initWithFrame:CGRectMake(10, topY+320, 70, txtFHeigh)];
    pholbl.text=@"联系电话:";
    [pholbl setFont:[UIFont systemFontOfSize:Fontsize]];
    [MainView addSubview:pholbl];
    
    _ETxtF = [[UITextField alloc] initWithFrame:CGRectMake(txtFLeftX, topY+320, txtFWidth, txtFHeigh)];
    [self stdInitTxtF:_ETxtF hintxt:@"联系电话"];
    _ETxtF.keyboardType=UIKeyboardTypeNumbersAndPunctuation;
    [MainView addSubview:_ETxtF];
    
    
    UILabel *timelbl =[[UILabel alloc]initWithFrame:CGRectMake(10, topY+360, lblWidth, txtFHeigh)];
    timelbl.text=@"有效期:";
    [timelbl setFont:[UIFont systemFontOfSize:Fontsize]];
    [MainView addSubview:timelbl];
    
    _DLbl=[[UILabel alloc]initWithFrame:CGRectMake(txtFLeftX, topY+360, lblWidth+80, txtFHeigh)];
    _DLbl.text=@"点击选择日期";
    [_DLbl setFont:[UIFont systemFontOfSize:Fontsize]];
    [MainView addSubview:_DLbl];
    
    UIButton *TBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [TBtn setFrame:CGRectMake(txtFLeftX, topY+360, lblWidth+100, txtFHeigh)];
    [TBtn addTarget:self action:@selector(clickTimebtn) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:TBtn];
    
    UILabel *detaillbl=[[UILabel alloc]initWithFrame:CGRectMake(10, topY+400, 80, txtFHeigh)];
    detaillbl.text=@"详细介绍:";
    [detaillbl setFont:[UIFont systemFontOfSize:Fontsize]];
    [MainView addSubview:detaillbl];
    _detailTxt = [[UITextView alloc] initWithFrame:CGRectMake(txtFLeftX, topY+410, txtFWidth, 120)];
    _detailTxt.backgroundColor = [UIColor clearColor];
    [_detailTxt setTintColor:[UIColor blueColor]];
    _detailTxt.textAlignment = UITextAutocorrectionTypeDefault;//UITextAlignmentCenter;
    _detailTxt.textColor=tabTxtColor;
    _detailTxt.layer.borderColor = [UIColor lightGrayColor].CGColor; // set color as you want.
    _detailTxt.layer.borderWidth = 1.0f; // set borderWidth as you want.
    _detailTxt.delegate=self;
    [MainView addSubview:_detailTxt];
    

    
    //上传缩略图
    UILabel *addPiclbl=[[UILabel alloc]initWithFrame:CGRectMake(10, topY+550, 80, txtFHeigh)];
    addPiclbl.text=@"添加照片";
    [addPiclbl setFont:[UIFont systemFontOfSize:Fontsize]];
    [MainView addSubview:addPiclbl];
    
    UIImageView *addimag=[[UIImageView alloc]initWithFrame:CGRectMake(70, topY+555, 20, 20)];
    addimag.image=[UIImage imageNamed:@"plus"];
    [MainView addSubview:addimag];
    
    
    _imageView=[[UIImageView alloc]initWithFrame:CGRectMake(txtFLeftX, topY+580, 120, 120)];
    [MainView addSubview:_imageView];
    
    UIButton *upLoadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [upLoadBtn setFrame:CGRectMake(0, topY+550, fDeviceWidth-100, 40)];
    [upLoadBtn addTarget:self action:@selector(clickAddbtn) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:upLoadBtn];
    
    ScrollHeigh=topY+720;
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

-(NSData *)makeMyUpImg:(UIImage*)valueToSend{
    
    UIImage* tmpImage = (UIImage*)valueToSend;
    UIImage* contextedImage;
    CGAffineTransform transform = CGAffineTransformIdentity;
    if ([valueToSend isKindOfClass:[UIImage class]]) {
  
        if (tmpImage.imageOrientation == UIImageOrientationUp) {
            
            contextedImage = tmpImage;
            
        }
        
        else{
            
            switch (tmpImage.imageOrientation ) {
                    
                case UIImageOrientationDown:
                    
                case UIImageOrientationDownMirrored:
                    
                    transform = CGAffineTransformTranslate(transform, tmpImage.size.width, tmpImage.size.height);
                    
                    transform = CGAffineTransformRotate(transform, M_PI);
                    
                    break;
                    
                case UIImageOrientationLeft:
                    
                case UIImageOrientationLeftMirrored:
                    
                    transform = CGAffineTransformTranslate(transform, tmpImage.size.width, 0);
                    
                    transform = CGAffineTransformRotate(transform, M_PI_2);
                    
                    break;
                    
                case UIImageOrientationRight:
                    
                case UIImageOrientationRightMirrored:
                    
                    transform = CGAffineTransformTranslate(transform, 0,tmpImage.size.height);
                    
                    transform = CGAffineTransformRotate(transform, -M_PI_2);
                    
                    break;
                    
                default:
                    
                    break;
                    
            }
  
            
            switch (tmpImage.imageOrientation) {
                    
                case UIImageOrientationUpMirrored:
                    
                case UIImageOrientationDownMirrored:
                    
                    transform = CGAffineTransformTranslate(transform, tmpImage.size.width, 0);
                    
                    transform = CGAffineTransformScale(transform, -1, 1);
                    
                    break;
                    
                case UIImageOrientationLeftMirrored:
                    
                case UIImageOrientationRightMirrored:
                    
                    transform = CGAffineTransformTranslate(transform, tmpImage.size.height, 0);
                    
                    transform = CGAffineTransformScale(transform, -1, 1);
                    
                    break;
                    
                default:
                    
                    break;
                    
            }
            
            CGContextRef ctx = CGBitmapContextCreate(NULL, tmpImage.size.width, tmpImage.size.height, CGImageGetBitsPerComponent(tmpImage.CGImage), 0, CGImageGetColorSpace(tmpImage.CGImage), CGImageGetBitmapInfo(tmpImage.CGImage));
            
            
            CGContextConcatCTM(ctx, transform);
            
            
            
            switch (tmpImage.imageOrientation) {
                    
                case UIImageOrientationLeft:
                    
                case UIImageOrientationLeftMirrored:
                    
                case UIImageOrientationRight:
                    
                case UIImageOrientationRightMirrored:
                    
                    CGContextDrawImage(ctx, CGRectMake(0, 0, tmpImage.size.height,tmpImage.size.width), tmpImage.CGImage);
                    
                    break;
                    
                default:
                    
                    CGContextDrawImage(ctx, CGRectMake(0, 0, tmpImage.size.width, tmpImage.size.height), tmpImage.CGImage);
                    
                    break;
                    
            }
            
            CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
            
            contextedImage = [UIImage imageWithCGImage:cgimg];
            
            CGContextRelease(ctx);
            
            CGImageRelease(cgimg);
            
            
        }
    }
    NSData *data = UIImageJPEGRepresentation(contextedImage, 0.1);
    return data;
}


#pragma mark - 保存图片至沙盒
- (void) saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    
    //NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.5);
    
    // 获取沙盒目录
    
    NSData *imageData=[self makeMyUpImg:currentImage];
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
    //NSLog(@"添加照片");
    [self btnActionForEditPortrait:nil];
}

-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [_ATxtF resignFirstResponder];
    [_BTxtF resignFirstResponder];
    [_CTxtF resignFirstResponder];
    [_DTxtF resignFirstResponder];
    [_ETxtF resignFirstResponder];
    //[_FTxtF resignFirstResponder];
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

-(void)setShowType:(NSInteger)showType{
    _showType=showType;
}

-(void)setDetailId:(NSString *)detailId{
    _detailId=detailId;
}

-(void)DetailNetRequest:(NSString*)detailId{
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setValue:@"supplydetail" forKey:@"ut"];
    [params setValue:detailId forKey:@"id"];
    DPAPI *api = [[DPAPI alloc]init];
    
    [api loginRequestWithURL:NetUrl params:params delegate:self];
    
}

-(void)loginrequest:(DPRequest *)request didFinishLoadingWithResult:(id)result{
    SupplyModel *dm=[[SupplyModel alloc]init];
    NSDictionary *dict = result;
    NSArray *datatmp;
    datatmp=[dm asignDetailModelWithDict:dict];
    [self initContent:datatmp];
     //NSLog(@"%@",result);
}

-(void)setDetailView{
    NSMutableAttributedString *content = [[NSMutableAttributedString alloc] initWithString:@"查看抢单"];
    NSRange contentRange = {0, [content length]};
    [content addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:contentRange];
    _detailLbl.attributedText = content;
    [_detailLbl setTextColor:[UIColor blueColor]];
    _detailLbl.font = [UIFont systemFontOfSize:13];
    _detailLbl.hidden=NO;
    
    _detailBtn.hidden=NO;

}
-(void)initContent:(NSArray *)contentArr{
    SupplyModel *mydm=[[SupplyModel alloc]init];
    if (contentArr.count>0) {
        _upLoad.text=@"修改";
        mydm=contentArr[0];
        _supplyType=mydm.supplyType;
        if ([_supplyType isEqualToString:@"0"]) {//供应
            [_rb1 setBtnState:YES];
        }
        else//求购
        {
            [_rb2 setBtnState:YES];
            [self setDetailView];
        }
        _typeId=mydm.brandId;
        _areaId=mydm.areaId;
        _ATxtF.text=mydm.title;
        _BTxtF.text=mydm.supplySpecName;
        _CTxtF.text=mydm.supplyPrice;
        _DTxtF.text=mydm.name;
        _ETxtF.text=mydm.phone;
        _detailTxt.text=mydm.supplyDesc;
        
        _ALbl.text=mydm.brandName;
        _BLbl.text=mydm.areaName;
        _CLbl.text=mydm.supplyUnit;
        _DLbl.text=mydm.supplyValidate;
        
        _detailTxt.text=mydm.supplyDesc;
        _supplyId=mydm.supplyId;
        [_imageView sd_setImageWithStr:mydm.images];
        [self saveImage:_imageView.image withName:@"currentImage.png"];
        
        
    }
    
}

-(void)clickDetailBtn{
    MyGrapedViewController *LiveView=[[MyGrapedViewController alloc]init:_supplyId];
    LiveView.hidesBottomBarWhenPushed=YES;
    LiveView.navigationItem.hidesBackButton=YES;
    LiveView.view.backgroundColor = [UIColor whiteColor];
    //[LiveView setSupplyId:_supplyId];
    [self.navigationController pushViewController:LiveView animated:YES];
}

@end
