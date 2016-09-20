//
//  DataBase.h
//  kindergartenapp
//
//  Created by hnsi-03 on 16/9/18.
//  Copyright © 2016年 zr-mac. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FMDatabase.h"

#import "FMDatabaseAdditions.h"

#import "BaseFunc.h"

@interface DataBase : NSObject

@property (nonatomic,strong) FMDatabase *database;     //数据库操作对象

@property (nonatomic,strong) BaseFunc *base_func;

+(DataBase *)sharedinstanceDB;

-(void)initTables;
-(void)deallocDataBase;

-(void)InsertVersionTable:(NSString*)str_version  Mark:(NSString*)str_mark;
-(void)UpdateVersionTable:(NSString*)str_version  Mark:(NSString*)str_mark;

-(NSMutableArray*)fetchVersionTable;

@end
