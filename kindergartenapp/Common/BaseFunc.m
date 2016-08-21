//
//  BaseFunc.m
//  kindergartenapp
//
//  Created by zr-mac on 16/8/21.
//  Copyright © 2016年 zr-mac. All rights reserved.
//

#import "BaseFunc.h"

@implementation BaseFunc

-(NSString*)GetValueFromDic:(NSDictionary*)dic_tmp key:(NSString*)str_key {
    NSObject *obj_tmp=[dic_tmp objectForKey:str_key];
    NSString *str_tmp=@"";
    if (obj_tmp!=[NSNull null]) {
        str_tmp=(NSString*)obj_tmp;
    }
    return str_tmp;
}

-(NSString*)GetValueFromArray:(NSArray*)arr_tmp index:(NSInteger)i_index {
    NSObject *obj_tmp=[arr_tmp objectAtIndex:0];
    NSString *str_tmp=@"";
    if (obj_tmp!=[NSNull null]) {
        str_tmp=(NSString*)obj_tmp;
    }
    
    return str_tmp;
}


@end
