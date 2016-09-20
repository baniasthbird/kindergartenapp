//
//  WxHxD.h
//  unicomOA
//
//  Created by zr-mac on 16/2/15.
//  Copyright © 2016年 zr-mac. All rights reserved.
//

// 宽度
#define  Width                             [UIScreen mainScreen].bounds.size.width

// 高度
#define  Height                            [UIScreen mainScreen].bounds.size.height

// 状态栏高度
#define  StatusBarHeight                   20.f

// 导航栏高度
#define  NavigationBarHeight               44.f

// 标签栏高度
#define  TabbarHeight                      49.f

// 状态栏高度 + 导航栏高度
#define  StatusBarAndNavigationBarHeight   (20.f + 44.f)

#define  iPhone4_4s   (Width == 320.f && Height == 480.f ? YES : NO)
#define  iPhone5_5s   (Width == 320.f && Height == 568.f ? YES : NO)
#define  iPhone6      (Width == 375.f && Height == 667.f ? YES : NO)
#define  iPhone6_plus (Width == 414.f && Height == 736.f ? YES : NO)
#define  iPad         (Width == 768.f && Height == 1024.f ? YES : NO)

//版本表
#define TB_VERSION    @"TB_VERSION"
#define TB_ID         @"V_ID"
#define TB_V_VERSION    @"V_VERSION"
#define TB_MARK       @"V_MARK"
