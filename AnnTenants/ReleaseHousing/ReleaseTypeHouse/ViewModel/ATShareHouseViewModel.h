//
//  ATShareHouseViewModel.h
//  AnnTenants
//
//  Created by HuangGang on 2018/4/14.
//  Copyright © 2018年 Harely. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ATShareHouseViewModel : NSObject

//类构造方法
+ (instancetype) shareHouseVM;
- (void) loadBaseCellInfo;

//获得发布的房源信息
- (NSMutableArray *) getShareHouseSections;

//租住类型
- (void)rentTypes:(NSMutableArray *) types;
//房源图片
- (void)housePictures:(NSMutableArray *) pictures;
//小区
- (void) location;
- (NSString *)getRentType;

@end
