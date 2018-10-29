//
//  ATCollectModel.m
//  AnnTenants
//
//  Created by HuangGang on 2018/5/3.
//  Copyright © 2018年 Harely. All rights reserved.
//

#import "ATCollectModel.h"

@implementation ATCollectModel

+ (ATCollectModel *) initWithUser:(NSString *)userId houseID:(NSString *)houseID isCollect:(NSString *) isCollect {
    ATCollectModel *collectM = [[ATCollectModel alloc] init];
    collectM.userId = userId;
    collectM.houseResourceID = houseID;
    collectM.isCollect = isCollect;
    return collectM;
}
@end
