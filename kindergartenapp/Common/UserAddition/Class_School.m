//
//  Class_child.m
//  kindergartenapp
//
//  Created by zr-mac on 16/8/23.
//  Copyright © 2016年 zr-mac. All rights reserved.
//

#import "Class_School.h"

@implementation Class_School

-(id)initWithCoder:(NSCoder *)aDecoder {
    if (self=[super init]) {
        self.userid=[aDecoder decodeObjectForKey:@"userid"];
        self.i_id=[aDecoder decodeObjectForKey:@"i_id"];
        self.rolename=[aDecoder decodeObjectForKey:@"rolename"];
        self.dutyid=[aDecoder decodeObjectForKey:@"dutyid"];
        self.roleid=[aDecoder decodeObjectForKey:@"roleid"];
        self.dutyname=[aDecoder decodeObjectForKey:@"dutyname"];

    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.userid forKey:@"userid"];
    [aCoder encodeObject:self.i_id forKey:@"i_id"];
    [aCoder encodeObject:self.rolename forKey:@"rolename"];
    [aCoder encodeObject:self.dutyid forKey:@"dutyid"];
    [aCoder encodeObject:self.roleid forKey:@"roleid"];
    [aCoder encodeObject:self.dutyname forKey:@"dutyname"];


}

@end
