//
//  ATHouseDataViewModel.m
//  AnnTenants
//
//  Created by HuangGang on 2018/4/25.
//  Copyright © 2018年 Harely. All rights reserved.
//

#import "ATHouseDataViewModel.h"

@implementation ATHouseDataViewModel

+ (void) publishHouseInformation:(ATShareHouseJsonModel *) shareHouseJsonModel isSuccess:(void (^) (_Bool isSuccess, NSString *emptyTitle)) isSuccess{
    BOOL isEmpty = FALSE;
    NSDictionary *dict = [ATShareHouseJsonModel getSectionTitle];
    
    NSMutableArray *array = [ATTools getProperties:shareHouseJsonModel];
    [array removeObject:@"detailDescribe"];
    [array removeObject:@"publishTime"];
    [array removeObject:@"renterRequire"];
    [array removeObject:@"housePicturesPath"];
    
    [ATHouseDataViewModel assignHouseIdAndUserIdFromSource:shareHouseJsonModel];
    NSDictionary *dic = [shareHouseJsonModel toDictionary];
    NSLog(@"dic allKeys  count:%@", [dic allKeys]);
    [array removeObjectsInArray:[dic allKeys]];
    
    if (array.count == 0) {
        isEmpty = YES;
    }
    NSMutableString *picturesPath = [ATHouseDataViewModel isWritePicture:isEmpty pictures:shareHouseJsonModel.housePictures];
    shareHouseJsonModel.housePicturesPath = picturesPath;
    shareHouseJsonModel.publishTime = [ATTools currentTimestamp:0];
    if (isEmpty) {
        BOOL isSuccess = [ATSQLiteManager isInsertDataForHouseResource:shareHouseJsonModel];
        if (!isSuccess) {
            ATLog(@"HouseResource 表插入数据错误");
        }
    }
    NSString *emptyTitle = [dict objectForKey:array.firstObject];
    isSuccess(isEmpty, emptyTitle);
}

//赋值houseResourceID和userId
+ (void) assignHouseIdAndUserIdFromSource:(ATShareHouseJsonModel *)shareHouseJsonModel {
    NSString *time = [ATTools currentTimestamp:0];
    NSString *houseResourceID  = [ATTools getSha1String:time];
    shareHouseJsonModel.userId = ATUserManager.shareUser.userId;
    shareHouseJsonModel.houseingResourceID = houseResourceID;
}


//写入图片到指定目录：HousePictures
+ (NSMutableString *) isWritePicture:(BOOL) isWritePicture pictures:(NSMutableArray *) pictures {
    NSMutableString *imagePathStr = [[NSMutableString alloc] initWithCapacity:1];  //可变的字符串
    if (isWritePicture) {
        for (UIImage *image in pictures) {
            NSString *relativePath = [ATTools saveImage:image imageDirectory:@"HousePictures" imageName:nil imageCompressionRatio:1.0];
            [imagePathStr appendFormat:@"%@,", relativePath];
        }
    }
    return imagePathStr;
}

- (ATShareHouseJsonModel *)shareHouseJsonM {
    if (!_shareHouseJsonM) {
        _shareHouseJsonM = [ATShareHouseJsonModel new];
    }
    return _shareHouseJsonM;
}

@end
