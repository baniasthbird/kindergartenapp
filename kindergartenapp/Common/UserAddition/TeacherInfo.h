//
//  Teacher.h
//  kindergartenapp
//
//  Created by zr-mac on 16/8/23.
//  Copyright © 2016年 zr-mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Class_School.h"

//一个老师负责多个班级
@interface TeacherInfo : NSObject<NSCoding>

+(instancetype)CreateTeacher:(NSMutableArray*)arr_class school:(Class_School*)dic_school;

@property (nonatomic,strong) NSMutableArray *arr_class;

@property (nonatomic,strong) Class_School *dic_school;

@end
