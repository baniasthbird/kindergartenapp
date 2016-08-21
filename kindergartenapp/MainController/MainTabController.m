//
//  MainTabController.m
//  kindergartenapp
//
//  Created by hnsi-03 on 16/8/19.
//  Copyright © 2016年 zr-mac. All rights reserved.
//

#import "MainTabController.h"
#import "FirstVc.h"
#import "AFNetworking.h"
#import "NTButton.h"
#import "FirstVc.h"
#import "SecondVc.h"
#import "ThirdVc.h"
#import "FourthVc.h"
#import "SettingVc.h"

@interface MainTabController() {
     NTButton * _previousBtn;//记录前一次选中的按钮
}

@property (nonatomic,strong) AFHTTPSessionManager *session;

@end


@implementation MainTabController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    _session=[AFHTTPSessionManager manager];
    _session.responseSerializer= [AFHTTPResponseSerializer serializer];
    [_session.requestSerializer setHTTPShouldHandleCookies:YES];
    [_session.requestSerializer setTimeoutInterval:10.0f];

    FirstVc *vc_1=[[FirstVc alloc]init];
    UINavigationController *navi1=[[UINavigationController alloc]initWithRootViewController:vc_1];
    
    SecondVc *vc_2=[[SecondVc alloc]init];
    UINavigationController *navi2=[[UINavigationController alloc]initWithRootViewController:vc_2];
    
    ThirdVc *vc_3=[[ThirdVc alloc]init];
    UINavigationController *navi3=[[UINavigationController alloc]initWithRootViewController:vc_3];
   
    /*
    FourthVc *vc_4=[[FourthVc alloc]init];
    UINavigationController *navi4=[[UINavigationController alloc]initWithRootViewController:vc_4];
    */
    
    SettingVc *vc_5=[[SettingVc alloc]init];
    UINavigationController *navi5=[[UINavigationController alloc]initWithRootViewController:vc_5];
    
    self.viewControllers=[NSArray arrayWithObjects:navi1,navi2,navi3,navi5, nil];
    
    self.tabBar.itemPositioning=UITabBarItemPositioningFill;
    
    UITabBarItem *item1=[self.tabBar.items objectAtIndex:0];
    item1.image=[UIImage imageNamed:@"first"];
    item1.selectedImage=[UIImage imageNamed:@"first_selected"];
    item1.title=@"首页";
    
    UITabBarItem *item2=[self.tabBar.items objectAtIndex:1];
    item2.image=[UIImage imageNamed:@"second"];
    item2.selectedImage=[UIImage imageNamed:@"second_selected"];
    item2.title=@"班级群";
    
    UITabBarItem *item3=[self.tabBar.items objectAtIndex:2];
    item3.image=[UIImage imageNamed:@"third"];
    item3.selectedImage=[UIImage imageNamed:@"third_selected"];
    item3.title=@"家园";
    
    UITabBarItem *item4=[self.tabBar.items objectAtIndex:3];
    item4.image=[UIImage imageNamed:@"setting"];
    item4.selectedImage=[UIImage imageNamed:@"setting_selected"];
    item4.title=@"我";
    
    //NTButton *button = self.tabBar.subviews[0];
    
    
    }

#pragma  mark 创建一个按钮
-(void)createBuutonWithNormalName:(NSString *)normal andSelectedName:(NSString *)selected andTitle:(NSString*) title andIndex:(int)index {
    
}

#pragma mark 按钮被点击时调用
-(void)changeViewContoller:(NTButton *)sender {
    if(self.selectedIndex != sender.tag){ //wsq®
        self.selectedIndex = sender.tag; //切换不同控制器的界面
        _previousBtn.selected = ! _previousBtn.selected;
        _previousBtn = sender;
        _previousBtn.selected = YES;
    }

}

@end
