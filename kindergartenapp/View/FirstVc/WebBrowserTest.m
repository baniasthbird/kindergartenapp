//
//  WebBrowserTest.m
//  kindergartenapp
//
//  Created by zr-mac on 16/8/21.
//  Copyright © 2016年 zr-mac. All rights reserved.
//

#import "WebBrowserTest.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "UIImage+GIF.h"

@interface WebBrowserTest()<WKNavigationDelegate>

@end

@implementation WebBrowserTest {
     WKWebView *wb_content;
    
     AFHTTPSessionManager *session;
    
     MBProgressHUD *hud;
}

-(void)viewDidLoad {
   
    WKWebViewConfiguration *config=[[WKWebViewConfiguration alloc]init];
    //设置偏好设置
    config.preferences=[[WKPreferences alloc]init];
    config.preferences.minimumFontSize=10;
    config.preferences.javaScriptEnabled=YES;
    config.preferences.javaScriptCanOpenWindowsAutomatically=NO;
    config.processPool=[[WKProcessPool alloc]init];
    
    wb_content=[[WKWebView alloc]initWithFrame:CGRectMake(0, 30, Width, Height) configuration:config];
    wb_content.navigationDelegate=self;
    [wb_content loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_str_url]]];
   // wb_content.URL=url;
    
    hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.userInteractionEnabled=NO;
    hud.dimBackground=YES;
    hud.color=[UIColor clearColor];
    [self.view addSubview:hud];
    hud.mode=MBProgressHUDModeCustomView;
    UIImage *images=[UIImage sd_animatedGIFNamed:@"loading"];
    hud.customView=[[UIImageView alloc]initWithImage:images];
    
    [self.view addSubview:wb_content];
    
    session=[AFHTTPSessionManager manager];
    session.responseSerializer= [AFHTTPResponseSerializer serializer];
    [session.requestSerializer setHTTPShouldHandleCookies:YES];
    [session.requestSerializer setTimeoutInterval:10.0f];

}

-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    [self.view addSubview:hud];
    [hud show:YES];
}

-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [hud hide:YES];
}

@end
