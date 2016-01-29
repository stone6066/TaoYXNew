//
//  HtmlStrWebViewController.m
//  TaoYXNew
//
//  Created by tianan-apple on 15/12/23.
//  Copyright © 2015年 tianan-apple. All rights reserved.
//

#import "HtmlStrWebViewController.h"
#import "PublicDefine.h"
#import "SYQRCodeViewController.h"

@interface HtmlStrWebViewController ()
{
    UIButton *back;
    NSInteger backflag;
}
@end

@implementation HtmlStrWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadWebView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setWeburl:(NSString *)weburl{
    _weburl=weburl;
//    _weburl=@"<h1 style='margin: 0px 0px 10px; padding: 0px 4px 0px 0px; border-bottom-color: rgb(204, 204, 204); border-bottom-width: 2px; border-bottom-style: solid;' name='tl' label='Title left'><span style='color: rgb(227, 108, 9);' class='ue_t'>[此处键入简历标题]</span></h1><p><span style='color: rgb(227, 108, 9);'><br/></span></p><table style='border-collapse: collapse;' border='1' bordercolor='#95b3d7' width='100%'><tbody><tr class='firstRow'><td style='text-align: center;' class='ue_t' width='200'>【此处插入照片】</td><td><p><br/></p><p>联系电话：<span class='ue_t'>[键入您的电话]</span></p><p><br/></p><p>电子邮件：<span class='ue_t'>[键入您的电子邮件地址]</span></p><p><br/></p><p>家庭住址：<span class='ue_t'>[键入您的地址]</span></p><p><br/></p></td></tr></tbody></table><h3><span style='color: rgb(227, 108, 9); font-size: 20px;'>目标职位</span></h3><p style='text-indent: 2em;' class='ue_t'>[此处键入您的期望职位]</p><h3><span style='color: rgb(227, 108, 9); font-size: 20px;'>学历</span></h3><p>&nbsp;</p><ol style='list-style-type: decimal;' class=' list-paddingleft-2'><li><p><span class='ue_t'>[键入起止时间]</span> <span class='ue_t'>[键入学校名称] </span> <span class='ue_t'>[键入所学专业]</span> <span class='ue_t'>[键入所获学位]</span></p></li><li><p><span class='ue_t'>[键入起止时间]</span> <span class='ue_t'>[键入学校名称]</span> <span class='ue_t'>[键入所学专业]</span> <span class='ue_t'>[键入所获学位]</span></p></li></ol><h3><span style='color: rgb(227, 108, 9); font-size: 20px;' class='ue_t'>工作经验</span></h3><ol style='list-style-type: decimal;' class=' list-paddingleft-2'><li><p><span class='ue_t'>[键入起止时间]</span> <span class='ue_t'>[键入公司名称]</span> <span class='ue_t'>[键入职位名称]</span></p></li><ol style='list-style-type: lower-alpha;' class=' list-paddingleft-2'><li><p><span class='ue_t'>[键入负责项目]</span> <span class='ue_t'>[键入项目简介]</span></p></li><li><p><span class='ue_t'>[键入负责项目]</span> <span class='ue_t'>[键入项目简介]</span></p></li></ol><li><p><span class='ue_t'>[键入起止时间]</span> <span class='ue_t'>[键入公司名称]</span> <span class='ue_t'>[键入职位名称]</span></p></li><ol style='list-style-type: lower-alpha;' class=' list-paddingleft-2'><li><p><span class='ue_t'>[键入负责项目]</span> <span class='ue_t'>[键入项目简介]</span></p></li></ol></ol><p><span style='color: rgb(227, 108, 9); font-size: 20px;'>掌握技能</span></p><p style='text-indent: 2em;'>&nbsp;<span class='ue_t'>[这里可以键入您所掌握的技能]</span><br/></p><p>&nbsp;<img src='http://api.map.baidu.com/staticimage?center=116.404,39.915&zoom=10&width=530&height=340&markers=116.404,39.915' width='530' height='340'/></p>";
}

