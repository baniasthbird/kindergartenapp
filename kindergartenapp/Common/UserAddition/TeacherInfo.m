//
//  Teacher.m
//  kindergartenapp
//
//  Created by zr-mac on 16/8/23.
//  Copyright © 2016年 zr-mac. All rights reserved.
//

#import "TeacherInfo.h"


@implementation TeacherInfo

+(instancetype)CreateTeacher:(NSMutableArray *)arr_class school:(Class_School*)dic_school{
    TeacherInfo *teacher=[[TeacherInfo alloc]init];
    teacher.arr_class=arr_class;
    teacher.dic_school=dic_school;
    
    return teacher;
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    if (self=[super init]) {
        self.arr_class=[aDecoder decodeObjectForKey:@"classes"];
        self.dic_school=[aDecoder decodeObjectForKey:@"school"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.arr_class forKey:@"classes"];
    [aCoder encodeObject:self.dic_school forKey:@"school"];
}
@end
