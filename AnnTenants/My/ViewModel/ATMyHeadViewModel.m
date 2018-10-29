//
//  ATMyHeadViewModel.m
//  AnnTenants
//
//  Created by HuangGang on 2018/4/11.
//  Copyright © 2018年 Harely. All rights reserved.
//

#import "ATMyHeadViewModel.h"

@implementation ATMyHeadViewModel

+ (void) saveHeadPortrait:(UIImage *)headImage withName:(NSString *)name {
    NSString *unarchiverImagePath = [ATTools unarchiveImageDirectory:@""];
    [ATTools deleteImageWith:unarchiverImagePath];
    
    NSString *imagePath = [ATTools saveImageWithName:name withImage:headImage];
    
    ATMyHeadModel *headM = [ATMyHeadModel new];
    headM.avatarPath = imagePath;
    WZLSERIALIZE_ARCHIVE(headM, @"ATMyHeadModel", [ATUserManager filePath]);
    [ATSQLiteManager updateData:@"avatarPath" values:imagePath fromDatabase: @"user"  conditions: [NSString stringWithFormat:@"userId = '%@'", headM.userId]];
}

+ (NSDictionary *) readHeadPortrait {
    ATMyHeadModel * headM = nil;
    NSString *unPath = [ATUserManager filePath];
    
    WZLSERIALIZE_UNARCHIVE(headM, @"ATMyHeadModel", unPath);
    NSString *imagePath = [NSString stringWithFormat:@"%@%@", ATDocumentPath, headM.avatarPath];
    NSString *nickName = headM.nickName;
    UIImage *headImage = [UIImage imageWithContentsOfFile: imagePath];
    if (headImage == nil) {
        headImage = [UIImage imageNamed:@"headPortrait"];
    }
    if (nickName == nil) {
        nickName = @"匿名";
    }
    return @{@"headImage": headImage, @"nickName": nickName};
}
@end
