//
//  ATShareHouseViewModel.m
//  AnnTenants
//
//  Created by HuangGang on 2018/4/14.
//  Copyright © 2018年 Harely. All rights reserved.
// 遗漏之处：应将HouseInfo的数据类型换为 ATShareHouseJsonModel 就好了

#import "ATShareHouseViewModel.h"

@interface ATShareHouseViewModel()

//存放发布的房源信息
@property(nonatomic, strong) NSMutableArray *shareHouseSections;

@property(nonatomic, strong) ATShareHouseJsonModel *shareHouseJM;

@property(nonatomic, copy) NSString *rightIcon;
@property(nonatomic, copy) NSString *rentType;

@end

@implementation ATShareHouseViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.shareHouseJM = [[ATShareHouseJsonModel alloc] init];
        self.shareHouseSections = [NSMutableArray array];
        self.rightIcon = @"cellRightArrow";
    }
    return  self;
}

- (void) loadBaseCellInfo {
    [self housePictures:nil];
    [self location];
    [self geographyInfo];
    [self houseConfiguration];
    [self handoverRent];
    [self onHireDuration];
    [self retenrRequire];
    [self detailDescribe];
}

- (NSMutableArray *) getShareHouseSections {
    return  self.shareHouseSections;
}

+ (instancetype) shareHouseVM {
    ATShareHouseViewModel *shareHouseVM = [[ATShareHouseViewModel alloc] init];
    return shareHouseVM;
}

//+ (NSMutableArray *) indexs:(NSMutableArray *)indexs datas:(NSMutableArray *)datas {
//    NSMutableArray *results = [NSMutableArray array];
//    for (id index in indexs) {
//        [results addObject: [datas objectAtIndex:[NSInteger int]]];
//    }
//    
//    return results;
//}

- (NSString *)getRentType {
    return self.rentType;
}

- (void)rentTypes:(NSMutableArray *) types {
    NSString *typeStr = @"";
    for (NSString *type in types) {
        if ([type isEqualToString:@"整租"] || [type isEqualToString:@"合租"]) {
            self.shareHouseJM.rent = type;
            typeStr = type;
        }else {
            typeStr = [[NSString alloc] initWithFormat:@"%@(%@)", typeStr, type];
        }
        
    }
    self.rentType = typeStr;
    ATShareHouseModel *shareHouseM = [ATShareHouseModel initWithFunctionTitle:@"租住类型" andHouseInfo:typeStr icon:nil cellStyle: @"ATShareHouseCellView"];
    ATShareHouseSectionsModel *shareHouseSectionsM = [ATShareHouseSectionsModel initWithTitle:nil andDescribe:nil andHousesInfo:[NSMutableArray arrayWithObjects:shareHouseM, nil]];
    [self.shareHouseSections addObject:shareHouseSectionsM];
}

- (void)housePictures:(NSMutableArray *) pictures {
//    if (pictures.count > 0) {
        ATShareHouseModel *shareHouseM = [ATShareHouseModel initWithFunctionTitle:nil andHouseInfo:@"最多添加9张图片" icon:nil  cellStyle: @"ATCollectionCellView"];
        ATShareHouseSectionsModel *shareHouseSectionsM = [ATShareHouseSectionsModel initWithTitle:@"房源图片" andDescribe:nil andHousesInfo:[NSMutableArray arrayWithObjects:shareHouseM, nil]];
        [self.shareHouseSections addObject:shareHouseSectionsM];
//    }else { return; }
}

- (void) location {
    ATShareHouseModel *shareHouseM = [ATShareHouseModel initWithFunctionTitle:@"地区" andHouseInfo:nil  icon:self.rightIcon cellStyle: @"ATShareCellView"];
    ATShareHouseSectionsModel *shareHouseSectionsM = [ATShareHouseSectionsModel initWithTitle:nil andDescribe:nil andHousesInfo:[NSMutableArray arrayWithObjects:shareHouseM, nil]];
    [self.shareHouseSections addObject:shareHouseSectionsM];
}

