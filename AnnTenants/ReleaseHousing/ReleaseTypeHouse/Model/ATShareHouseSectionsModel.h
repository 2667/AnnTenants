//
//  ATShareHouseSectionsModel.h
//  AnnTenants
//
//  Created by HuangGang on 2018/4/15.
//  Copyright © 2018年 Harely. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ATShareHouseSectionsModel : NSObject


//section名字
@property(nonatomic, copy) NSString *sectionTitle;
//section描述
@property(nonatomic, copy) NSString *sectionDescribe;
//房源信息选项
@property(nonatomic, strong) NSMutableArray *sectionHousesInfo;

//带参数的构造函数
- (ATShareHouseSectionsModel *)initWithTitle:(NSString *) title andDescribe:(NSString *)describe andHousesInfo:(NSMutableArray *)housesInfo;
//带参静态初始化方法
+ (ATShareHouseSectionsModel *)initWithTitle:(NSString *) title andDescribe:(NSString *) describe andHousesInfo:(NSMutableArray *)housesInfo;
/*
+ (NSArray *) sectionsTitle;
//租住类型
@property(nonatomic, strong) NSString *rentTypes;
//房源图片
@property(nonatomic, strong) NSString *housePictures;
//楼层
@property(nonatomic, strong) NSString *floor;
//户型
@property(nonatomic, strong) NSString *houseType;
//朝向
@property(nonatomic, strong) NSString *orientation;
//装修
@property(nonatomic, strong) NSString *decorated;
//面积
@property(nonatomic, strong) NSString *area;
//房屋配置
@property(nonatomic, strong) NSString *houseConfiguration;
//房租
@property(nonatomic, strong) NSString *rent;
//付款方式
@property(nonatomic, strong) NSString *paymentWays;
//起租时长
@property(nonatomic, strong) NSString *onHireDuration;
//租客要求
@property(nonatomic, strong) NSString *retenrRequire;
//详细描述
@property(nonatomic, strong) NSString *detailDescribe;
*/
@end
