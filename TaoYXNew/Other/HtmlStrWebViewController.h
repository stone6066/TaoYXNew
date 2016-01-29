//
//  HtmlStrWebViewController.h
//  TaoYXNew
//
//  Created by tianan-apple on 15/12/23.
//  Copyright © 2015年 tianan-apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HtmlStrWebViewController : UIViewController<UIWebViewDelegate>
{
    UIWebView *webView;
    UIActivityIndicatorView *activityIndicator;
}
@property(nonatomic,copy)NSString *weburl;
@property(nonatomic,copy)NSString *topTitle;
@property(nonatomic,assign)NSInteger scanFlag;//扫二维码按钮是否可用
@property(nonatomic,strong)UIButton *scanBtn;
-(void)setWeburl:(NSString *)weburl;

@end
