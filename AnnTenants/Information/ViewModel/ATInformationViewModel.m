//
//  ATInformationModel.m
//  AnnTenants
//
//  Created by HuangGang on 2018/5/5.
//  Copyright © 2018年 Harely. All rights reserved.
//

#import "ATInformationModel.h"

@implementation ATInformationViewModel

+(NSMutableArray *) getInformationModel {
    NSMutableArray *infoModels = [NSMutableArray array];
    
    NSString *keys = @"informationID, imageName, mainTitle, abstract, url";
    NSString *table = @"message";
    NSString *condition = @"informationID is not null";
    NSArray *infos = [ATSQLiteManager selectData:keys fromDatabase:table conditions:condition];
    
    for (NSDictionary *dic in infos) {
        ATInformationModel *informationM = [ATInformationModel new];
        
        informationM.informationID = dic[@"informationID"];
        informationM.imageName = [NSString stringWithFormat:@"%@.png", dic[@"imageName"]];
        informationM.mainTitle = dic[@"mainTitle"];
        informationM.abstract = dic[@"abstract"];
        informationM.url = dic[@"url"];
        [infoModels addObject:informationM];
    }
    return infoModels;
}

@end
