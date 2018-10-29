//
//  ATSQLiteManager+Login.h
//  AnnTenants
//
//  Created by HuangGang on 2018/4/5.
//  Copyright © 2018年 Harely. All rights reserved.
//
//数据库查找：https://www.jianshu.com/p/cf76e2e81230， https://www.cnblogs.com/wendingding/p/3871577.html, https://www.cnblogs.com/yeas/p/6861362.html

#import "ATSQLiteManager.h"

@interface ATSQLiteManager (Login)

//字段查找值
+ (NSMutableArray *) selectData:(NSString *)keys fromDatabase:(NSString *)name conditions:(NSString *) conditions;

//修改字段
+ (void) updateData:(NSString *)keys values:(id)value fromDatabase:(NSString *)name  conditions:(NSString *)conditions;

//删除数据
+ (BOOL) deleteSQLTableForCondition:(NSString *)condition withTableName:(NSString *)tableName;

@end
