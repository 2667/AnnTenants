//
//  ATHouseResourceViewModel.m
//  AnnTenants
//
//  Created by HuangGang on 2018/4/28.
//  Copyright © 2018年 Harely. All rights reserved.
//

#import "ATHouseResourceViewModel.h"

@implementation ATHouseResourceViewModel


//获得房源详细信息
+ (NSMutableArray *) getHoseResourceFieldFromSQLite {
    
    NSString *key = @"houseResourceID, userId, rentType, housePicturesPath, location, floor, houseType, orientation, decorated, area, houseConfiguration, rent, paymentWays, onHireDuration, renterRequire, detailDescribe, publishTime";
    NSString *tableName = @"housingResource";
    NSString *condition = @"houseResourceID is not null";
    NSMutableArray *houseResourceDics = [ATSQLiteManager selectData:key fromDatabase:tableName conditions:condition];
    
    return  [ATHouseResourceViewModel parseToHouseResourceModelsWithSQLDics:houseResourceDics];
}

//将数据库查到的字典数组转化为模型数组
+ (NSMutableArray *) parseToHouseResourceModelsWithSQLDics:(NSMutableArray *) houseResourceDics {
    NSMutableArray *houseResourceMS = [NSMutableArray array];

    for (NSDictionary *dic in houseResourceDics) {
        ATShareHouseJsonModel *shareHouseJsonM = [ATShareHouseJsonModel new];
        
        shareHouseJsonM.houseingResourceID = dic[@"houseResourceID"];
        shareHouseJsonM.userId = dic[@"userId"];
        shareHouseJsonM.rentType = dic[@"rentType"];
        
        NSArray *picturePaths = [dic[@"housePicturesPath"] componentsSeparatedByString:@","];
        NSMutableArray *housePictures = [NSMutableArray array];
        for (NSString *path in picturePaths) {
            if (![ATTools isBlankString:path]) {
                UIImage * picture = [ATTools readPictureFromAbsolutePath:path];
                [housePictures addObject:picture];
            }
        }
        shareHouseJsonM.housePictures = housePictures;
        
        shareHouseJsonM.location = dic[@"location"];
        shareHouseJsonM.floor = dic[@"floor"];
        shareHouseJsonM.houseType = dic[@"houseType"];
        shareHouseJsonM.orientation = dic[@"orientation"];
        shareHouseJsonM.decorated = dic[@"decorated"];
        shareHouseJsonM.area = dic[@"area"];
        shareHouseJsonM.houseConfiguration = dic[@"houseConfiguration"];
        shareHouseJsonM.rent = dic[@"rent"];
        shareHouseJsonM.paymentWays = dic[@"paymentWays"];
        shareHouseJsonM.onHireDuration = dic[@"onHireDuration"];
        shareHouseJsonM.renterRequire = dic[@"renterRequire"];
        shareHouseJsonM.detailDescribe = dic[@"detailDescribe"];
        shareHouseJsonM.publishTime = dic[@"publishTime"];
        
        [houseResourceMS addObject:shareHouseJsonM];
    }
    
    return houseResourceMS;
}


+ (NSMutableArray *) getReservationDataFromSQLDatabaseWithUserId:(NSString *) userId  {
    NSString *keys = @"houseResourceID, userId, rentType, housePicturesPath, location, floor, houseType, orientation, decorated, area, houseConfiguration, rent, paymentWays, onHireDuration, renterRequire, detailDescribe, publishTime";
    NSString *tableName = @"housingResource";
    NSString *condition = [NSString stringWithFormat:@"houseResourceID in (select houseResourceID from reservationHouseResource where userId = '%@')", userId];
    NSMutableArray *houseResourcesDic = [ATSQLiteManager selectData:keys fromDatabase:tableName conditions:condition];
    
    return [ATHouseResourceViewModel parseToHouseResourceModelsWithSQLDics:houseResourcesDic];
}

+ (NSMutableArray *)getCollectDataFromSQLDatabaseWithUserId:(NSString *) userId {
    NSString *keys = @"houseResourceID, userId, rentType, housePicturesPath, location, floor, houseType, orientation, decorated, area, houseConfiguration, rent, paymentWays, onHireDuration, renterRequire, detailDescribe, publishTime";
    NSString *tableName = @"housingResource";
    NSString *condition = [NSString stringWithFormat:@"houseResourceID in (select houseResourceID from collectHouseResource where userId = '%@')", userId];
    NSMutableArray *houseResourcesDic = [ATSQLiteManager selectData:keys fromDatabase:tableName conditions:condition];
    
    return [ATHouseResourceViewModel parseToHouseResourceModelsWithSQLDics:houseResourcesDic];
}

