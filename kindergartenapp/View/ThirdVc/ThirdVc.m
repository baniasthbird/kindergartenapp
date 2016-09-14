//
//  ThirdVc.m
//  kindergartenapp
//
//  Created by zr-mac on 16/8/21.
//  Copyright © 2016年 zr-mac. All rights reserved.
//

#import "ThirdVc.h"
#import "StayTuneVC.h"

@implementation ThirdVc {
    NSInteger i_role;
    
    __weak IBOutlet UIButton *btn_1;
    
    __weak IBOutlet UIButton *btn_2;
    
    __weak IBOutlet UIButton *btn_3;
    
    __weak IBOutlet UIButton *btn_4;
    
    __weak IBOutlet UIButton *btn_5;
    
    __weak IBOutlet UIButton *btn_6;
    
    __weak IBOutlet UIButton *btn_7;
    
    __weak IBOutlet UIButton *btn_8;
    
    __weak IBOutlet UIButton *btn_9;
    
}

-(void)viewDidLoad {
    self.tabBarItem.image=[[UIImage imageNamed:@"third"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.tabBarItem.selectedImage=[[UIImage imageNamed:@"third_selcted"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    self.navigationController.navigationBar.topItem.title=@"马良宝";
    
    self.tabBarController.navigationItem.rightBarButtonItem=nil;
    
    
    NSData *data=[[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
    _userInfo=[[UserInfo alloc]init];
    _userInfo=[NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    i_role=[_userInfo.str_role integerValue];
    
    CGFloat i_fontsize=16;
    if (iPhone5_5s || iPhone4_4s) {
        i_fontsize=14;
    }

    
    if (i_role==0) {
        
    }
    else if (i_role==2 || i_role==3) {
        
        [btn_1 setBackgroundImage:[UIImage imageNamed:@"btn_3_10"] forState:UIControlStateNormal];
        [btn_1 setTitle:@"通知管理" forState:UIControlStateNormal];
        [btn_1 setTitleColor:[UIColor colorWithRed:218/255.0f green:97/255.0f blue:60/255.0f alpha:1] forState:UIControlStateNormal];
        [btn_2 setBackgroundImage:[UIImage imageNamed:@"btn_3_1"] forState:UIControlStateNormal];
        [btn_2 setTitle:@"今日活动" forState:UIControlStateNormal];
        [btn_2 setTitleColor:[UIColor colorWithRed:213/255.0f green:82/255.0f blue:108/255.0f alpha:1] forState:UIControlStateNormal];
        [btn_3 setBackgroundImage:[UIImage imageNamed:@"btn_3_2"] forState:UIControlStateNormal];
        [btn_3 setTitle:@"今日食谱" forState:UIControlStateNormal];
        [btn_3 setTitleColor:[UIColor colorWithRed:89/255.0f green:171/255.0f blue:84/255.0f alpha:1] forState:UIControlStateNormal];
        [btn_4 setBackgroundImage:[UIImage imageNamed:@"btn_3_4"] forState:UIControlStateNormal];
        [btn_4 setTitle:@"体智发展" forState:UIControlStateNormal];
        [btn_4 setTitleColor:[UIColor colorWithRed:254/255.0f green:178/255.0f blue:55/255.0f alpha:1] forState:UIControlStateNormal];
        [btn_5 setBackgroundImage:[UIImage imageNamed:@"btn_3_3"] forState:UIControlStateNormal];
        [btn_5 setTitle:@"家园互动" forState:UIControlStateNormal];
        [btn_5 setTitleColor:[UIColor colorWithRed:124/255.0f green:163/255.0f blue:232/255.0f alpha:1] forState:UIControlStateNormal];
        [btn_6 setBackgroundImage:[UIImage imageNamed:@"btn_3_5"] forState:UIControlStateNormal];
        [btn_6 setTitle:@"相册管理" forState:UIControlStateNormal];
        [btn_6 setTitleColor:[UIColor colorWithRed:216/255.0f green:142/255.0f blue:198/255.0f alpha:1] forState:UIControlStateNormal];
        [btn_7 setBackgroundImage:[UIImage imageNamed:@"btn_3_6"] forState:UIControlStateNormal];
        [btn_7 setTitle:@"视频管理" forState:UIControlStateNormal];
        [btn_7 setTitleColor:[UIColor colorWithRed:255/255.0f green:181/255.0f blue:23/255.0f alpha:1] forState:UIControlStateNormal];
        [btn_8 setBackgroundImage:[UIImage imageNamed:@"btn_3_9"] forState:UIControlStateNormal];
        [btn_8 setTitle:@"学校空间" forState:UIControlStateNormal];
        [btn_8 setTitleColor:[UIColor colorWithRed:140/255.0f green:197/255.0f blue:64/255.0f alpha:1] forState:UIControlStateNormal];
        [btn_9 setBackgroundImage:[UIImage imageNamed:@"btn_3_7"] forState:UIControlStateNormal];
        [btn_9 setTitle:@"亲子商城" forState:UIControlStateNormal];
        [btn_9 setTitleColor:[UIColor colorWithRed:168/255.0f green:153/255.0f blue:208/255.0f alpha:1] forState:UIControlStateNormal];
    }
     btn_1.titleLabel.font=[UIFont fontWithName:@"FZSEJW--GB1-0" size:i_fontsize];
     btn_2.titleLabel.font=[UIFont fontWithName:@"FZSEJW--GB1-0" size:i_fontsize];
     btn_3.titleLabel.font=[UIFont fontWithName:@"FZSEJW--GB1-0" size:i_fontsize];
     btn_4.titleLabel.font=[UIFont fontWithName:@"FZSEJW--GB1-0" size:i_fontsize];
     btn_5.titleLabel.font=[UIFont fontWithName:@"FZSEJW--GB1-0" size:i_fontsize];
     btn_6.titleLabel.font=[UIFont fontWithName:@"FZSEJW--GB1-0" size:i_fontsize];
     btn_7.titleLabel.font=[UIFont fontWithName:@"FZSEJW--GB1-0" size:i_fontsize];
     btn_8.titleLabel.font=[UIFont fontWithName:@"FZSEJW--GB1-0" size:i_fontsize];
     btn_9.titleLabel.font=[UIFont fontWithName:@"FZSEJW--GB1-0" size:i_fontsize];
    
    //[self.view setNeedsDisplay];
    
}

-(void)viewDidAppear:(BOOL)animated {
    self.navigationController.navigationBar.topItem.title=@"马良宝";
    self.tabBarController.navigationItem.rightBarButtonItem=nil;
    
}
- (IBAction)btn_1_Click:(id)sender {
    [self MoveToStayTune:sender];
}

- (IBAction)btn_2_Click:(id)sender {
     [self MoveToStayTune:sender];
}
- (IBAction)btn_3_Click:(id)sender {
     [self MoveToStayTune:sender];
}

- (IBAction)btn_4_Click:(id)sender {
     [self MoveToStayTune:sender];
}

- (IBAction)btn_5_Click:(id)sender {
     [self MoveToStayTune:sender];
}

- (IBAction)btn_6_Click:(id)sender {
     [self MoveToStayTune:sender];
}

- (IBAction)btn_7_Click:(id)sender {
     [self MoveToStayTune:sender];
}

- (IBAction)btn_8_Click:(id)sender {
     [self MoveToStayTune:sender];
}

- (IBAction)btn_9_Click:(id)sender {
     [self MoveToStayTune:sender];
}


-(void)MoveToStayTune:(UIButton*)btn {
    NSString *str_title=btn.titleLabel.text;
    NSRange range1=[str_title rangeOfString:@"相册"];
    NSRange range2=[str_title rangeOfString:@"视频"];
    if (range1.location==NSNotFound && range2.location==NSNotFound) {
        StayTuneVC *vc_staytune=[[self storyboard] instantiateViewControllerWithIdentifier:@"view_staytune"];
        vc_staytune.str_title=@"敬请期待";
        [self.navigationController pushViewController:vc_staytune animated:YES];
    }
}

@end
