//
//  ATHouseResourceViewModel.h
//  AnnTenants
//
//  Created by HuangGang on 2018/4/28.
//  Copyright © 2018年 Harely. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ATHouseResourceViewModel : NSObject

//获取房源字段信息从SQLite
+ (NSMutableArray *) getHoseResourceFieldFromSQLite;
//获得用户(房东信息)
+ (ATMyHeadModel *) userOrLandlordInfoByID:(NSString *) houseUserID;
//获取收藏房源信息
+ (NSMutableArray *) collectResourceForConditions:(NSString *) conditions;
//是否是已收藏房源
+ (BOOL) isCollectHouseResourceForConditions:(NSString *) conditions;
//获得收藏房源
+ (NSMutableArray *) getCollectDataFromSQLDatabaseWithUserId:(NSString *) userId;
//获得预约房源
+ (NSMutableArray *) getReservationDataFromSQLDatabaseWithUserId:(NSString *) userId;
//获取发布房源
+ (NSMutableArray *) getPublishHouseDataFromSQLDatabaseWithUserId:(NSString *) userId;
+ (void) deleteDataFromSQLiteWithDataArray:(NSMutableArray *) datas tableName:(NSString *)name;
@end
