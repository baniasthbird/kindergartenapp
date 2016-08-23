//
//  ParentInfo.m
//  kindergartenapp
//
//  Created by zr-mac on 16/8/23.
//  Copyright © 2016年 zr-mac. All rights reserved.
//

#import "ParentInfo.h"

@implementation ParentInfo

+(instancetype)CreateParent:(NSMutableArray *)arr_baby {
    ParentInfo *parent=[[ParentInfo alloc]init];
    
    parent.arr_baby=arr_baby;
    
    return parent;
}

-(id)initWithCoder:(NSCoder *)aDecoder {
     if (self=[super init]) {
         self.arr_baby=[aDecoder decodeObjectForKey:@"babies"];
     }
    return self;
}


-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.arr_baby forKey:@"babies"];
}
@end
