//
//  Teacher.h
//  kindergartenapp
//
//  Created by zr-mac on 16/8/23.
//  Copyright © 2016年 zr-mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Class_child.h"

//一个老师负责多个班级
@interface TeacherInfo : NSObject

@property (nonatomic,strong) NSMutableArray *arr_class;

@end
