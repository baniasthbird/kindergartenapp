//
//  Baby.h
//  kindergartenapp
//
//  Created by zr-mac on 16/8/23.
//  Copyright © 2016年 zr-mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Baby : NSObject<NSCoding>

@property (nonatomic,strong) NSString *sex;   //0是女 1是男

@property (nonatomic,strong) NSString *schoolname;   //学校名称

@property (nonatomic,strong) NSString *xuehao ;      //学号

@property (nonatomic,strong) NSString *address;     //地址

@property (nonatomic,strong) NSString *birthday;     //生日

@property (nonatomic,strong) NSString *classname;    //班级

@property (nonatomic,strong) NSString *schoolcode;   //学校代码

@property (nonatomic,strong) NSString *gradeid;      //年纪ID

@property (nonatomic,strong) NSString *xuejihao;       //学籍号

@property (nonatomic,strong) NSString *gradename;     //年级名称

@property (nonatomic,strong) NSString *name;          //孩子姓名

@property (nonatomic,strong) NSString *classid;       //班级ID

@end
