//
//  ATShareHouseJModel.h
//  AnnTenants
//
//  Created by HuangGang on 2018/4/15.
//  Copyright © 2018年 Harely. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface ATShareHouseJsonModel : JSONModel

+ (NSDictionary *) getSectionTitle;

@property(nonatomic, strong) NSString *houseingResourceID;
@property(nonatomic, strong) NSString *userId;
//租住类型
@property(nonatomic, strong) NSString *rentType;
//房源图片
@property(nonatomic, strong) NSMutableArray *housePictures;     //Ignore属性， 会使得解析时会完全忽略它,<Ignore> *
@property(nonatomic, strong) NSString *housePicturesPath;
//小区
@property(nonatomic, strong) NSString *location;
//楼层/总楼层
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
//对租客要求
@property(nonatomic, strong) NSString *renterRequire;
//详细描述
@property(nonatomic, strong) NSString *detailDescribe;
//发布时间
@property(nonatomic, strong) NSString *publishTime;


@end
