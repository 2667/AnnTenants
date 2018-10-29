//
//  ATReservationViewModel.h
//  AnnTenants
//
//  Created by HuangGang on 2018/5/3.
//  Copyright © 2018年 Harely. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ATReservationViewModel : NSObject

#pragma mark -SQL嵌套语句查询user数据
+ (ATMyHeadModel *) getUserDataFromHousingResourceTableForHouseResourceID:(NSString *) houseResourceID;

#pragma mark - 获取预约数据
+ (ATReservationModel *) getReservationDataFromSQLTableWithUserID:(NSString *) userID houseResourceID:(NSString *) houseResourceID;
@end
