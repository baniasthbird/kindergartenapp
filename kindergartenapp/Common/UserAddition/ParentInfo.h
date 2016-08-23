//
//  ParentInfo.h
//  kindergartenapp
//
//  Created by zr-mac on 16/8/23.
//  Copyright © 2016年 zr-mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Baby.h"

@interface ParentInfo : NSObject<NSCoding>
//一个家长对应多个孩子
+(instancetype)CreateParent:(NSMutableArray*)arr_baby;

@property (nonatomic,strong) NSMutableArray *arr_baby;

@end
