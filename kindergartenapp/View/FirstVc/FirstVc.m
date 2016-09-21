//
//  FirstVc.m
//  kindergartenapp
//
//  Created by zr-mac on 16/8/14.
//  Copyright © 2016年 zr-mac. All rights reserved.
//

#import "FirstVc.h"
#import "WebBrowserTest.h"
#import "BaseFunc.h"
#import "SDCycleScrollView.h"
#import "tb_select.h"
#import "MBProgressHUD.h"
#import "UIImage+GIF.h"
#import "StayTuneVC.h"

@interface FirstVc() <tableviewselectDelegate>



@end

@implementation FirstVc {
    
    NSInteger i_role;
    
    
    UIView *bgView1;
    
    UIView *bgView2;
    
    UIView *bgView3;
    
    BaseFunc *baseFunc;
    
    ParentInfo *parent;
    
    TeacherInfo *teacher;
    
    SDCycleScrollView *s_scrollView;
    
    NSArray *arr_img_header;
    
    BOOL b_Launch;
    
    Baby *baby;
    
    Class_School *class_school;
    
    
    MBProgressHUD *hud;
    
    UIButton *rightButton;
    
    NSInteger i_Load;
   
}


-(void)viewDidLoad {
    
   
        baseFunc =[[BaseFunc alloc]init];
        
        hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.userInteractionEnabled=NO;
        hud.dimBackground=YES;
        hud.color=[UIColor clearColor];
        [self.view addSubview:hud];
        hud.mode=MBProgressHUDModeCustomView;
        UIImage *images=[UIImage sd_animatedGIFNamed:@"loading"];
        hud.customView=[[UIImageView alloc]initWithImage:images];
    [hud.customView setFrame:CGRectMake(0, 0, 0.2*Width, 0.2*Width)];
        [hud show:YES];
        
        UITabBarItem *tmp_item=[self.tabBarController.tabBar.items objectAtIndex:1];
        tmp_item.image=[[UIImage imageNamed:@"second"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.tabBarItem.image=[[UIImage imageNamed:@"first"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.tabBarItem.selectedImage=[[UIImage imageNamed:@"first_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        
        self.navigationController.navigationBar.topItem.title=@"新马良幼儿园";
        
    Baby *baby_now;
    
        // UIView *view=
        //   self.navigationController.navigationBar.topItem.titleView.backgroundColor=[UIColor colorWithRed:226/255.0f green:101/255.0f blue:51/255.0f alpha:1];
        //self.navigationController.navigationBar.backgroundColor=[UIColor colorWithRed:226/255.0f green:101/255.0f blue:51/255.0f alpha:1];
        //self.view.=@"新马良幼儿园";
        
        NSData *data=[[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
        _userInfo=[[UserInfo alloc]init];
        _userInfo=[NSKeyedUnarchiver unarchiveObjectWithData:data];
        
        i_role=[_userInfo.str_role integerValue];
        
        NSString *str_banner_img1=@"img_T_Header1";
        NSString *str_banner_img2=@"img_T_Header2";
        NSString *str_banner_img3=@"img_T_Header3";
        NSString *str_banner_img4=@"img_T_Header4";
        
        if (i_role==0) {
            if (parent==nil && baby==nil) {
                parent=[[ParentInfo alloc]init];
                baby=[[Baby alloc]init];
                NSData *data_parent=[[NSUserDefaults standardUserDefaults] objectForKey:@"user_parent"];
                parent=[NSKeyedUnarchiver unarchiveObjectWithData:data_parent];
                baby=[parent.arr_baby objectAtIndex:0];
            }
           
            NSData *data_baby_now=[[NSUserDefaults standardUserDefaults] objectForKey:@"baby_now"];
            baby_now=[NSKeyedUnarchiver unarchiveObjectWithData:data_baby_now];
            if (baby_now!=nil) {
                baby=baby_now;
            }
            str_banner_img1=@"img_P_Header1";
            str_banner_img2=@"img_P_Header2";
            str_banner_img3=@"img_P_Header3";
            str_banner_img4=@"img_P_Header4";
            if ([parent.arr_baby count]>1) {
                rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
                //[rightButton setTitle:@"切换" forState:UIControlStateNormal];
                [rightButton setImage:[UIImage imageNamed:@"switch"] forState:UIControlStateNormal];
                [rightButton addTarget:self action:@selector(Switch:) forControlEvents:UIControlEventTouchUpInside];
                self.tabBarController.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:rightButton];
            }
            
            
            
            
            
            
            
            /*
             NSString *str_birthday=baby.birthday;
             NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
             [formatter setDateFormat:@"yyyy-MM-dd"];
             NSDate *date_birth=[formatter dateFromString:str_birthday];
             NSTimeInterval timeInterval=[date_birth timeIntervalSinceNow];
             timeInterval=-timeInterval;
             long temp_min=(timeInterval/60);
             long temp_hour=temp_min/60;
             long temp_day=temp_hour/24;
             long temp_year=temp_day/365;
             long temp_day_left=temp_day-temp_year*365;
             long temp_month=temp_day_left/30;
             */
            [_lbl_age setHidden:NO];
            _lbl_age.text=[self ClacAge];
            NSLog(@"相差");
            
        }
        else if (i_role==2) {
            teacher=[[TeacherInfo alloc]init];
            class_school=[[Class_School alloc]init];
            NSData *data_teacher=[[NSUserDefaults standardUserDefaults] objectForKey:@"user_teacher"];
            teacher=[NSKeyedUnarchiver unarchiveObjectWithData:data_teacher];
            _lbl_label2.text=teacher.dic_school.dutyname;
            if ([teacher.arr_class count]>1) {
                rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
                //[rightButton setTitle:@"切换" forState:UIControlStateNormal];
                [rightButton setImage:[UIImage imageNamed:@"switch"] forState:UIControlStateNormal];
                [rightButton addTarget:self action:@selector(Switch:) forControlEvents:UIControlEventTouchUpInside];
                self.tabBarController.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:rightButton];
            }
            else {
                class_school=[teacher.arr_class objectAtIndex:0];
                _lbl_label1.text=class_school.dutyname;
                _lbl_num.text=class_school.count;
            }
            
            [_lbl_age setHidden:YES];
            _lbl_topic.text=@"热点话题";
        }
        else if (i_role==3) {
            [_lbl_age setHidden:YES];
            
            _lbl_topic.text=@"热点话题";
        }
    
        UIImage *img_banner1=[UIImage imageNamed:str_banner_img1];
        UIImage *img_banner2=[UIImage imageNamed:str_banner_img2];
        UIImage *img_banner3=[UIImage imageNamed:str_banner_img3];
        UIImage *img_banner4=[UIImage imageNamed:str_banner_img4];
        arr_img_header =[NSArray arrayWithObjects:img_banner1,img_banner2,img_banner3,img_banner4, nil];
        
        
        
        NSString *str_nickname=_userInfo.nickname;
    
    if (baby_now==nil) {
        _lbl_name.text=str_nickname;
    }
    else {
        _lbl_name.text=[NSString stringWithFormat:@"%@%@",baby.name,@"妈妈"];
    }
    
        [_lbl_name sizeToFit];
        
        b_Launch=YES;
        
        NSLog(@"获取成功");
        
        [self.view setNeedsDisplay];
   
    i_Load++;
    
    
    
    
}

-(NSString*)ClacAge {
    NSString *str_birthday=baby.birthday;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date_birth=[formatter dateFromString:str_birthday];
    NSTimeInterval timeInterval=[date_birth timeIntervalSinceNow];
    timeInterval=-timeInterval;
    long temp_min=(timeInterval/60);
    long temp_hour=temp_min/60;
    long temp_day=temp_hour/24;
    long temp_year=temp_day/365;
    long temp_day_left=temp_day-temp_year*365;
    long temp_month=temp_day_left/30;
    NSString *str_age=[NSString stringWithFormat:@"%ld%@%ld%@",temp_year,@"岁",temp_month,@"个月"];
    return str_age;
}

-(void)viewDidAppear:(BOOL)animated {
    
    if (b_Launch==YES) {
        
        s_scrollView=[SDCycleScrollView cycleScrollViewWithFrame:_img_Header.frame imageNamesGroup:arr_img_header];
        
        [self.view addSubview:s_scrollView];
        
        [self.view sendSubviewToBack:s_scrollView];
        
        //家长
        if (i_role==0) {
            
            [self AddButton:i_role];
            [_bg_summary setHidden:YES];
                       b_Launch=NO;
            
        }
        //老师
        else if (i_role ==2) {
            [self AddButton:i_role];
             b_Launch=NO;
        }
        //园长
        else if (i_role==3) {
            
        }
    
    }
    else {
        NSLog(@"调整");
        if (rightButton!=nil) {
            self.tabBarController.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:rightButton];
        }

        UIViewController *RootVC=[self.navigationController.viewControllers objectAtIndex:0];
        if ([RootVC isKindOfClass:[FirstVc class]]) {
             UINavigationController *navMain=[[self storyboard] instantiateViewControllerWithIdentifier:@"navMain"];
             [UIApplication sharedApplication].keyWindow.rootViewController=navMain;
                   }
        else if ([RootVC isKindOfClass:[UITabBarController class]]) {
            
        }
        self.navigationController.navigationBar.topItem.title=@"新马良幼儿园";
        [s_scrollView setFrame:CGRectMake(0, 0, self.view.frame.size.width, _img_Header.frame.size.height+_img_Header.frame.origin.y)];
    
        
    }
    
    [hud hide:YES];
    

   
    
   

}

-(void)AddButton:(NSInteger)role {
    UIButton *btn_1=[[UIButton alloc]init];
    UIButton *btn_2=[[UIButton alloc]init];
    UIButton *btn_3=[[UIButton alloc]init];
    UIButton *btn_4=[[UIButton alloc]init];
    UIButton *btn_5=[[UIButton alloc]init];
    UIButton *btn_6=[[UIButton alloc]init];
    

    CGFloat i_fontsize=16;
    CGFloat btn_w=0.185*Width;
    if (iPhone5_5s || iPhone4_4s) {
        i_fontsize=14;
    }
    
    [btn_1 setFrame:CGRectMake(0.06441223832528*self.view.frame.size.width, 0.03170289855072*self.view.frame.size.height, btn_w, btn_w)];
    btn_1.titleLabel.font=[UIFont fontWithName:@"FZSEJW--GB1-0" size:i_fontsize];
    [btn_1 setTitleEdgeInsets:UIEdgeInsetsMake(80, 0, 0, 0)];
    
    
    [btn_2 setFrame:CGRectMake(0.4122383252818*self.view.frame.size.width, 0.03170289855072*self.view.frame.size.height, btn_w, btn_w)];
    btn_2.titleLabel.font=[UIFont fontWithName:@"FZSEJW--GB1-0" size:i_fontsize];
    [btn_2 setTitleEdgeInsets:UIEdgeInsetsMake(80, 0, 0, 0)];

    [btn_3 setFrame:CGRectMake(0.76167471819646*self.view.frame.size.width, 0.03170289855072*self.view.frame.size.height, btn_w, btn_w)];
    btn_3.titleLabel.font=[UIFont fontWithName:@"FZSEJW--GB1-0" size:i_fontsize];
    [btn_3 setTitleEdgeInsets:UIEdgeInsetsMake(80, 0, 0, 0)];
    
    
    [btn_4 setFrame:CGRectMake(0.06441223832528*self.view.frame.size.width, 0.21920289855072*self.view.frame.size.height, btn_w, btn_w)];
    btn_4.titleLabel.font=[UIFont fontWithName:@"FZSEJW--GB1-0" size:i_fontsize];
    [btn_4 setTitleEdgeInsets:UIEdgeInsetsMake(80, 0, 0, 0)];

    [btn_5 setFrame:CGRectMake(0.4122383252818*self.view.frame.size.width, 0.21920289855072*self.view.frame.size.height, btn_w, btn_w)];
    btn_5.titleLabel.font=[UIFont fontWithName:@"FZSEJW--GB1-0" size:i_fontsize];
    [btn_5 setTitleEdgeInsets:UIEdgeInsetsMake(80, 0, 0, 0)];


    
    //家长
    if (role==0) {
        
        [btn_1 setCenter:CGPointMake(self.view.frame.size.width*0.18, _bg_Content.frame.size.height*0.25)];
        [btn_1 setBackgroundImage:[UIImage imageNamed:@"p_btn1"] forState:UIControlStateNormal];
        [btn_1 setTitle:@"今日活动" forState:UIControlStateNormal];
        [btn_1 setTitleColor:[UIColor colorWithRed:240/255.0f green:92/255.0f blue:122/255.0f alpha:1] forState:UIControlStateNormal];
        [btn_1 addTarget:self action:@selector(btn_Click:) forControlEvents:UIControlEventTouchUpInside];
        
        [btn_2 setCenter:CGPointMake(self.view.frame.size.width*0.5, _bg_Content.frame.size.height*0.25)];
        [btn_2 setBackgroundImage:[UIImage imageNamed:@"p_btn2"] forState:UIControlStateNormal];
        [btn_2 setTitle:@"今日食谱" forState:UIControlStateNormal];
        [btn_2 setTitleColor:[UIColor colorWithRed:91/255.0f green:176/255.0f blue:85/255.0f alpha:1] forState:UIControlStateNormal];
        [btn_2 addTarget:self action:@selector(btn_Click:) forControlEvents:UIControlEventTouchUpInside];
        
        
        [btn_3 setCenter:CGPointMake(self.view.frame.size.width*0.82, _bg_Content.frame.size.height*0.25)];
        [btn_3 setBackgroundImage:[UIImage imageNamed:@"p_btn3"] forState:UIControlStateNormal];
        [btn_3 setTitle:@"家园互动" forState:UIControlStateNormal];
        [btn_3 setTitleColor:[UIColor colorWithRed:124/255.0f green:162/255.0f blue:232/255.0f alpha:1] forState:UIControlStateNormal];
        [btn_3 addTarget:self action:@selector(btn_Click:) forControlEvents:UIControlEventTouchUpInside];

        
       
        [btn_4 setCenter:CGPointMake(self.view.frame.size.width*0.18, _bg_Content.frame.size.height*0.75)];
        [btn_4 setBackgroundImage:[UIImage imageNamed:@"p_btn4"] forState:UIControlStateNormal];
        [btn_4 setTitle:@"体智发展" forState:UIControlStateNormal];
        [btn_4 setTitleColor:[UIColor colorWithRed:255/255.0f green:181/255.0f blue:30/255.0f alpha:1] forState:UIControlStateNormal];
        [btn_4 addTarget:self action:@selector(btn_Click:) forControlEvents:UIControlEventTouchUpInside];

       
        
        
        [btn_5 setCenter:CGPointMake(self.view.frame.size.width*0.5, _bg_Content.frame.size.height*0.75)];
        [btn_5 setBackgroundImage:[UIImage imageNamed:@"p_btn5"] forState:UIControlStateNormal];
        [btn_5 setTitle:@"相册" forState:UIControlStateNormal];
        [btn_5 setTitleColor:[UIColor colorWithRed:216/255.0f green:142/255.0f blue:198/255.0f alpha:1] forState:UIControlStateNormal];
        [btn_5 setTag:5];
        [btn_5 addTarget:self action:@selector(Albumn:) forControlEvents:UIControlEventTouchUpInside];
        
        
        [btn_6 setFrame:CGRectMake(0.76167471819646*self.view.frame.size.width, 0.21920289855072*self.view.frame.size.height, btn_w, btn_w)];
        [btn_6 setCenter:CGPointMake(self.view.frame.size.width*0.82, _bg_Content.frame.size.height*0.75)];
        [btn_6 setBackgroundImage:[UIImage imageNamed:@"p_btn6"] forState:UIControlStateNormal];
        [btn_6 setTag:6];
        [btn_6 setTitle:@"视频" forState:UIControlStateNormal];
        [btn_6 setTitleColor:[UIColor colorWithRed:250/255.0f green:208/255.0f blue:52/255.0f alpha:1] forState:UIControlStateNormal];
        btn_6.titleLabel.font=[UIFont fontWithName:@"FZSEJW--GB1-0" size:i_fontsize];
        [btn_6 setTitleEdgeInsets:UIEdgeInsetsMake(80, 0, 0, 0)];

        [btn_6 addTarget:self action:@selector(Albumn:) forControlEvents:UIControlEventTouchUpInside];
        
       
        
        
        [_bg_Content addSubview:btn_1];
        [_bg_Content addSubview:btn_2];
        [_bg_Content addSubview:btn_3];
        [_bg_Content addSubview:btn_4];
        [_bg_Content addSubview:btn_5];
        [_bg_Content addSubview:btn_6];
        
        
          }
    //老师
    else if (i_role==2) {
        [btn_1 setCenter:CGPointMake(self.view.frame.size.width*0.18, _bg_Content.frame.size.height*0.4)];
        [btn_1 setBackgroundImage:[UIImage imageNamed:@"t_btn1"] forState:UIControlStateNormal];
        [btn_1 setTitle:@"发通知" forState:UIControlStateNormal];
        [btn_1 setTitleColor:[UIColor colorWithRed:238/255.0f green:104/255.0f blue:72/255.0f alpha:1] forState:UIControlStateNormal];
        [btn_1 addTarget:self action:@selector(btn_Click:) forControlEvents:UIControlEventTouchUpInside];
        
        [btn_2 setCenter:CGPointMake(self.view.frame.size.width*0.5, _bg_Content.frame.size.height*0.4)];
        [btn_2 setBackgroundImage:[UIImage imageNamed:@"t_btn2"] forState:UIControlStateNormal];
        [btn_2 setTitle:@"发照片" forState:UIControlStateNormal];
        [btn_2 setTitleColor:[UIColor colorWithRed:221/255.0f green:143/255.0f blue:196/255.0f alpha:1] forState:UIControlStateNormal];
        [btn_2 setTag:5];
        [btn_2 addTarget:self action:@selector(Albumn:) forControlEvents:UIControlEventTouchUpInside];
        
        
        [btn_3 setCenter:CGPointMake(self.view.frame.size.width*0.82, _bg_Content.frame.size.height*0.4)];
        [btn_3 setBackgroundImage:[UIImage imageNamed:@"t_btn3"] forState:UIControlStateNormal];
        [btn_3 setTitle:@"发视频" forState:UIControlStateNormal];
        [btn_3 setTitleColor:[UIColor colorWithRed:255/255.0f green:181/255.0f blue:56/255.0f alpha:1] forState:UIControlStateNormal];
        [btn_3 setTag:6];
        [btn_3 addTarget:self action:@selector(Albumn:) forControlEvents:UIControlEventTouchUpInside];
        
        [btn_4 setCenter:CGPointMake(self.view.frame.size.width*0.18, _bg_Content.frame.size.height*0.8)];
        [btn_4 setBackgroundImage:[UIImage imageNamed:@"t_btn4"] forState:UIControlStateNormal];
        [btn_4 setTitle:@"家园互动" forState:UIControlStateNormal];
        [btn_4 setTitleColor:[UIColor colorWithRed:116/255.0f green:163/255.0f blue:229/255.0f alpha:1] forState:UIControlStateNormal];
        [btn_4 addTarget:self action:@selector(btn_Click:) forControlEvents:UIControlEventTouchUpInside];
        
        [btn_5 setCenter:CGPointMake(self.view.frame.size.width*0.5, _bg_Content.frame.size.height*0.8)];
        [btn_5 setBackgroundImage:[UIImage imageNamed:@"t_btn5"] forState:UIControlStateNormal];
        [btn_5 setTitle:@"班级空间" forState:UIControlStateNormal];
        [btn_5 setTitleColor:[UIColor colorWithRed:216/255.0f green:193/255.0f blue:115/255.0f alpha:1] forState:UIControlStateNormal];
        [btn_5 addTarget:self action:@selector(btn_Click:) forControlEvents:UIControlEventTouchUpInside];
        
        [_bg_Content addSubview:btn_1];
        [_bg_Content addSubview:btn_2];
        [_bg_Content addSubview:btn_3];
        [_bg_Content addSubview:btn_4];
        [_bg_Content addSubview:btn_5];
    }
    //园长
    else if (i_role==3) {
        [btn_1 setCenter:CGPointMake(self.view.frame.size.width*0.18, _bg_Content.frame.size.height*0.4)];
        [btn_1 setBackgroundImage:[UIImage imageNamed:@"h_btn1"] forState:UIControlStateNormal];
        [btn_1 setTitle:@"发通知" forState:UIControlStateNormal];
        [btn_1 setTitleColor:[UIColor colorWithRed:238/255.0f green:104/255.0f blue:72/255.0f alpha:1] forState:UIControlStateNormal];
        [btn_1 addTarget:self action:@selector(btn_Click:) forControlEvents:UIControlEventTouchUpInside];
        
        [btn_2 setCenter:CGPointMake(self.view.frame.size.width*0.5, _bg_Content.frame.size.height*0.4)];
        [btn_2 setBackgroundImage:[UIImage imageNamed:@"h_btn2"] forState:UIControlStateNormal];
        [btn_2 setTitle:@"相册" forState:UIControlStateNormal];
        [btn_2 setTitleColor:[UIColor colorWithRed:221/255.0f green:143/255.0f blue:196/255.0f alpha:1] forState:UIControlStateNormal];
        [btn_2 setTag:5];
        [btn_2 addTarget:self action:@selector(Albumn:) forControlEvents:UIControlEventTouchUpInside];
        
        
        [btn_3 setCenter:CGPointMake(self.view.frame.size.width*0.82, _bg_Content.frame.size.height*0.4)];
        [btn_3 setBackgroundImage:[UIImage imageNamed:@"h_btn3"] forState:UIControlStateNormal];
        [btn_3 setTitle:@"视频" forState:UIControlStateNormal];
        [btn_3 setTitleColor:[UIColor colorWithRed:255/255.0f green:181/255.0f blue:56/255.0f alpha:1] forState:UIControlStateNormal];
        [btn_3 setTag:6];
        [btn_3 setTitleColor:[UIColor colorWithRed:250/255.0f green:208/255.0f blue:52/255.0f alpha:1] forState:UIControlStateNormal];
        [btn_3 addTarget:self action:@selector(btn_Click:) forControlEvents:UIControlEventTouchUpInside];
        
        [btn_4 setCenter:CGPointMake(self.view.frame.size.width*0.18, _bg_Content.frame.size.height*0.8)];
        [btn_4 setBackgroundImage:[UIImage imageNamed:@"h_btn4"] forState:UIControlStateNormal];
        [btn_4 setTitle:@"学校空间" forState:UIControlStateNormal];
        [btn_4 setTitleColor:[UIColor colorWithRed:116/255.0f green:163/255.0f blue:229/255.0f alpha:1] forState:UIControlStateNormal];
        [btn_4 addTarget:self action:@selector(btn_Click:) forControlEvents:UIControlEventTouchUpInside];
        
        [btn_5 setCenter:CGPointMake(self.view.frame.size.width*0.5, _bg_Content.frame.size.height*0.8)];
        [btn_5 setBackgroundImage:[UIImage imageNamed:@"h_btn5"] forState:UIControlStateNormal];
        [btn_5 setTitle:@"家园互动" forState:UIControlStateNormal];
        [btn_5 setTitleColor:[UIColor colorWithRed:216/255.0f green:193/255.0f blue:115/255.0f alpha:1] forState:UIControlStateNormal];
        [btn_5 addTarget:self action:@selector(btn_Click:) forControlEvents:UIControlEventTouchUpInside];
        
        [_bg_Content addSubview:btn_1];
        [_bg_Content addSubview:btn_2];
        [_bg_Content addSubview:btn_3];
        [_bg_Content addSubview:btn_4];
        [_bg_Content addSubview:btn_5];
    }
   
}

-(void)Albumn:(UIButton*)sender {
   // NSString *str_url=@"";
    NSString *str_category=@"";
    if (sender.tag==5) {
        
        str_category=@"相册";
    }
    else if (sender.tag==6) {
        str_category=@"视频";
    }
  //  NSString *str_id=_userInfo.str_id;
  //  NSString *str_role=[NSString stringWithFormat:@"%ld",(long)i_role];
 //   str_url=[NSString stringWithFormat:@"%@?%@=%@&%@=%@",str_url,@"userid",str_id,@"role",str_role];
    WebBrowserTest *webbrowser = [[self storyboard] instantiateViewControllerWithIdentifier:@"WebBrowser"];
    webbrowser.str_category=str_category;
    if (baby!=nil) {
        webbrowser.str_xuejihao=baby.xuejihao;
    }
   // webbrowser.str_url=str_url;
    
    UINavigationController *navi1=[[UINavigationController alloc]initWithRootViewController:self];
    [UIApplication sharedApplication].keyWindow.rootViewController=navi1;
    
    
    /*
    [self presentViewController:webbrowser animated:YES completion:^{
       // [self dismissViewControllerAnimated:YES completion:nil];
    }];
     */
   // [self.navigationController presentViewController:webbrowser animated:YES completion:nil];
    [navi1 pushViewController:webbrowser animated:YES];
}

-(void)Switch:(UIButton*)sender {
    NSLog(@"切换");
    tb_select *tb_select = [[self storyboard] instantiateViewControllerWithIdentifier:@"TB_SELECT"];
    if (i_role==0) {
        tb_select.arr_baby=parent.arr_baby;
    }
    else if (i_role==2) {
        tb_select.arr_class=teacher.arr_class;
    }
    tb_select.delegate=self;
    [self.navigationController pushViewController:tb_select animated:YES];
}

-(void)PassValue:(Baby *)v_baby childvalue:(Class_School *)v_class_child refresh:(BOOL)b_refresh {
     NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (v_baby!=nil && v_class_child==nil) {
        NSData *data=[NSKeyedArchiver archivedDataWithRootObject:v_baby];
        [defaults setObject:data forKey:@"baby_now"];
        _lbl_name.text=[NSString stringWithFormat:@"%@%@",v_baby.name,@"妈妈"];
        baby=v_baby;
        _lbl_age.text=[self ClacAge];
    }
    else if (v_baby==nil && v_class_child!=nil) {
        NSData *data=[NSKeyedArchiver archivedDataWithRootObject:v_class_child];
        [defaults setObject:data forKey:@"class_now"];
    }
     [defaults synchronize];
    
   
   // [self.view setNeedsDisplay];
}

-(void)btn_Click:(UIButton*)btn {
    StayTuneVC *vc_staytune=[[self storyboard] instantiateViewControllerWithIdentifier:@"view_staytune"];
    [self.navigationController pushViewController:vc_staytune animated:YES];

}

@end
