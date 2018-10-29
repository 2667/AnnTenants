//
//  ATReleaseViewModel.h
//  AnnTenants
//
//  Created by HuangGang on 2018/4/14.
//  Copyright © 2018年 Harely. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ATReleaseViewModel : NSObject

+ (NSMutableArray *)houseTypes;

//获得选择的租房类型
+ (NSMutableArray *)getHouseTypes:(NSMutableArray *)houseTypes;
@end
