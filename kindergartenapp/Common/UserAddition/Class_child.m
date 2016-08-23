//
//  Class_child.m
//  kindergartenapp
//
//  Created by zr-mac on 16/8/23.
//  Copyright © 2016年 zr-mac. All rights reserved.
//

#import "Class_child.h"

@implementation Class_child

-(id)initWithCoder:(NSCoder *)aDecoder {
    if (self=[super init]) {
        self.gradeid=[aDecoder decodeObjectForKey:@"gradeid"];
        self.class_id=[aDecoder decodeObjectForKey:@"class_id"];
        self.schoolid=[aDecoder decodeObjectForKey:@"schoolid"];
        self.schoolname=[aDecoder decodeObjectForKey:@"schoolname"];
        self.stunumber=[aDecoder decodeObjectForKey:@"stunumber"];
        self.classname=[aDecoder decodeObjectForKey:@"classname"];

    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.gradeid forKey:@"gradeid"];
    [aCoder encodeObject:self.class_id forKey:@"class_id"];
    [aCoder encodeObject:self.schoolid forKey:@"schoolid"];
    [aCoder encodeObject:self.schoolname forKey:@"schoolname"];
    [aCoder encodeObject:self.stunumber forKey:@"stunumber"];
    [aCoder encodeObject:self.classname forKey:@"classname"];


}

@end
