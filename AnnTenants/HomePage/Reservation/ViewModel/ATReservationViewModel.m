//
//  ATReservationViewModel.m
//  AnnTenants
//
//  Created by HuangGang on 2018/5/3.
//  Copyright © 2018年 Harely. All rights reserved.
//

#import "ATReservationViewModel.h"

@implementation ATReservationViewModel

//使用SQL嵌套语句查询user数据
+ (ATMyHeadModel *) getUserDataFromHousingResourceTableForHouseResourceID:(NSString *) houseResourceID {
    NSString *keys = @"userId, nickName, phoneNumber, password, sex, avatarPath";
    NSString *tableName = @"user";
    NSString *condition = [NSString stringWithFormat:@"userId in (select userId from housingResource where houseResourceID = '%@')", houseResourceID];
    NSMutableArray *users = [ATSQLiteManager selectData:keys fromDatabase:tableName conditions:condition];
    NSDictionary *userDic = users.firstObject;
    ATMyHeadModel *myHeadM = [ATMyHeadModel new];
    myHeadM.userId = userDic[@"userId"];
    myHeadM.nickName = userDic[@"nickName"];
    myHeadM.phoneNumber = userDic[@"phoneNumber"];
    myHeadM.password = userDic[@"password"];
    if ([userDic[@"sex"] isEqualToString:@"1"]) {
        myHeadM.sex = @"男";
    }else {
        myHeadM.sex = @"女";
    }
    myHeadM.avatarPath = userDic[@"avatarPath"];
    
    return myHeadM;
}

+ (ATReservationModel *) getReservationDataFromSQLTableWithUserID:(NSString *) userID houseResourceID:(NSString *) houseResourceID {
    ATReservationModel *reservationM = [ATReservationModel new];
    
    NSString *keys = @"userId, houseResourceID, reservationTime, isReservation";
    NSString *tableName = @"reservationHouseResource";
    NSString *condition = [NSString stringWithFormat:@"userId = '%@' and houseResourceID = '%@'", userID, houseResourceID];
    NSMutableArray *users = [ATSQLiteManager selectData:keys fromDatabase:tableName conditions:condition];
    NSDictionary *reservationDic = users.firstObject;
    
    reservationM.userId = reservationDic[@"userId"];
    reservationM.houseResourcID = reservationDic[@"houseResourceID"];
    reservationM.reservationTime = reservationDic[@"reservationTime"];
    reservationM.isReservation = reservationDic[@"isReservation"];
    
    return reservationM;
}

@end
