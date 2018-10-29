//
//  ATShareHouseJModel.m
//  AnnTenants
//
//  Created by HuangGang on 2018/4/15.
//  Copyright © 2018年 Harely. All rights reserved.
//

#import "ATShareHouseJsonModel.h"

@implementation ATShareHouseJsonModel

+ (NSDictionary *) getSectionTitle {
    
    NSDictionary *dict = @{@"rentType":@"租住类型", @"housePictures": @"房源图片", @"location": @"地区",  @"floor": @"楼层/总楼层",  @"houseType": @"户型",  @"orientation": @"朝向",  @"decorated": @"装修",  @"area": @"面积",  @"houseConfiguration": @"房屋配置",  @"rent": @"房租", @"paymentWays": @"付款方式", @"onHireDuration": @"起租时长"};
    return dict;
}
@end
