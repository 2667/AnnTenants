//
//  ATCityPlist.m
//  AnnTenants
//
//  Created by HuangGang on 2018/4/8.
//  Copyright © 2018年 Harely. All rights reserved.
//

#import "ATCityPlist.h"

@implementation ATCityPlist

+ (NSString *) createPlistDocument {
    NSString *plistPath = [ATDocumentPath stringByAppendingPathComponent:@"ProvincesAndCities.plist"];
    return plistPath;
}



@end
