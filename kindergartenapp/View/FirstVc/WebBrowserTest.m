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
    
    NSDictionary * dict;
    if (iPad) {
        dict=@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:25]};
    }
    else {
        dict =@{
                NSForegroundColorAttributeName:   [UIColor whiteColor]};
    }
    
    self.navigationController.navigationBar.titleTextAttributes=dict;
    
    UIButton *btn_back=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [btn_back setTitle:@"  " forState:UIControlStateNormal];
    [btn_back setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn_back setTintColor:[UIColor whiteColor]];
    [btn_back setImage:[UIImage imageNamed:@"returnlogo"] forState:UIControlStateNormal];
    [btn_back addTarget:self action:@selector(BackToAppCenter:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:btn_back];
   
    WKWebViewConfiguration *config=[[WKWebViewConfiguration alloc]init];
    //设置偏好设置
    config.preferences=[[WKPreferences alloc]init];
    config.preferences.minimumFontSize=10;
    config.preferences.javaScriptEnabled=YES;
    config.preferences.javaScriptCanOpenWindowsAutomatically=NO;
    config.processPool=[[WKProcessPool alloc]init];
    
    wb_content=[[WKWebView alloc]initWithFrame:CGRectMake(0, 0, Width, Height) configuration:config];
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

-(void)BackToAppCenter:(UIButton*)Btn {
    [self.navigationController popViewControllerAnimated:NO];
   
}

-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    [self.view addSubview:hud];
    [hud show:YES];
}

-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [hud hide:YES];
}

-(void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion {
    if ( self.presentedViewController)
    {
        [super dismissViewControllerAnimated:flag completion:completion];
    }
}

@end
