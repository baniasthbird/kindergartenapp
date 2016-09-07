//
//  ClassVC.m
//  kindergartenapp
//
//  Created by zr-mac on 16/9/7.
//  Copyright © 2016年 zr-mac. All rights reserved.
//

#import "ClassVC.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "UIImage+GIF.h"

@interface ClassVC ()<WKNavigationDelegate,WKUIDelegate>

@end

@implementation ClassVC {
    
    AFHTTPSessionManager *session;
    
    MBProgressHUD *hud;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //班级相册或视频的tag
    self.view.tag=1002;
    // Do any additional setup after loading the view.
    WKWebViewConfiguration *config=[[WKWebViewConfiguration alloc]init];
    //设置偏好设置
    config.preferences=[[WKPreferences alloc]init];
    config.preferences.minimumFontSize=10;
    config.preferences.javaScriptEnabled=YES;
    config.preferences.javaScriptCanOpenWindowsAutomatically=NO;
    config.processPool=[[WKProcessPool alloc]init];
    
    self.wb_content=[[WKWebView alloc]initWithFrame:CGRectMake(0, 60, Width, Height) configuration:config];
    self.wb_content.navigationDelegate=self;
    self.wb_content.UIDelegate=self;
    [self.wb_content setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    [self.wb_content setAllowsBackForwardNavigationGestures:YES];
    [self.wb_content loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.str_url]]];
    // wb_content.URL=url;
    
    hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.userInteractionEnabled=NO;
    hud.dimBackground=YES;
    hud.color=[UIColor clearColor];
    [self.view addSubview:hud];
    hud.mode=MBProgressHUDModeCustomView;
    UIImage *images=[UIImage sd_animatedGIFNamed:@"loading"];
    hud.customView=[[UIImageView alloc]initWithImage:images];
    
    [self.view addSubview:self.wb_content];
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
