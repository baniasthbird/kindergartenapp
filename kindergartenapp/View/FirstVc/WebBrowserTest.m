//
//  WebBrowserTest.m
//  kindergartenapp
//
//  Created by zr-mac on 16/8/21.
//  Copyright © 2016年 zr-mac. All rights reserved.
//

#import "WebBrowserTest.h"
#import "AFNetworking.h"

@interface WebBrowserTest()<WKNavigationDelegate>

@end

@implementation WebBrowserTest {
     WKWebView *wb_content;
    
     AFHTTPSessionManager *session;
}

-(void)viewDidLoad {
   
    WKWebViewConfiguration *config=[[WKWebViewConfiguration alloc]init];
    //设置偏好设置
    config.preferences=[[WKPreferences alloc]init];
    config.preferences.minimumFontSize=10;
    config.preferences.javaScriptEnabled=YES;
    config.preferences.javaScriptCanOpenWindowsAutomatically=NO;
    config.processPool=[[WKProcessPool alloc]init];
    
    wb_content=[[WKWebView alloc]initWithFrame:CGRectMake(0, 0, Width, Height) configuration:config];
    [wb_content loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_str_url]]];
   // wb_content.URL=url;
    
    [self.view addSubview:wb_content];
    
    session=[AFHTTPSessionManager manager];
    session.responseSerializer= [AFHTTPResponseSerializer serializer];
    [session.requestSerializer setHTTPShouldHandleCookies:YES];
    [session.requestSerializer setTimeoutInterval:10.0f];
    
    

}

@end
