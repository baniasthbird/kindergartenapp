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


@property (weak, nonatomic) IBOutlet UILabel *lbl_name;

@property (weak, nonatomic) IBOutlet UIView *bg_Discribe;

@property (weak, nonatomic) IBOutlet UIImageView *img_Header;


@end
