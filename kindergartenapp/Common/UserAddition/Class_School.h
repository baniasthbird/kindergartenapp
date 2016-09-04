//
//  Class_child.h
//  kindergartenapp
//
//  Created by zr-mac on 16/8/23.
//  Copyright © 2016年 zr-mac. All rights reserved.
//

#import <Foundation/Foundation.h>

//班级和学校共用的数据结构

@interface Class_School : NSObject<NSCoding>

@property (nonatomic,strong) NSString *userid;

//id
@property (nonatomic,strong) NSString *i_id;

@property (nonatomic,strong) NSString *rolename;

@property (nonatomic,strong) NSString *dutyid;

@property (nonatomic,strong) NSString *roleid;

@property (nonatomic,strong) NSString *dutyname;

@end
