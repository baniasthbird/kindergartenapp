//
//  DataBase.m
//  kindergartenapp
//
//  Created by hnsi-03 on 16/9/18.
//  Copyright © 2016年 zr-mac. All rights reserved.
//

#import "DataBase.h"

@implementation DataBase

-(void)dealloc {
    if ([_database open]) {
        [self close];
    }
}

-(void)open {
    if (![_database open]) {
        NSAssert(0,@"不能打开数据库");
    }
}


-(void)close {
    if (![_database close]) {
        NSAssert(0,@"关闭数据库失败");
    }
}

-(void)deallocDataBase {
    _database=nil;
}

+(DataBase *)sharedinstanceDB {
    static DataBase *sharedInstanceDB=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        sharedInstanceDB=[[DataBase alloc]init];
    });
    
    return sharedInstanceDB;
}


-(id)init {
    self=[super init];
    if (self) {
        NSString *dbname=@"Mydatabase.db";
        _database=[[FMDatabase alloc] initWithPath:[self databasePath:dbname]];
        NSLog(@"database init");
        _base_func=[[BaseFunc alloc]init];
    }
    return self;

}

-(NSString *)databasePath:(NSString*)userName {
    NSString *dir = [NSString stringWithFormat:@"%@/%@/%@", NSHomeDirectory(), @"Library",userName];
    if (![[NSFileManager defaultManager] fileExistsAtPath:dir]){
        [[NSFileManager defaultManager] createDirectoryAtPath:dir withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return  [NSString stringWithFormat:@"%@/note.db",dir];
    
}

-(void)initTables {
    [_database open];
    //生成版本表
    NSString *sqlCreateTableVersion=[NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS '%@' ('%@' INTEGER PRIMARY KEY AUTOINCREMENT, '%@' TEXT,'%@' TEXT)",TB_VERSION,TB_ID,TB_V_VERSION,TB_MARK];
    BOOL resV=[_database executeUpdate:sqlCreateTableVersion];
    if (!resV) {
         NSLog(@"error when creating Version table");
    }
    else {
         NSLog(@"success to creating Version table");
    }
}


//初始化Version表
-(void)InsertVersionTable:(NSString *)str_version Mark:(NSString *)str_mark {
    NSMutableArray *t_array=[self fetchVersionTable];
    if (t_array.count==0) {
        NSString *insertSql=[NSString stringWithFormat:@"INSERT INTO '%@' ('%@' , '%@' ) VALUES ('%@' , '%@')",TB_VERSION,TB_V_VERSION,TB_MARK,str_version,str_mark];
        BOOL res=[_database executeUpdate:insertSql];
        if (res) {
            NSLog(@"成功添加至版本表");
        }
        else {
            NSLog(@"添加数据值版本表出错");
        }
    }
    else {
        if ([_database open]) {
            NSString *deleteSql=[NSString stringWithFormat:@"DELETE FROM %@",TB_VERSION];
            
            BOOL res =[_database executeUpdate:deleteSql];
            if (res) {
                NSLog(@"成功删除版本表");
            }
            else {
                NSLog(@"删除版本表失败");
            }
            
            NSString *insertSql1=[NSString stringWithFormat:@"INSERT INTO '%@' ('%@' , '%@') VALUES ('%@' , '%@')",TB_VERSION,TB_V_VERSION,TB_MARK,str_version,str_mark];
            BOOL res2=[_database executeUpdate:insertSql1];
            if (res2) {
                NSLog(@"成功添加至版本表");
            }
            else {
                NSLog(@"添加数据至版本表出错!");
            }
        }
    }
}

//获取版本表数据
-(NSMutableArray*)fetchVersionTable {
    [_database open];
    NSString *sql=[NSString stringWithFormat:@"SELECT * FROM %@",TB_VERSION];
    
    NSMutableArray *array=[@[] mutableCopy];
    
    FMResultSet *rs=[_database executeQuery:sql];
    while ([rs next]) {
        NSString *str_version=[rs stringForColumn:TB_V_VERSION];
        [array addObject:str_version];
    }
    
    [_database close];
    
    return array;
}

//更新版本地址
-(void)UpdateVersionTable:(NSString *)str_version Mark:(NSString *)str_mark {
    if ([_database open]) {
        NSString *updateSql1=@"";
        updateSql1=[NSString stringWithFormat:@"UPDATE '%@' SET '%@' = '%@', '%@' = '%@' ",TB_VERSION,TB_V_VERSION,str_version,TB_MARK,str_mark];
        BOOL res=[_database executeUpdate:updateSql1];
        if (res) {
            NSLog(@"成功更新版本表");
        }
        else {
            NSLog(@"更新版本表出错");
        }
    }
}

@end
