//
//  ClassVC.h
//  kindergartenapp
//
//  Created by zr-mac on 16/9/7.
//  Copyright © 2016年 zr-mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@import WebKit;

@interface ClassVC : UIViewController

@property (nonatomic,strong) WKWebView *wb_content;

@property (nonatomic,strong) NSString *str_url;

@end
