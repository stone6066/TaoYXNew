//
//  DetailPubShopViewController.m
//  TaoYXNew
//
//  Created by tianan-apple on 16/1/9.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "DetailPubShopViewController.h"
#import "PublicDefine.h"
#import "QuartzCore/QuartzCore.h"
#import "StdUploadFileApi.h"
#import "PusMsgPopViewController.h"
#import "stdPubFunc.h"
#import "DPAPI.h"
#import "CmpModel.h"
#import "UIImageView+WebCache.h"

@interface DetailPubShopViewController ()<UITextFieldDelegate,UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,uploadProgressDelegate,DPRequestDelegate>
{
    BOOL isFullScreen;
    NSString *imgFullpath;
    
}
@end

@implementation DetailPubShopViewController

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
    _showType=0;
    [self DetailNetRequest];
    
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
    viewTitle.text=@"发布餐企商超";
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
    
    UILabel *upLoad=[[UILabel alloc]initWithFrame:CGRectMake(fDeviceWidth-60, 20, 40, 40)];
    upLoad.text=@"上传";
    [upLoad setTextColor:[UIColor whiteColor]];
    [upLoad setFont:[UIFont systemFontOfSize:16]];
    [topSearch addSubview:upLoad];
    
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

-(NSMutableDictionary*)makeShopUploadData{
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    if (_showType==1) {//修改
        [params setValue:_detailId forKey:@"empId"];
    }
   
    [params setValue:@"saveEmp" forKey:@"ut"];
    
    [params setValue:_ATxtF.text forKey:@"empName"];
    [params setValue:_areaId forKey:@"areaId"];
    [params setValue:_areaLbl.text forKey:@"areaName"];
    [params setValue:_BTxtF.text forKey:@"contact"];
    [params setValue:_DTxtF.text forKey:@"phone"];
    [params setValue:_CTxtF.text forKey:@"mobile"];
    [params setValue:_ETxtF.text forKey:@"fax"];
    [params setValue:_FTxtF.text forKey:@"address"];
    [params setValue:_detailTxt.text forKey:@"empDesc"];
    
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
    if (_FTxtF.text.length<1) {
        return 0;
    }
    if (_areaLbl.text.length<1) {
        return 0;
    }
    if (_areaId.length<1) {
        return 0;
    }
    return 1;
}

////上传数据
//- (void)UploadTxtCreateRequest{
//    DPAPI *api = [[DPAPI alloc]init];
//    [api postRequestWithURL: NetUrl params:[self makeShopUploadData] delegate:self];
//    //[api postRequestWithURL: NetUrl params:[self makePriceUploadData] delegate:self];
//}
//
//-(void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result
//{
//    UIView *view = (UIView*)[self.view viewWithTag:108];
//    [view removeFromSuperview];
//    NSDictionary *dict = result;
//    NSString *upResult=[dict objectForKey:@"msg"];
//    if ([upResult isEqualToString:@"ok"]) {
//        [stdPubFunc stdShowMessage:@"上传成功"];
//    }
//    else
//        [stdPubFunc stdShowMessage:@"上传失败"];
//}
//
//-(void)request:(DPRequest *)request didFailWithError:(NSError *)error
//{
//    UIView *view = (UIView*)[self.view viewWithTag:108];
//    [view removeFromSuperview];
//    [stdPubFunc stdShowMessage:@"上传错误"];
//}

