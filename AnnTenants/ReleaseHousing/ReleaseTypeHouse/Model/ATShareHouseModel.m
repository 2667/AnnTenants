//
//  ATShareHouseModel.m
//  AnnTenants
//
//  Created by HuangGang on 2018/4/16.
//  Copyright © 2018年 Harely. All rights reserved.
//

#import "ATShareHouseModel.h"

@implementation ATShareHouseModel

- (ATShareHouseModel *)initWithFunctionTitle:(NSString *)funcitonTitle andHouseInfo:(NSString *)houseInfo icon:(NSString *)iconName cellStyle:(NSString *) cellStyle {
    self = [super init];
    if (self) {
        self.functionTitle = funcitonTitle;
        self.houseInfo= houseInfo;
        self.iconName = iconName;
        self.cellStyle = cellStyle;
    }
    return self;
}

+ (ATShareHouseModel *) initWithFunctionTitle:(NSString *)funcitonTitle andHouseInfo:(NSString *)houseInfo icon:(NSString *)iconName cellStyle:(NSString *) cellStyle {
    ATShareHouseModel * shareHouseM = [[ATShareHouseModel alloc] initWithFunctionTitle:funcitonTitle andHouseInfo:houseInfo icon:iconName cellStyle:cellStyle];
    return shareHouseM;
}

//在 number 层，共 number 层
- (NSMutableArray *) PickerViewForfloors {
    NSMutableArray *floor_one = [NSMutableArray arrayWithObject:@"在"];
    NSMutableArray *floor_two = [NSMutableArray array];
    for (int i = 0; i <= 100; i ++) {
        [floor_two addObject:[NSString stringWithFormat:@"%d",i]];
    }
    NSMutableArray *floor_three = [NSMutableArray arrayWithObject:@"层,共"];
    NSMutableArray *floor_four = [NSMutableArray array];
    for (int i = 0; i <= 100; i ++) {
        [floor_four addObject:[NSString stringWithFormat:@"%d",i]];
    }
    NSMutableArray *floor_five = [NSMutableArray arrayWithObject:@"层"];
    NSMutableArray *totalArrays = [NSMutableArray arrayWithObjects:floor_one, floor_two, floor_three, floor_four, floor_five, nil];
    
    return totalArrays;
}
 
//number 室 number 厅 number 卫
- (NSMutableArray *) PickerViewForHouseTypes {
    
    NSMutableArray *floor_one = [NSMutableArray array];
    for (int i = 1; i < 10; i ++) {
        [floor_one addObject:[NSString stringWithFormat:@"%d",i]];
    }
    
    NSMutableArray *floor_two = [NSMutableArray arrayWithObject:@"室"];
    
    NSMutableArray *floor_three = [NSMutableArray array];
    for (int i = 1; i < 10; i ++) {
        [floor_three addObject:[NSString stringWithFormat:@"%d",i]];
    }
    
    NSMutableArray *floor_four = [NSMutableArray arrayWithObject:@"厅"];
    
    NSMutableArray *floor_five = [NSMutableArray array];
    for (int i = 1; i < 10; i ++) {
        [floor_five addObject:[NSString stringWithFormat:@"%d",i]];
    }
    
    NSMutableArray *floor_six = [NSMutableArray arrayWithObject:@"卫"];

    NSMutableArray *totalArrays = [NSMutableArray arrayWithObjects:floor_one, floor_two, floor_three, floor_four, floor_five, floor_six, nil];
    
    return totalArrays;
}
 
- (NSArray *) districts {
    NSArray *array = nil;
    return array;
}
    
 - (NSArray *) orientations {
    NSArray *array = @[@"南北", @"东西", @"东北", @"东南", @"西北", @"西南", @"东", @"西", @"南", @"北"];
    return array;
}

- (ShareHouseModelStruct) decorationStruct {
    NSArray *array = @[@"毛坯", @"普通装修", @"精装修", @"豪华装修"];
    ShareHouseModelStruct shms = ShareHouseModelStructMake(@"装修", 0, array);
    return shms;///< 0x608000241620>
}

- (NSArray *) decorations {
   NSArray *array = @[@"毛坯", @"普通装修", @"精装修", @"豪华装修"];
   return array;
}

- (NSArray *) houseConfigurations {
    NSArray *array = @[@"空调", @"单人床", @"双人床", @"梳妆台", @"写字台", @"衣柜", @"冰箱", @"洗衣机", @"沙发", @"阳台", @"卫生间", @"厨房", @"飘窗", @"热水器", @"宽带"];
    return array;
}
    
- (NSArray *) paymentWays {
    NSArray *array = @[@"付三押一", @"付二押一", @"付一押一", @"付三押二", @"付二押二", @"付一押二", @"半年付", @"整年付", @"付一押零"];
    return array;
}
    
//不限/ number 个月   起租
- (NSMutableArray *) PickerViewForOnHireDuration {
    NSMutableArray *floor_one = [NSMutableArray arrayWithObjects:@"不限",@"1个月",@"2个月",@"3个月",@"4个月",@"5个月",@"6个月",@"7个月",@"8个月",@"9个月", @"10个月", @"11个月", @"12个月", nil];

    NSMutableArray *floor_two = [NSMutableArray arrayWithObject:@"起租"];
    
    NSMutableArray *totalArrays = [NSMutableArray arrayWithObjects:floor_one, floor_two, nil];
    
    return totalArrays;
}
    
- (NSArray *) retenrRequires {
    NSArray *array = @[@"作息规律", @"爱干净", @"不吸烟", @"不喝酒", @"单身", @"已婚", @"单人住", @"双人住", @"女生", @"男生"];
    return array;
}
    
    

@end
