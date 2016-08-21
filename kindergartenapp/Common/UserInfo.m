//
//  UserInfo.m
//  kindergartenapp
//
//  Created by zr-mac on 16/8/14.
//  Copyright © 2016年 zr-mac. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo

-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.arr_menus forKey:@"menus"];
    [aCoder encodeObject:self.str_token forKey:@"token"];
    [aCoder encodeObject:self.str_name forKey:@"name"];
    [aCoder encodeObject:self.nickname forKey:@"nickname"];
    [aCoder encodeObject:self.str_org forKey:@"orgnization"];
    [aCoder encodeObject:self.str_id forKey:@"id"];
    [aCoder encodeObject:self.str_role forKey:@"role"];
    [aCoder encodeObject:self.str_schoolcode forKey:@"schoolcode"];
    [aCoder encodeObject:self.str_account forKey:@"account"];
    [aCoder encodeObject:self.str_phonenumber forKey:@"phonenumber"];
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    if (self=[super init]) {
        self.str_name=[aDecoder decodeObjectForKey:@"name"];
        self.str_phonenumber=[aDecoder decodeObjectForKey:@"phonenumber"];
        self.str_token=[aDecoder decodeObjectForKey:@"token"];
        self.str_account=[aDecoder decodeObjectForKey:@"account"];
        self.nickname=[aDecoder decodeObjectForKey:@"nickname"];
        self.str_schoolcode=[aDecoder decodeObjectForKey:@"schoolcode"];
        self.str_role=[aDecoder decodeObjectForKey:@"role"];
        self.str_id=[aDecoder decodeObjectForKey:@"id"];
        self.str_org=[aDecoder decodeObjectForKey:@"orgnization"];
        self.arr_menus=[aDecoder decodeObjectForKey:@"menus"];
    }
    return self;
}
@end
