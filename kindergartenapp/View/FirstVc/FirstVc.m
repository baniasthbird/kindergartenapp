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
#import "ParentInfo.h"
#import "TeacherInfo.h"

@implementation FirstVc {
    
    NSInteger i_role;
    
    NSMutableDictionary *dic_pic;
    
    NSMutableDictionary *dic_video;
    
    UIView *bgView1;
    
    UIView *bgView2;
    
    UIView *bgView3;
    
    BaseFunc *baseFunc;
    
    ParentInfo *parent;
    
    TeacherInfo *teacher;
}


-(void)viewDidLoad {
    
    self.tabBarItem.image=[[UIImage imageNamed:@"first"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.tabBarItem.selectedImage=[[UIImage imageNamed:@"first_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    self.navigationController.navigationBar.topItem.title=@"新马良幼儿园";
   // UIView *view=
 //   self.navigationController.navigationBar.topItem.titleView.backgroundColor=[UIColor colorWithRed:226/255.0f green:101/255.0f blue:51/255.0f alpha:1];
    //self.navigationController.navigationBar.backgroundColor=[UIColor colorWithRed:226/255.0f green:101/255.0f blue:51/255.0f alpha:1];
    //self.view.=@"新马良幼儿园";
       
    NSData *data=[[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
   _userInfo=[[UserInfo alloc]init];
   _userInfo=[NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    i_role=[_userInfo.str_role integerValue];
    
    if (i_role==0) {
        parent=[[ParentInfo alloc]init];
        NSData *data_parent=[[NSUserDefaults standardUserDefaults] objectForKey:@"user_parent"];
        parent=[NSKeyedUnarchiver unarchiveObjectWithData:data_parent];
    }
    else if (i_role==2) {
        teacher=[[TeacherInfo alloc]init];
        NSData *data_teacher=[[NSUserDefaults standardUserDefaults] objectForKey:@"user_teacher"];
        teacher=[NSKeyedUnarchiver unarchiveObjectWithData:data_teacher];
    }
    
    
    baseFunc =[[BaseFunc alloc]init];
    
    NSMutableArray *arr_menus=_userInfo.arr_menus;
    dic_pic=[NSMutableDictionary dictionary];
    
    for (int i=0;i<[arr_menus count];i++) {
        NSDictionary *dic_menu_pic=[arr_menus objectAtIndex:i];
        NSString *str_menuname=[baseFunc GetValueFromDic:dic_menu_pic key:@"menuname"];
        NSString *str_menuurl=[baseFunc GetValueFromDic:dic_menu_pic key:@"menuurl"];
        NSString *str_remark=[baseFunc GetValueFromDic:dic_menu_pic key:@"remark"];
        if ([str_menuname isEqualToString:@"相册"]) {
            dic_pic[@"name"]=str_menuname;
            dic_pic[@"url"]=str_menuurl;
            dic_pic[@"remark"]=str_remark;
        }
        else if ([str_menuname isEqualToString:@"视频"]) {
            dic_video[@"name"]=str_menuname;
            dic_video[@"url"]=str_menuurl;
            dic_video[@"remark"]=str_remark;
        }
    }
    
    NSString *str_nickname=_userInfo.nickname;
    
    _lbl_name.text=str_nickname;
    [_lbl_name sizeToFit];
    
    
    NSArray *familyNames = [UIFont familyNames];
    for( NSString *familyName in familyNames )
    {
        NSArray *fontNames = [UIFont fontNamesForFamilyName:familyName];
        for( NSString *fontName in fontNames )
        {
            printf( "\tFont: %s \n", [fontName UTF8String] );
        }
    }
    
    
    NSLog(@"获取成功");
    
}

-(void)viewDidAppear:(BOOL)animated {
    
    //家长
    if (i_role==0) {
        CGFloat y_bgView1=_bg_Discribe.frame.origin.y+_bg_Discribe.frame.size.height;
        bgView1=[[UIView alloc]init];
        bgView1.backgroundColor=[UIColor colorWithRed:254/255.0f green:250/255.0f blue:236/255.0f alpha:1];
        [bgView1 setFrame:CGRectMake(0, y_bgView1, self.view.frame.size.width, self.view.frame.size.height*0.38315217391304)];
        [self AddButton:i_role];
        [bgView1 sizeToFit];
        
        
        CGFloat y_bgView2=bgView1.frame.origin.y+bgView1.frame.size.height;
        bgView2=[[UIView alloc]init];
        [bgView2 setFrame:CGRectMake(0, y_bgView2, self.view.frame.size.width, 0.0606884057971*self.view.frame.size.height)];
        bgView2.backgroundColor=[UIColor whiteColor];
        UILabel *lbl_title=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, bgView2.frame.size.height)];
        lbl_title.text=@"最新话题";
        lbl_title.textAlignment=NSTextAlignmentCenter;
        lbl_title.font=[UIFont fontWithName:@"FZSEJW--GB1-0" size:12];
        lbl_title.textColor=[UIColor colorWithRed:255/255.0f green:78/255.0f blue:0 alpha:1];
        
        UIView *line_left=[[UIView alloc]initWithFrame:CGRectMake(10, bgView2.frame.size.height/2, self.view.frame.size.width/2-45, 1)];
        line_left.backgroundColor=[UIColor colorWithRed:240/255.0f green:240/255.0f blue:240/255.0f alpha:1];
        
        UIView *line_right=[[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2+35, bgView2.frame.size.height/2, self.view.frame.size.width/2-100, 1)];
        line_right.backgroundColor=[UIColor colorWithRed:240/255.0f green:240/255.0f blue:240/255.0f alpha:1];
        
        UILabel *lbl_more=[[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width-80, 0, 80, bgView2.frame.size.height)];
        lbl_more.text=@"查看更多";
        lbl_more.textAlignment=NSTextAlignmentCenter;
        lbl_more.font=[UIFont systemFontOfSize:12];
        lbl_more.textColor=[UIColor colorWithRed:234/255.0f green:202/255.0f blue:160/255.0f alpha:1];
        
        [bgView2 addSubview:lbl_title];
        [bgView2 addSubview:line_left];
        [bgView2 addSubview:line_right];
        [bgView2 addSubview:lbl_more];
        [bgView2 sizeToFit];
        
        
        CGFloat y_bgView3=bgView2.frame.origin.y+bgView2.frame.size.height;
        bgView3=[[UIView alloc]init];
        [bgView3 setFrame:CGRectMake(0, y_bgView3, self.view.frame.size.width, 0.07789855072464*self.view.frame.size.height)];
        //UIColor *bgColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bottom"]];
        //bgView3.backgroundColor=bgColor;
        UIImage *img=[UIImage imageNamed:@"bottom"];

        UIImageView *img_bg=[[UIImageView alloc]initWithImage:img];
        
        img_bg.contentMode=UIViewContentModeScaleAspectFit;
        img_bg.frame=bgView3.frame;
        [self.view addSubview:img_bg];
        [bgView3 sizeToFit];

        [self.view addSubview:bgView1];
        [self.view addSubview:bgView2];
        [self.view addSubview:bgView3];
        [self.view setNeedsDisplay];
        
    }
    //老师
    else if (i_role ==2) {
        
    }
    //园长
    else if (i_role==3) {
        
    }

    
   

}

-(void)AddButton:(NSInteger)role {
    UIButton *btn_1=[[UIButton alloc]init];
    UIButton *btn_2=[[UIButton alloc]init];
    UIButton *btn_3=[[UIButton alloc]init];
    UIButton *btn_4=[[UIButton alloc]init];
    UIButton *btn_5=[[UIButton alloc]init];
    UIButton *btn_6=[[UIButton alloc]init];
    //家长
    if (role==0) {
        [btn_1 setFrame:CGRectMake(0.06441223832528*self.view.frame.size.width, 0.03170289855072*self.view.frame.size.height, 0.18518518518519*self.view.frame.size.width, 0.18518518518519*self.view.frame.size.width)];
        [btn_1 setCenter:CGPointMake(self.view.frame.size.width*0.18, bgView1.frame.size.height*0.25)];
        [btn_1 setBackgroundImage:[UIImage imageNamed:@"p_btn1"] forState:UIControlStateNormal];
        [btn_1 setTitle:@"今日活动" forState:UIControlStateNormal];
        [btn_1 setTitleColor:[UIColor colorWithRed:240/255.0f green:92/255.0f blue:122/255.0f alpha:1] forState:UIControlStateNormal];
        btn_1.titleLabel.font=[UIFont fontWithName:@"FZSEJW--GB1-0" size:16];
        [btn_1 setTitleEdgeInsets:UIEdgeInsetsMake(75, 0, 0, 0)];
       
        
      
        [btn_2 setFrame:CGRectMake(0.4122383252818*self.view.frame.size.width, 0.03170289855072*self.view.frame.size.height, 0.18518518518519*self.view.frame.size.width, 0.18518518518519*self.view.frame.size.width)];
        [btn_2 setCenter:CGPointMake(self.view.frame.size.width*0.5, bgView1.frame.size.height*0.25)];
        [btn_2 setBackgroundImage:[UIImage imageNamed:@"p_btn2"] forState:UIControlStateNormal];
        [btn_2 setTitle:@"今日食谱" forState:UIControlStateNormal];
        [btn_2 setTitleColor:[UIColor colorWithRed:91/255.0f green:176/255.0f blue:85/255.0f alpha:1] forState:UIControlStateNormal];
        btn_2.titleLabel.font=[UIFont fontWithName:@"FZSEJW--GB1-0" size:16];
        [btn_2 setTitleEdgeInsets:UIEdgeInsetsMake(75, 0, 0, 0)];

        
        [btn_3 setFrame:CGRectMake(0.76167471819646*self.view.frame.size.width, 0.03170289855072*self.view.frame.size.height, 0.18518518518519*self.view.frame.size.width, 0.18518518518519*self.view.frame.size.width)];
        [btn_3 setCenter:CGPointMake(self.view.frame.size.width*0.82, bgView1.frame.size.height*0.25)];
        [btn_3 setBackgroundImage:[UIImage imageNamed:@"p_btn3"] forState:UIControlStateNormal];
        [btn_3 setTitle:@"家园互动" forState:UIControlStateNormal];
        [btn_3 setTitleColor:[UIColor colorWithRed:124/255.0f green:162/255.0f blue:232/255.0f alpha:1] forState:UIControlStateNormal];
        btn_3.titleLabel.font=[UIFont fontWithName:@"FZSEJW--GB1-0" size:16];
        [btn_3 setTitleEdgeInsets:UIEdgeInsetsMake(75, 0, 0, 0)];
        
        [btn_4 setFrame:CGRectMake(0.06441223832528*self.view.frame.size.width, 0.21920289855072*self.view.frame.size.height, 0.18518518518519*self.view.frame.size.width, 0.18518518518519*self.view.frame.size.width)];
        [btn_4 setCenter:CGPointMake(self.view.frame.size.width*0.18, bgView1.frame.size.height*0.75)];
        [btn_4 setBackgroundImage:[UIImage imageNamed:@"p_btn4"] forState:UIControlStateNormal];
        [btn_4 setTitle:@"体智发展" forState:UIControlStateNormal];
        [btn_4 setBackgroundColor:[UIColor whiteColor]];
        [btn_4 setTitleColor:[UIColor colorWithRed:255/255.0f green:181/255.0f blue:30/255.0f alpha:1] forState:UIControlStateNormal];
        btn_4.titleLabel.font=[UIFont fontWithName:@"FZSEJW--GB1-0" size:16];
        [btn_4 setTitleEdgeInsets:UIEdgeInsetsMake(75, 0, 0, 0)];

        
        [btn_5 setFrame:CGRectMake(0.4122383252818*self.view.frame.size.width, 0.21920289855072*self.view.frame.size.height, 0.18518518518519*self.view.frame.size.width, 0.18518518518519*self.view.frame.size.width)];
        [btn_5 setCenter:CGPointMake(self.view.frame.size.width*0.5, bgView1.frame.size.height*0.75)];
        [btn_5 setBackgroundImage:[UIImage imageNamed:@"p_btn5"] forState:UIControlStateNormal];
        [btn_5 setTitle:@"相册" forState:UIControlStateNormal];
        [btn_5 setTitleColor:[UIColor colorWithRed:216/255.0f green:142/255.0f blue:198/255.0f alpha:1] forState:UIControlStateNormal];
        btn_5.titleLabel.font=[UIFont fontWithName:@"FZSEJW--GB1-0" size:16];
        [btn_5 setTitleEdgeInsets:UIEdgeInsetsMake(75, 0, 0, 0)];
        [btn_5 setTag:5];
        [btn_5 addTarget:self action:@selector(Albumn:) forControlEvents:UIControlEventTouchUpInside];
        
        [btn_6 setFrame:CGRectMake(0.76167471819646*self.view.frame.size.width, 0.21920289855072*self.view.frame.size.height, 0.18518518518519*self.view.frame.size.width, 0.18518518518519*self.view.frame.size.width)];
        [btn_6 setCenter:CGPointMake(self.view.frame.size.width*0.82, bgView1.frame.size.height*0.75)];
        [btn_6 setBackgroundImage:[UIImage imageNamed:@"p_btn6"] forState:UIControlStateNormal];
        [btn_6 setTag:6];
        [btn_6 setTitle:@"视频" forState:UIControlStateNormal];
        [btn_6 setTitleColor:[UIColor colorWithRed:250/255.0f green:208/255.0f blue:52/255.0f alpha:1] forState:UIControlStateNormal];
        btn_6.titleLabel.font=[UIFont fontWithName:@"FZSEJW--GB1-0" size:16];
        [btn_6 setTitleEdgeInsets:UIEdgeInsetsMake(75, 0, 0, 0)];

        [btn_6 addTarget:self action:@selector(Albumn:) forControlEvents:UIControlEventTouchUpInside];
        
        [bgView1 addSubview:btn_1];
        [bgView1 addSubview:btn_2];
        [bgView1 addSubview:btn_3];
        [bgView1 addSubview:btn_4];
        [bgView1 addSubview:btn_5];
        [bgView1 addSubview:btn_6];
        
        
          }
    //老师
    else if (i_role==2) {
        
    }
    //园长
    else if (i_role==3) {
        
    }
   
}

-(void)Albumn:(UIButton*)sender {
    NSString *str_url=@"";
    if (sender.tag==5) {
        str_url=[dic_pic objectForKey:@"url"];
    }
    else if (sender.tag==6) {
        str_url=[dic_video objectForKey:@"url"];
    }
    NSString *str_id=_userInfo.str_id;
    NSString *str_role=[NSString stringWithFormat:@"%ld",(long)i_role];
    str_url=[NSString stringWithFormat:@"%@?%@=%@&%@=%@",str_url,@"userid",str_id,@"role",str_role];
    WebBrowserTest *vc=[[WebBrowserTest alloc]init];
    vc.str_url=str_url;
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end
