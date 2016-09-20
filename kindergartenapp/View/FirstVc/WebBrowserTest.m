//
//  WebBrowserTest.m
//  kindergartenapp
//
//  Created by zr-mac on 16/8/21.
//  Copyright © 2016年 zr-mac. All rights reserved.
//

#import "WebBrowserTest.h"
#import "BabyVC.h"
#import "ClassVC.h"
#import "UserInfo.h"
#import "BaseFunc.h"



@interface WebBrowserTest()

@property (nonatomic,strong) UserInfo *userInfo;

@end

@implementation WebBrowserTest {
    BabyVC *baby_vc;
    ClassVC *class_vc;
    NSInteger i_role;
    ParentInfo *parent;
    TeacherInfo *teacher;
    Baby *baby;
    Class_School *class_school;
    
    BaseFunc *baseFunc;
    
    NSString *str_base_url;

    
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
    
    baseFunc=[[BaseFunc alloc]init];
    
    UIButton *btn_back=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 50)];
    [btn_back setTitle:@"返回" forState:UIControlStateNormal];
    [btn_back setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn_back setTintColor:[UIColor whiteColor]];
    [btn_back setImage:[UIImage imageNamed:@"returnlogo"] forState:UIControlStateNormal];
    [btn_back setTitleEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 0)];
    [btn_back addTarget:self action:@selector(BackToAppCenter:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:btn_back];
   
    self.view.backgroundColor=[UIColor whiteColor];
    
    NSData *data=[[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
    _userInfo=[[UserInfo alloc]init];
    _userInfo=[NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    i_role=[_userInfo.str_role integerValue];
    
    NSMutableArray *arr_menus=_userInfo.arr_menus;
    for (int i=0;i<[arr_menus count];i++) {
        NSDictionary *dic_menu_tmp=[arr_menus objectAtIndex:i];
        NSString *str_menuname=[baseFunc GetValueFromDic:dic_menu_tmp key:@"menuname"];
        NSString *str_menuurl=[baseFunc GetValueFromDic:dic_menu_tmp key:@"menuurl"];
        if ([str_menuname isEqualToString:_str_category]) {
            str_base_url=str_menuurl;
        }
    }
    
    NSMutableArray *arr_segment=[[NSMutableArray alloc]init];
    if (i_role==0) {

        if ([_str_category isEqualToString:@"相册"]) {
            [arr_segment addObject:@"宝宝相册"];
            [arr_segment addObject:@"班级相册"];
        }
        else if ([_str_category isEqualToString:@"视频"]) {
            [arr_segment addObject:@"宝宝视频"];
            [arr_segment addObject:@"班级视频"];
        }
    }
    else if (i_role==2) {
        if ([_str_category isEqualToString:@"相册"]) {
            
        }
        else if ([_str_category isEqualToString:@"视频"]) {
            
        }
    }
    
   
    
    UISegmentedControl *segment = [[UISegmentedControl alloc] initWithItems:arr_segment];
    segment.tintColor = [UIColor whiteColor];
    segment.selectedSegmentIndex = 0;
    [segment addTarget:self action:@selector(segmentClick:) forControlEvents:UIControlEventValueChanged];
     if ([[[UIDevice currentDevice] systemVersion] floatValue]>=10.0) {
         CGFloat i_width=  segment.frame.size.width;
         CGFloat i_height= segment.frame.size.height;
         [segment setFrame:CGRectMake((Width-i_width)/2, 5, i_width, i_height)];
    }
    self.navigationItem.titleView = segment;

    
    baby_vc=[[BabyVC alloc]init];
    class_vc=[[ClassVC alloc]init];
    NSString *str_baby_url=@"";
    NSString *str_class_url=@"";
    if ([_str_category isEqualToString:@"相册"]) {
        str_baby_url=[NSString stringWithFormat:@"%@%@%@%@%@",str_base_url,@"?user_key=",_str_xuejihao,@"&rtype=bb&roleid=",_userInfo.str_role];
        str_class_url=[NSString stringWithFormat:@"%@%@%@%@%@",str_base_url,@"?user_key=",_str_xuejihao,@"&rtype=bj&roleid=",_userInfo.str_role];
    }
    else if ([_str_category isEqualToString:@"视频"]) {
        str_baby_url=[NSString stringWithFormat:@"%@%@%@%@%@",str_base_url,@"?user_key=",_str_xuejihao,@"&rtype=bb&roleid=",_userInfo.str_role];
        str_class_url=[NSString stringWithFormat:@"%@%@%@%@%@",str_base_url,@"?user_key=",_str_xuejihao,@"&rtype=bj&roleid=",_userInfo.str_role];
    }
    baby_vc.str_url=str_baby_url;
    class_vc.str_url=str_class_url;
    [self.view addSubview:baby_vc.view];
    

}

-(void)BackToAppCenter:(UIButton*)Btn {
    if (self.view.subviews.count>0) {
        UIView *view_last= self.view.subviews.lastObject;
        //如果是宝宝的
        if (view_last.tag==1001) {
            WKWebView *webview=(WKWebView*)[view_last.subviews objectAtIndex:0];
            if (webview.canGoBack) {
                [webview goBack];
            }
            else {
                [self.navigationController popViewControllerAnimated:NO];
            }
            NSLog(@"返回");
        }
        //如果是班级的
        else if (view_last.tag==1002) {
            NSLog(@"返回");
            WKWebView *webview=(WKWebView*)[view_last.subviews objectAtIndex:0];
            if (webview.canGoBack) {
                [webview goBack];
            }
            else {
                [self.navigationController popViewControllerAnimated:NO];
            }

        }
    }
    
    /*
    if (wb_content.canGoBack) {
        [wb_content goBack];
    }
    else {
     */
    
  //  }
    
   
}

-(void)segmentClick:(UISegmentedControl *)segment{
    switch (segment.selectedSegmentIndex) {
        case 0:
            //第一个界面
            [self.view addSubview:baby_vc.view];
            [class_vc.view removeFromSuperview];
            break;
        case 1:
            [self.view addSubview:class_vc.view];
            [baby_vc.view removeFromSuperview];
            break;
        default:
            break;
    }
}

-(void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion {
    if ( self.presentedViewController)
    {
        [super dismissViewControllerAnimated:flag completion:completion];
    }
}

@end
