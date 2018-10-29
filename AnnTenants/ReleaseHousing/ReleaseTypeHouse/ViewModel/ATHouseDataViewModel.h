//
//  ATHouseDataViewModel.h
//  AnnTenants
//
//  Created by HuangGang on 2018/4/25.
//  Copyright © 2018年 Harely. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ATHouseDataViewModel : NSObject

+ (void) publishHouseInformation:(ATShareHouseJsonModel *) shareHouseJsonModel isSuccess:(void (^) (_Bool isSuccess, NSString *emptyTitle)) isSuccess;

@property(nonatomic, strong) ATShareHouseJsonModel *shareHouseJsonM;


@end