-(void)clickUpbtn{
    
    if (0==[self checkInfoComplet]) {
        [stdPubFunc stdShowMessage:@"信息不完整，请完善后上传"];
    }
    else
    {
        NSString *Path = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentImage.png"];
        StdUploadFileApi *upRequst=[[StdUploadFileApi alloc]init];
        upRequst.delegate=self;
        [self loadProgress];
        if (_imageView.image) {
        [upRequst stdUploadFileWithProgress:NetUrl filePath:Path fileName:@"currentImage.png" mimeType:@"image/jpeg" pragram:[self makeShopUploadData]];
        
        }
        else
        {
        [upRequst stdUploadFileWithProgress:NetUrl filePath:@"" fileName:@"currentImage.png" mimeType:@"image/jpeg" pragram:[self makeShopUploadData]];
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
    //    PopViewController *pvc = [[PopViewController alloc]init];
    //    [self.navigationController pushViewController:pvc animated:YES];
    
    PusMsgPopViewController *pvc = [[PusMsgPopViewController alloc]init];
    pvc.hidesBottomBarWhenPushed=YES;
    pvc.navigationItem.hidesBackButton=YES;
    [pvc setDataType:clickIndex];//0区域列表
    pvc.TypeChangeBlock = ^(PusMsgPopViewController *aqrvc,NSString *qrString,NSString *nameString,NSInteger qtType,NSString*myTypeName,NSString* myTypeId){
        [aqrvc dismissViewControllerAnimated:NO completion:nil];
        [_areaLbl setText:qrString];
        _areaId=[self getMyCityCode:qrString];
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
    typelbl.text=@"企业名称:";
    [typelbl setFont:[UIFont systemFontOfSize:Fontsize]];
    [MainView addSubview:typelbl];
    
    _ATxtF = [[UITextField alloc] initWithFrame:CGRectMake(txtFLeftX, topY, txtFWidth, txtFHeigh)];
    [self stdInitTxtF:_ATxtF hintxt:@"企业名称"];
    [MainView addSubview:_ATxtF];
    
    UILabel *Albl=[[UILabel alloc]initWithFrame:CGRectMake(10, topY+40, lblWidth, txtFHeigh)];
    Albl.text=@"所在区域:";
    
    [Albl setFont:[UIFont systemFontOfSize:Fontsize]];
    [MainView addSubview:Albl];
    
    _areaLbl=[[UILabel alloc]initWithFrame:CGRectMake(txtFLeftX, topY+40, lblWidth+30, txtFHeigh)];
    _areaLbl.text=@"点击选择区域";
    [_areaLbl setFont:[UIFont systemFontOfSize:Fontsize]];
    [MainView addSubview:_areaLbl];
    
    UIButton *CBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [CBtn setFrame:CGRectMake(70, topY+40, 120, txtFHeigh)];
    [CBtn addTarget:self action:@selector(clickAreabtn) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:CBtn];
    
    
    UILabel *Dlbl=[[UILabel alloc]initWithFrame:CGRectMake(10, topY+80, lblWidth, txtFHeigh)];
    Dlbl.text=@"联系人:";
    [Dlbl setFont:[UIFont systemFontOfSize:Fontsize]];
    [MainView addSubview:Dlbl];
    _BTxtF = [[UITextField alloc] initWithFrame:CGRectMake(txtFLeftX, topY+80, txtFWidth, txtFHeigh)];
    [self stdInitTxtF:_BTxtF hintxt:@"单位联系人"];
    [MainView addSubview:_BTxtF];
    
    UILabel *Elbl=[[UILabel alloc]initWithFrame:CGRectMake(10, topY+120, lblWidth, txtFHeigh)];
    Elbl.text=@"联系人手机:";
    [Elbl setFont:[UIFont systemFontOfSize:Fontsize]];
    [MainView addSubview:Elbl];
    _CTxtF = [[UITextField alloc] initWithFrame:CGRectMake(txtFLeftX, topY+120, txtFWidth, txtFHeigh)];
    _CTxtF.keyboardType=UIKeyboardTypeNumbersAndPunctuation;
    [self stdInitTxtF:_CTxtF hintxt:@"联系人手机"];
    [MainView addSubview:_CTxtF];
    
    
    UILabel *Flbl=[[UILabel alloc]initWithFrame:CGRectMake(10, topY+160, lblWidth, txtFHeigh)];
    Flbl.text=@"联系电话:";
    [Flbl setFont:[UIFont systemFontOfSize:Fontsize]];
    [MainView addSubview:Flbl];
    _DTxtF = [[UITextField alloc] initWithFrame:CGRectMake(txtFLeftX, topY+160, txtFWidth, txtFHeigh)];
    _DTxtF.keyboardType=UIKeyboardTypeNumbersAndPunctuation;
    [self stdInitTxtF:_DTxtF hintxt:@"联系电话"];
    [MainView addSubview:_DTxtF];
    
    UILabel *Glbl=[[UILabel alloc]initWithFrame:CGRectMake(10, topY+200, lblWidth, txtFHeigh)];
    Glbl.text=@"传真:";
    [Glbl setFont:[UIFont systemFontOfSize:Fontsize]];
    [MainView addSubview:Glbl];
    _ETxtF = [[UITextField alloc] initWithFrame:CGRectMake(txtFLeftX, topY+200, txtFWidth, txtFHeigh)];
    _ETxtF.keyboardType=UIKeyboardTypeNumbersAndPunctuation;
    [self stdInitTxtF:_ETxtF hintxt:@"传真"];
    [MainView addSubview:_ETxtF];
    
    UILabel *Hlbl=[[UILabel alloc]initWithFrame:CGRectMake(10, topY+240, lblWidth, txtFHeigh)];
    Hlbl.text=@"详细地址:";
    [Hlbl setFont:[UIFont systemFontOfSize:Fontsize]];
    [MainView addSubview:Hlbl];
    _FTxtF = [[UITextField alloc] initWithFrame:CGRectMake(txtFLeftX, topY+240, txtFWidth, txtFHeigh)];
    [self stdInitTxtF:_FTxtF hintxt:@"详细地址"];
    [MainView addSubview:_FTxtF];

    //上传缩略图
    UILabel *addPiclbl=[[UILabel alloc]initWithFrame:CGRectMake(10, topY+450, 80, txtFHeigh)];
    addPiclbl.text=@"添加照片";
    [addPiclbl setFont:[UIFont systemFontOfSize:Fontsize]];
    [MainView addSubview:addPiclbl];
    
    UIImageView *addimag=[[UIImageView alloc]initWithFrame:CGRectMake(70, topY+455, 20, 20)];
    addimag.image=[UIImage imageNamed:@"plus"];
    [MainView addSubview:addimag];
    
    
    _imageView=[[UIImageView alloc]initWithFrame:CGRectMake(txtFLeftX, topY+480, 120, 120)];
    [MainView addSubview:_imageView];
    
    UIButton *upLoadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [upLoadBtn setFrame:CGRectMake(0, topY+450, fDeviceWidth-100, 40)];
    [upLoadBtn addTarget:self action:@selector(clickAddbtn) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:upLoadBtn];
    
    UILabel *detaillbl=[[UILabel alloc]initWithFrame:CGRectMake(10, topY+280, 80, txtFHeigh)];
    detaillbl.text=@"详细介绍:";
    [detaillbl setFont:[UIFont systemFontOfSize:Fontsize]];
    [MainView addSubview:detaillbl];
    _detailTxt = [[UITextView alloc] initWithFrame:CGRectMake(txtFLeftX, topY+310, txtFWidth, 120)];
    _detailTxt.backgroundColor = [UIColor clearColor];
    [_detailTxt setTintColor:[UIColor blueColor]];
    _detailTxt.textAlignment = UITextAutocorrectionTypeDefault;//UITextAlignmentCenter;
    _detailTxt.textColor=tabTxtColor;
    _detailTxt.layer.borderColor = [UIColor lightGrayColor].CGColor; // set color as you want.
    _detailTxt.layer.borderWidth = 1.0f; // set borderWidth as you want.
    _detailTxt.delegate=self;
    [MainView addSubview:_detailTxt];
    ScrollHeigh=topY+680;
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

-(void)DetailNetRequest{
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setValue:@"checkEmp" forKey:@"ut"];
    [params setValue:[stdPubFunc readUserUid] forKey:@"pubId"];
    DPAPI *api = [[DPAPI alloc]init];
    
    [api loginRequestWithURL:NetUrl params:params delegate:self];
    
}

-(void)loginrequest:(DPRequest *)request didFinishLoadingWithResult:(id)result{
    CmpModel *dm=[[CmpModel alloc]init];
    NSDictionary *dict = result;
    NSArray *datatmp;
    datatmp=[dm asignDetailModelWithDict:dict];
    [self initContent:datatmp];
    //NSLog(@"%@",result);
}

-(void)initContent:(NSArray *)contentArr{
    CmpModel *mydm=[[CmpModel alloc]init];
    if (contentArr.count>0) {
         mydm=contentArr[0];
        _areaId=mydm.areaId;
        _ATxtF.text=mydm.empName;
        _BTxtF.text=mydm.contact;
        _CTxtF.text=mydm.mobile;
        _DTxtF.text=mydm.phone;
        _ETxtF.text=mydm.fax;
        _FTxtF.text=mydm.address;
        _detailTxt.text=mydm.empDesc;
        _areaLbl.text=mydm.areaName;
        _detailId=mydm.empId;
        [_imageView sd_setImageWithStr:mydm.images];
        [self saveImage:_imageView.image withName:@"currentImage.png"];
        _showType=1;
    }
    
}
@end
