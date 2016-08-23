//
//  Baby.m
//  kindergartenapp
//
//  Created by zr-mac on 16/8/23.
//  Copyright © 2016年 zr-mac. All rights reserved.
//

#import "Baby.h"

@implementation Baby

-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.sex forKey:@"sex"];
    [aCoder encodeObject:self.schoolname forKey:@"schoolname"];
    [aCoder encodeObject:self.xuehao forKey:@"xuehao"];
    [aCoder encodeObject:self.address forKey:@"address"];
    [aCoder encodeObject:self.birthday forKey:@"birthday"];
    [aCoder encodeObject:self.classname forKey:@"classname"];
    [aCoder encodeObject:self.schoolcode forKey:@"schoolcode"];
    [aCoder encodeObject:self.gradeid forKey:@"gradeid"];
    [aCoder encodeObject:self.xuejihao forKey:@"xuejihao"];
    [aCoder encodeObject:self.gradename forKey:@"gradename"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.classid forKey:@"classid"];
    
}

-(id)initWithCoder:(NSCoder *)aDecoder {
     if (self=[super init]) {
         self.sex=[aDecoder decodeObjectForKey:@"sex"];
         self.schoolname=[aDecoder decodeObjectForKey:@"schoolname"];
         self.xuehao=[aDecoder decodeObjectForKey:@"xuehao"];
         self.address=[aDecoder decodeObjectForKey:@"address"];
         self.birthday=[aDecoder decodeObjectForKey:@"birthday"];
         self.classname=[aDecoder decodeObjectForKey:@"classname"];
         self.schoolcode=[aDecoder decodeObjectForKey:@"schoolcode"];
         self.gradeid=[aDecoder decodeObjectForKey:@"gradeid"];
         self.xuejihao=[aDecoder decodeObjectForKey:@"xuejihao"];
         self.gradename=[aDecoder decodeObjectForKey:@"gradename"];
         self.name=[aDecoder decodeObjectForKey:@"name"];
         self.classid=[aDecoder decodeObjectForKey:@"classid"];
         
         
     }
    return self;
}

@end
