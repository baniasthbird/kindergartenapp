//
//  WebBrowserTest.h
//  kindergartenapp
//
//  Created by zr-mac on 16/8/21.
//  Copyright © 2016年 zr-mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TeacherInfo.h"
#import "ParentInfo.h"

@import WebKit;

@interface WebBrowserTest : UIViewController

@property (nonatomic,strong) NSString *str_url;

@property (nonatomic,strong) NSString *str_category;

@property (nonatomic,strong) NSString *str_xuejihao;

@property (nonatomic,strong) NSString *str_class_id;

@property (nonatomic,strong) NSString *str_school_id;


@end