+ (NSMutableArray *) getPublishHouseDataFromSQLDatabaseWithUserId:(NSString *) userId {
    NSString *keys = @"houseResourceID, userId, rentType, housePicturesPath, location, floor, houseType, orientation, decorated, area, houseConfiguration, rent, paymentWays, onHireDuration, renterRequire, detailDescribe, publishTime";
    NSString *tableName = @"housingResource";
    NSString *condition = [NSString stringWithFormat:@"userId = '%@'", userId];
    NSMutableArray *houseResourcesDic = [ATSQLiteManager selectData:keys fromDatabase:tableName conditions:condition];
    
    return [ATHouseResourceViewModel parseToHouseResourceModelsWithSQLDics:houseResourcesDic];
}


//获得用户(房东信息)
+ (ATMyHeadModel *) userOrLandlordInfoByID:(NSString *) houseUserID {
    NSString *keys = @"userId, nickName, phoneNumber, password, sex, avatarPath";
    NSString *table = @"user";
    NSString *condition = [NSString stringWithFormat:@"userId = '%@'", houseUserID];
    NSArray *infos = [ATSQLiteManager selectData:keys fromDatabase:table conditions:condition];
    
    ATMyHeadModel *myHeadM = [ATMyHeadModel new];
    NSDictionary *infoDic = infos.firstObject;
    myHeadM.userId = infoDic[@"userId"];
    myHeadM.nickName = infoDic[@"nickName"];
    myHeadM.phoneNumber = infoDic[@"phoneNumber"];
    myHeadM.password = infoDic[@"password"];
    
    if ([infoDic[@"sex"] isEqualToString:@"1"]) {
        myHeadM.sex = @"男";
    }else {
        myHeadM.sex = @"女";
    }
    myHeadM.avatarPath = infoDic[@"avatarPath"];
    
    return myHeadM;
}

+ (NSMutableArray *) collectResourceForConditions:(NSString *) conditions {
    NSString *keys = @"userId, houseResourceID, isCollect";
    NSString *tableName = @"collectHouseResource";
    NSMutableArray *ms = [NSMutableArray array];
    
    NSArray *infos = [ATSQLiteManager selectData:keys fromDatabase:tableName conditions:conditions];
    
    for (NSDictionary *infoDic in infos) {
        ATCollectModel *collectM = [ATCollectModel new];
        collectM.userId = infoDic[@"userId"];
        collectM.houseResourceID = infoDic[@"houseResourceID"];
        collectM.isCollect = infoDic[@"isCollect"];
        [ms addObject:collectM];
    }
    return  ms;
}

+ (BOOL) isCollectHouseResourceForConditions:(NSString *) conditions {
    NSMutableArray *collects = [ATHouseResourceViewModel collectResourceForConditions:conditions];
    ATCollectModel *collect = collects.firstObject;
    if ([collect.isCollect isEqualToString:@"收藏"] || collects.count <= 0 ) {
        return FALSE;
    } else {
        return YES;
    }
}

+ (void) deleteDataFromSQLiteWithDataArray:(NSMutableArray *) datas tableName:(NSString *)name {
    for (ATShareHouseJsonModel *shareHouseJM in datas) {
        NSString *conditions = [NSString stringWithFormat:@"houseResourceID = '%@'", shareHouseJM.houseingResourceID];
        
//        获得图片的相对路径
        NSDictionary *picturePathDic = [[ATSQLiteManager selectData:@"housePicturesPath" fromDatabase:name conditions: conditions] firstObject];
        NSString *picturePath = picturePathDic[@"housePicturesPath"];
        NSMutableArray *picturePaths = [NSMutableArray arrayWithArray:[picturePath componentsSeparatedByString:@","]];
        [picturePaths removeObject:@""];
        for (NSString *absolutePath in picturePaths) {
            [ATTools deleteImageWith:absolutePath];
        }
        
//        删除数据库的数据
        [ATSQLiteManager deleteSQLTableForCondition:conditions withTableName:name];
    }
}

@end
