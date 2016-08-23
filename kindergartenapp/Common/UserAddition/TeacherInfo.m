//
//  Teacher.m
//  kindergartenapp
//
//  Created by zr-mac on 16/8/23.
//  Copyright © 2016年 zr-mac. All rights reserved.
//

#import "TeacherInfo.h"


@implementation TeacherInfo

+(instancetype)CreateTeacher:(NSMutableArray *)arr_class {
    TeacherInfo *teacher=[[TeacherInfo alloc]init];
    
    teacher.arr_class=arr_class;
    
    return teacher;
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    if (self=[super init]) {
        self.arr_class=[aDecoder decodeObjectForKey:@"classes"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.arr_class forKey:@"classes"];
}
@end
