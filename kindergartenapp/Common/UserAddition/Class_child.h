//
//  Class_child.h
//  kindergartenapp
//
//  Created by zr-mac on 16/8/23.
//  Copyright © 2016年 zr-mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Class_child : NSObject<NSCoding>

@property (nonatomic,strong) NSString *gradeid;

//id
@property (nonatomic,strong) NSString *class_id;

@property (nonatomic,strong) NSString *schoolid;

@property (nonatomic,strong) NSString *schoolname;

@property (nonatomic,strong) NSString *stunumber;

@property (nonatomic,strong) NSString *classname;

@end
