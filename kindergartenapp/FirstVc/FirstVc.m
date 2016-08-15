//
//  FirstVc.m
//  kindergartenapp
//
//  Created by zr-mac on 16/8/14.
//  Copyright © 2016年 zr-mac. All rights reserved.
//

#import "FirstVc.h"

@implementation FirstVc

-(void)viewDidLoad {
    //self.view.=@"新马良幼儿园";
    _view_ClassName.layer.borderWidth=1;
    _view_ClassName.layer.borderColor=[[UIColor colorWithRed:187/255.0f green:187/255.0f blue:187/255.0f alpha:1] CGColor];
    
    _btn_sendNotification.layer.masksToBounds=YES;
    _btn_sendNotification.layer.cornerRadius=30;
    _btn_sendNotification.layer.borderWidth=1;
    
    _btn_send_picture.layer.masksToBounds=YES;
    _btn_send_picture.layer.cornerRadius=30;
    _btn_send_picture.layer.borderWidth=1;
    
    _btn_send_Video.layer.masksToBounds=YES;
    _btn_send_Video.layer.cornerRadius=30;
    _btn_send_Video.layer.borderWidth=1;
    
    _btn_Interact.layer.masksToBounds=YES;
    _btn_Interact.layer.borderWidth=1;
    _btn_Interact.layer.cornerRadius=30;
    
    _btn_ClassZone.layer.masksToBounds=YES;
    _btn_ClassZone.layer.borderWidth=1;
    _btn_ClassZone.layer.cornerRadius=30;
    
}

@end