-(void) loadWebView{
    UIView *TopView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, TopSeachHigh)];
    TopView.backgroundColor=topSearchBgdColor;//[UIColor redColor];
    
    UILabel *topLbl=[[UILabel alloc]initWithFrame:CGRectMake(fDeviceWidth/2-35, 18, 80, 40)];
    topLbl.text=_topTitle;
    [topLbl setTextColor:[UIColor whiteColor]];
    
    [TopView addSubview:topLbl];
    UIImageView *backimg=[[UIImageView alloc]initWithFrame:CGRectMake(8, 24, 60, 24)];
    backimg.image=[UIImage imageNamed:@"bar_back"];
    [TopView addSubview:backimg];
    //返回按钮
    back = [UIButton buttonWithType:UIButtonTypeCustom];
    [back setFrame:CGRectMake(0, 22, 70, 42)];
    [back addTarget:self action:@selector(clickleftbtn) forControlEvents:UIControlEventTouchUpInside];
    [TopView addSubview:back];
    
    
    
    [self.view addSubview:TopView];
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, TopSeachHigh, fDeviceWidth, fDeviceHeight-TopSeachHigh)];
    [webView setDelegate:self];

     [webView loadHTMLString:_weburl baseURL:nil];
    [self.view addSubview: webView];
    
    
}
- (void) webViewDidStartLoad:(UIWebView *)webView
{
    //创建UIActivityIndicatorView背底半透明View
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, TopSeachHigh, fDeviceWidth, fDeviceHeight)];
    [view setTag:108];
    [view setBackgroundColor:[UIColor blackColor]];
    [view setAlpha:0.5];
    [self.view addSubview:view];
    
    activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 32.0f, 32.0f)];
    [activityIndicator setCenter:view.center];
    [activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
    [view addSubview:activityIndicator];
    
    [activityIndicator startAnimating];
}


- (void) webViewDidFinishLoad:(UIWebView *)webView
{
    NSString *location=webView.request.URL.absoluteString;
    if ([location isEqualToString:@"http://www.tao-yx.com/mobile/"]) {
        backflag=1;
    }
    else
        backflag=0;
    [activityIndicator stopAnimating];
    UIView *view = (UIView*)[self.view viewWithTag:108];
    [view removeFromSuperview];
    
    NSLog(@"webViewDidFinishLoad123");
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"shouldStartLoadWithRequest");
    return YES;//return NO 的时候，webview就不会加载页面了
}
-(void)clickleftbtn
{
    if (1==backflag) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        if ([webView canGoBack]) {
            [webView goBack];
            NSLog(@"canGoBack");
        }
        else
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}
- (void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
    [activityIndicator stopAnimating];
    UIView *view = (UIView*)[self.view viewWithTag:108];
    [view removeFromSuperview];
    
    NSLog(@"didFailLoadWithError:%@", error);
}


-(void)loadScanBtn{
    // 添加扫一扫按钮
    UIView *scanView=[[UIView alloc]initWithFrame:CGRectMake(fDeviceWidth-50, 90, 40, 60)];
    
    UIImageView * scanImg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    scanImg.image=[UIImage imageNamed:@"myscan"];
    [scanView addSubview:scanImg];
    
    UILabel *scanLbl=[[UILabel alloc]initWithFrame:CGRectMake(5, 35, 40, 20)];
    [scanLbl setText:@"扫一扫"];
    [scanLbl setFont:[UIFont systemFontOfSize:10]];
    scanLbl.textColor=[UIColor blackColor];
    [scanView addSubview:scanLbl];
    
    _scanBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 60)];
    [_scanBtn addTarget:self action:@selector(doScan:) forControlEvents:UIControlEventTouchUpInside];
    ////_scanBtn.backgroundColor=[UIColor redColor];
    [scanView addSubview:_scanBtn];
    
    //scanView.backgroundColor=[UIColor yellowColor];
    [self.view addSubview:scanView];
    
    
}

- (void)doScan:(UIButton *)button
{
    
    SYQRCodeViewController *qrcodevc = [[SYQRCodeViewController alloc] init];
    qrcodevc.SYQRCodeSuncessBlock = ^(SYQRCodeViewController *aqrvc,NSString *qrString){
        [aqrvc dismissViewControllerAnimated:NO completion:nil];
        
        NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:qrString]];
        [webView loadRequest:request];
        
        
    };
    qrcodevc.SYQRCodeFailBlock = ^(SYQRCodeViewController *aqrvc){
        [aqrvc dismissViewControllerAnimated:NO completion:nil];
    };
    qrcodevc.SYQRCodeCancleBlock = ^(SYQRCodeViewController *aqrvc){
        [aqrvc dismissViewControllerAnimated:NO completion:nil];
    };
    [self presentViewController:qrcodevc animated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
