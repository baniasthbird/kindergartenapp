//
//  SettingVc.m
//  kindergartenapp
//
//  Created by zr-mac on 16/8/21.
//  Copyright © 2016年 zr-mac. All rights reserved.
//

#import "SettingVc.h"

@implementation SettingVc

-(void) viewDidLoad {
    self.tabBarItem.image=[[UIImage imageNamed:@"setting"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.tabBarItem.selectedImage=[[UIImage imageNamed:@"setting_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

@end