- (void) geographyInfo {
    ATShareHouseModel *shareHouseM_floor = [ATShareHouseModel initWithFunctionTitle:@"楼层/总楼层" andHouseInfo:nil icon:self.rightIcon cellStyle: @"ATShareCellView"];
    ATShareHouseModel *shareHouseM_houseType = [ATShareHouseModel initWithFunctionTitle:@"户型" andHouseInfo:nil icon:self.rightIcon cellStyle: @"ATShareCellView"];
    ATShareHouseModel *shareHouseM_orientation = [ATShareHouseModel initWithFunctionTitle:@"朝向" andHouseInfo:nil icon:self.rightIcon cellStyle: @"ATShareCellView"];
    ATShareHouseModel *shareHouseM_decorated = [ATShareHouseModel initWithFunctionTitle:@"装修" andHouseInfo:nil icon:self.rightIcon cellStyle: @"ATShareCellView"];
    ATShareHouseModel *shareHouseM_area = [ATShareHouseModel initWithFunctionTitle:@"面积" andHouseInfo:nil icon:@"㎡" cellStyle: @"ATShareWriteCellView"];
    ATShareHouseSectionsModel *shareHouseSectionsM = [ATShareHouseSectionsModel initWithTitle:nil andDescribe:nil andHousesInfo:[NSMutableArray arrayWithObjects:shareHouseM_floor, shareHouseM_houseType, shareHouseM_orientation, shareHouseM_decorated, shareHouseM_area, nil]];
    [self.shareHouseSections addObject:shareHouseSectionsM];
}

- (void) houseConfiguration {
    ATShareHouseModel *shareHouseM_configuration = [ATShareHouseModel initWithFunctionTitle:@"房屋配置" andHouseInfo:nil icon:self.rightIcon cellStyle: @"ATShareCellView"];
    ATShareHouseSectionsModel *shareHouseSectionsM = [ATShareHouseSectionsModel initWithTitle:nil andDescribe:nil andHousesInfo:[NSMutableArray arrayWithObjects:shareHouseM_configuration, nil]];
    [self.shareHouseSections addObject:shareHouseSectionsM];
}

- (void) handoverRent {
    ATShareHouseModel *shareHouseM_rent = [ATShareHouseModel initWithFunctionTitle:@"房租" andHouseInfo:nil icon:@"元/月" cellStyle: @"ATShareWriteCellView"];
    ATShareHouseModel *shareHouseM_paymentWays = [ATShareHouseModel initWithFunctionTitle:@"付款方式" andHouseInfo:nil icon:self.rightIcon cellStyle: @"ATShareCellView"];
    ATShareHouseSectionsModel *shareHouseSectionsM = [ATShareHouseSectionsModel initWithTitle:nil andDescribe:nil andHousesInfo:[NSMutableArray arrayWithObjects:shareHouseM_rent, shareHouseM_paymentWays,nil]];
    [self.shareHouseSections addObject:shareHouseSectionsM];
}


- (void) onHireDuration {
    ATShareHouseModel *shareHouseM_onHireDuration = [ATShareHouseModel initWithFunctionTitle:@"起租时长" andHouseInfo:nil icon:self.rightIcon cellStyle: @"ATShareCellView"];
    ATShareHouseSectionsModel *shareHouseSectionsM = [ATShareHouseSectionsModel initWithTitle:nil andDescribe:nil andHousesInfo:[NSMutableArray arrayWithObjects:shareHouseM_onHireDuration, nil]];
    [self.shareHouseSections addObject:shareHouseSectionsM];
}

- (void) retenrRequire {
    ATShareHouseModel *shareHouseM_retenrRequire = [ATShareHouseModel initWithFunctionTitle:@"对租客要求" andHouseInfo:@"无" icon:self.rightIcon cellStyle: @"ATShareCellView"];
    ATShareHouseSectionsModel *shareHouseSectionsM = [ATShareHouseSectionsModel initWithTitle:nil andDescribe:nil andHousesInfo:[NSMutableArray arrayWithObjects:shareHouseM_retenrRequire, nil]];
    [self.shareHouseSections addObject:shareHouseSectionsM];
}

- (void) detailDescribe {
    ATShareHouseModel *shareHouseM_detailDescribe = [ATShareHouseModel initWithFunctionTitle:@"详细描述" andHouseInfo:nil icon:self.rightIcon cellStyle: @"ATTextViewCellView"];
    ATShareHouseSectionsModel *shareHouseSectionsM = [ATShareHouseSectionsModel initWithTitle:nil andDescribe:nil andHousesInfo:[NSMutableArray arrayWithObjects:shareHouseM_detailDescribe, nil]];
    [self.shareHouseSections addObject:shareHouseSectionsM];
}


@end
