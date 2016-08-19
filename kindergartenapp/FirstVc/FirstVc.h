//
//  FirstVc.h
//  kindergartenapp
//
//  Created by zr-mac on 16/8/14.
//  Copyright © 2016年 zr-mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfo.h"

@interface FirstVc : UIViewController

@property (nonatomic,strong) UserInfo *userInfo;
@property (weak, nonatomic) IBOutlet UIView *view_ClassName;
@property (weak, nonatomic) IBOutlet UIButton *btn_sendNotification;
@property (weak, nonatomic) IBOutlet UIButton *btn_send_picture;
@property (weak, nonatomic) IBOutlet UIButton *btn_send_Video;
@property (weak, nonatomic) IBOutlet UIButton *btn_Interact;

@property (weak, nonatomic) IBOutlet UIButton *btn_ClassZone;


@end
