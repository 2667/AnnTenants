//
//  ATReleaseViewModel.m
//  AnnTenants
//
//  Created by HuangGang on 2018/4/14.
//  Copyright © 2018年 Harely. All rights reserved.
//

#import "ATReleaseViewModel.h"

@implementation ATReleaseViewModel

+ (NSMutableArray *)houseTypes {
    ATTypeCellViewModel *typeVM1 = [ATTypeCellViewModel new];
    typeVM1.type = @"整租";
    typeVM1.isSelected = YES;
    
    ATTypeCellViewModel *typeVM2 = [ATTypeCellViewModel new];
    typeVM2.type = @"合租";
    typeVM2.isSelected = FALSE;
    
    ATTypeCellViewModel *typeVM3 = [ATTypeCellViewModel new];
    typeVM3.type = @"非转租";
    typeVM3.isSelected = YES;
    
    ATTypeCellViewModel *typeVM4 = [ATTypeCellViewModel new];
    typeVM4.type = @"转租";
    typeVM4.isSelected = FALSE;
    
    NSMutableArray *rent_one = [[NSMutableArray alloc]initWithObjects:typeVM1, typeVM2,nil];
    NSMutableArray *rent_two = [[NSMutableArray alloc]initWithObjects:typeVM3, typeVM4,nil];
    NSMutableArray *rent_hole = [[NSMutableArray alloc] init];
    [rent_hole addObject:rent_one];
    [rent_hole addObject:rent_two];
    
    return rent_hole;

}

+ (NSMutableArray *)getHouseTypes:(NSMutableArray *)houseTypes {
    NSMutableArray *houseType = [NSMutableArray array];
    for (NSMutableArray *typeCellVMs in houseTypes) {
        for (ATTypeCellViewModel *typeVM in typeCellVMs) {
            if (typeVM.isSelected) {
                [houseType addObject:typeVM.type];
            }
        }
    }
    return houseType;
}

@end
