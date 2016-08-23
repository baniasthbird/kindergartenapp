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

@implementation FirstVc {
    
    NSInteger i_role;
    
    NSMutableDictionary *dic_pic;
    
    NSMutableDictionary *dic_video;
    
    UIView *bgView1;
    
    UIView *bgView2;
    
    UIView *bgView3;
    
    BaseFunc *baseFunc;
}


-(void)viewDidLoad {
    
    
    self.navigationController.navigationBar.topItem.title=@"新马良幼儿园";
   // UIView *view=
 //   self.navigationController.navigationBar.topItem.titleView.backgroundColor=[UIColor colorWithRed:226/255.0f green:101/255.0f blue:51/255.0f alpha:1];
    //self.navigationController.navigationBar.backgroundColor=[UIColor colorWithRed:226/255.0f green:101/255.0f blue:51/255.0f alpha:1];
    //self.view.=@"新马良幼儿园";
       
    NSData *data=[[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
   _userInfo=[[UserInfo alloc]init];
   _userInfo=[NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    i_role=[_userInfo.str_role integerValue];
    
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
    if (role==0) {
        [btn_1 setFrame:CGRectMake(0.06441223832528*self.view.frame.size.width, 0.03170289855072*self.view.frame.size.height, 0.18518518518519*self.view.frame.size.width, 0.18518518518519*self.view.frame.size.width)];
        [btn_1 setCenter:CGPointMake(self.view.frame.size.width*0.18, bgView1.frame.size.height*0.25)];
        [btn_1 setBackgroundImage:[UIImage imageNamed:@"p_btn1"] forState:UIControlStateNormal];
        [btn_1 setTitle:@"今日活动" forState:UIControlStateNormal];
        
      
        [btn_2 setFrame:CGRectMake(0.4122383252818*self.view.frame.size.width, 0.03170289855072*self.view.frame.size.height, 0.18518518518519*self.view.frame.size.width, 0.18518518518519*self.view.frame.size.width)];
        [btn_2 setCenter:CGPointMake(self.view.frame.size.width*0.5, bgView1.frame.size.height*0.25)];
        [btn_2 setBackgroundImage:[UIImage imageNamed:@"p_btn2"] forState:UIControlStateNormal];
        [btn_2 setTitle:@"今日食谱" forState:UIControlStateNormal];
        
        [btn_3 setFrame:CGRectMake(0.76167471819646*self.view.frame.size.width, 0.03170289855072*self.view.frame.size.height, 0.18518518518519*self.view.frame.size.width, 0.18518518518519*self.view.frame.size.width)];
        [btn_3 setCenter:CGPointMake(self.view.frame.size.width*0.82, bgView1.frame.size.height*0.25)];
        [btn_3 setBackgroundImage:[UIImage imageNamed:@"p_btn3"] forState:UIControlStateNormal];
        [btn_3 setTitle:@"家园互动" forState:UIControlStateNormal];
        
        [btn_4 setFrame:CGRectMake(0.06441223832528*self.view.frame.size.width, 0.21920289855072*self.view.frame.size.height, 0.18518518518519*self.view.frame.size.width, 0.18518518518519*self.view.frame.size.width)];
        [btn_4 setCenter:CGPointMake(self.view.frame.size.width*0.18, bgView1.frame.size.height*0.75)];
        [btn_4 setBackgroundImage:[UIImage imageNamed:@"p_btn4"] forState:UIControlStateNormal];
        [btn_4 setTitle:@"体智发展" forState:UIControlStateNormal];
        
        [btn_5 setFrame:CGRectMake(0.4122383252818*self.view.frame.size.width, 0.21920289855072*self.view.frame.size.height, 0.18518518518519*self.view.frame.size.width, 0.18518518518519*self.view.frame.size.width)];
        [btn_5 setCenter:CGPointMake(self.view.frame.size.width*0.5, bgView1.frame.size.height*0.75)];
        [btn_5 setBackgroundImage:[UIImage imageNamed:@"p_btn5"] forState:UIControlStateNormal];
        [btn_5 setTitle:@"相册" forState:UIControlStateNormal];
        btn_5.tag=5;
        [btn_5 addTarget:self action:@selector(Albumn:) forControlEvents:UIControlEventTouchUpInside];
        
        [btn_6 setFrame:CGRectMake(0.76167471819646*self.view.frame.size.width, 0.21920289855072*self.view.frame.size.height, 0.18518518518519*self.view.frame.size.width, 0.18518518518519*self.view.frame.size.width)];
        [btn_6 setCenter:CGPointMake(self.view.frame.size.width*0.82, bgView1.frame.size.height*0.75)];
        [btn_6 setBackgroundImage:[UIImage imageNamed:@"p_btn6"] forState:UIControlStateNormal];
        btn_5.tag=6;
        [btn_6 setTitle:@"视频" forState:UIControlStateNormal];
        [btn_6 addTarget:self action:@selector(Albumn:) forControlEvents:UIControlEventTouchUpInside];
        
        [bgView1 addSubview:btn_1];
        [bgView1 addSubview:btn_2];
        [bgView1 addSubview:btn_3];
        [bgView1 addSubview:btn_4];
        [bgView1 addSubview:btn_5];
        [bgView1 addSubview:btn_6];
    }
   
}

-(void)Albumn:(UIButton*)sender {
    NSString *str_url=@"";
    if ([sender.titleLabel.text isEqualToString:@"相册"]) {
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
