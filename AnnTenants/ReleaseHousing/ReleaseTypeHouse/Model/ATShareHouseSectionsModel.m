//
//  ATShareHouseSectionsModel.m
//  AnnTenants
//
//  Created by HuangGang on 2018/4/15.
//  Copyright © 2018年 Harely. All rights reserved.
//

#import "ATShareHouseSectionsModel.h"

@implementation ATShareHouseSectionsModel

- (ATShareHouseSectionsModel *)initWithTitle:(NSString *)title andDescribe:(NSString *)describe andHousesInfo:(NSMutableArray *)housesInfo {
    self = [super init];
    if (self) {
        self.sectionTitle = title;
        self.sectionDescribe = describe;
        self.sectionHousesInfo = housesInfo;
    }
    return  self;
}

+ (ATShareHouseSectionsModel *)initWithTitle:(NSString *)title andDescribe:(NSString *)describe andHousesInfo:(NSMutableArray *)housesInfo {
    ATShareHouseSectionsModel * shareHouseSectionsM = [[ATShareHouseSectionsModel alloc] initWithTitle:title andDescribe:describe andHousesInfo:housesInfo];
    return  shareHouseSectionsM;
}

//+ (NSArray *) sectionsTitle {
//    NSArray *sections = @[@[@"租住类型"],
//                          @[@"最多添加9张房源图片"],
//                          @[@"小区"],
//                          @[@"楼层/总楼层", @"户型", @"朝向", @"装修", @"面积"],
//                          @[@"房屋配置"],
//                          @[@"付款", @"付款方式"],
//                          @[@"起租时长"],
//                          @[@"对租客要求"],
//                          @[@"详细描述"]];
//    return sections;
//}
@end
