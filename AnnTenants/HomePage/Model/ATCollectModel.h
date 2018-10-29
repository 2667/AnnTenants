//
//  ATCollectModel.h
//  AnnTenants
//
//  Created by HuangGang on 2018/5/3.
//  Copyright © 2018年 Harely. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface ATCollectModel : JSONModel

+ (ATCollectModel *) initWithUser:(NSString *)userId houseID:(NSString *)houseID isCollect:(NSString *) isCollect;

@property(nonatomic, strong) NSString *userId;
@property(nonatomic, strong) NSString *houseResourceID;
@property(nonatomic, strong) NSString *isCollect;

@end
