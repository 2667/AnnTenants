//
//  ATReservationModel.h
//  AnnTenants
//
//  Created by HuangGang on 2018/5/3.
//  Copyright © 2018年 Harely. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface ATReservationModel : JSONModel

@property(nonatomic, strong) NSString *userId;
@property(nonatomic, strong) NSString *houseResourcID;
@property(nonatomic, strong) NSString *reservationTime;
@property(nonatomic, strong) NSString *isReservation;

@end
