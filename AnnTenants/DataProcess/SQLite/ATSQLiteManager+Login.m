//
//  ATSQLiteManager+Login.m
//  AnnTenants
//
//  Created by HuangGang on 2018/4/5.
//  Copyright © 2018年 Harely. All rights reserved.
//

#import "ATSQLiteManager+Login.h"

@implementation ATSQLiteManager (Login)

+ (NSMutableArray *) selectData:(NSString *)keys fromDatabase:(NSString *)name conditions:(NSString *) conditions{
    conditions = [NSString stringWithFormat:@" where %@", conditions];
    NSMutableArray *results = nil;
    NSArray *arrayKeys = [keys componentsSeparatedByString:@", "];

    [ATSQLiteManager openDatabase];
//    存放结果集
    sqlite3_stmt *statement = NULL;
    sqlite3 *_db = [ATSQLiteManager gainDb];
    
//    检测SQL语句的合法性
    NSString *sql = [NSString stringWithFormat:@"select %@ from %@%@", keys, name, conditions];
    int result = sqlite3_prepare(_db, sql.UTF8String, -1, &statement, NULL);
    if (result == SQLITE_OK) {
        results = [NSMutableArray array];
    }else {
        ATLog(@"select 语法错误");
    }
    
//    执行SQLite语句
    while (sqlite3_step(statement) == SQLITE_ROW) {//真的查询到一行数据
        NSMutableDictionary *dic= [[NSMutableDictionary alloc] init];
        for (int i = 0; i < arrayKeys.count; i ++) {
            const unsigned char *value = sqlite3_column_text(statement, i);
            if (value == nil) {
                value = (unsigned char *)[@" " UTF8String];
            }
            NSString *valueStr = [NSString stringWithUTF8String:(const char *)value];
            [dic setValue:valueStr forKey:arrayKeys[i]];
        }
        [results addObject:dic];
    }
//    关闭伴随指针，防止内存泄漏
    sqlite3_finalize(statement);
    [ATSQLiteManager closeDatabase];
    return results;
}

+ (void) updateData:(NSString *)keys values:(id)value fromDatabase:(NSString *)name  conditions:(NSString *)conditions {
    conditions = [NSString stringWithFormat:@" %@", conditions];
    NSMutableArray *results = nil;
    
    [ATSQLiteManager openDatabase];
    //    存放结果集
    sqlite3_stmt *statement = NULL;
    sqlite3 *_db = [ATSQLiteManager gainDb];
    
    NSString *sql = [NSString stringWithFormat: @"update %@ set %@ = '%@' where %@;", name, keys, value, conditions];
    int result = sqlite3_prepare(_db, sql.UTF8String, -1, &statement, NULL);
    if (result == SQLITE_OK) {
        results = [NSMutableArray array];
    }else {
        ATLog(@"update 语法错误");
    }
    sqlite3_step(statement);
    //    关闭伴随指针，防止内存泄漏
    sqlite3_finalize(statement);
    [ATSQLiteManager closeDatabase];
}

+ (BOOL) deleteSQLTableForCondition:(NSString *)condition withTableName:(NSString *)tableName {
    [ATSQLiteManager openDatabase];
    
    sqlite3_stmt *stmt = nil;
    sqlite3 *_db = [ATSQLiteManager gainDb];
    NSString *deleteSql = [NSString stringWithFormat:@"delete from %@ where %@", tableName, condition];
    
    
    int result = sqlite3_prepare_v2(_db, deleteSql.UTF8String, -1, &stmt, NULL);
    if (result == SQLITE_OK) {
        sqlite3_step(stmt);
        sqlite3_finalize(stmt);
        [ATSQLiteManager closeDatabase];
        return YES;
    }else {
        ATLog(@"delete 删除失败");
        return FALSE;
    }
    
}

@end
