//
//  SecondVc.m
//  kindergartenapp
//
//  Created by zr-mac on 16/8/21.
//  Copyright © 2016年 zr-mac. All rights reserved.
//

#import "SecondVc.h"

@implementation SecondVc


-(void) viewDidLoad {
    self.tabBarItem.image=[[UIImage imageNamed:@"second"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.tabBarItem.selectedImage=[[UIImage imageNamed:@"second_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}


-(void)viewDidAppear:(BOOL)animated {
    self.tabBarController.navigationItem.rightBarButtonItem=nil;
    
}

@end
