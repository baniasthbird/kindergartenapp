//
//  UserInfo.h
//  kindergartenapp
//
//  Created by zr-mac on 16/8/14.
//  Copyright © 2016年 zr-mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject<NSCoding>

@property (nonatomic,strong) NSMutableArray *arr_menus;

@property (nonatomic,strong) NSString *str_token;

@property (nonatomic,strong) NSString *str_account;

@property (nonatomic,strong) NSString *str_id;

@property (nonatomic,strong) NSString *str_name;

@property (nonatomic,strong) NSString *nickname;

@property (nonatomic,strong) NSString *str_org;

@property  (nonatomic,strong) NSString* str_phonenumber;

@property  (nonatomic,strong) NSString* str_role;

@property  (nonatomic,strong) NSString* str_schoolcode;



@end
