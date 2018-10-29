//
//  ATInformationModel.h
//  AnnTenants
//
//  Created by HuangGang on 2018/5/5.
//  Copyright © 2018年 Harely. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface ATInformationModel : JSONModel

@property(nonatomic, strong) NSString *imageName;
@property(nonatomic, strong) NSString *mainTitle;
@property(nonatomic, strong) NSString *abstract;
@property(nonatomic, strong) NSString *url;
@property(nonatomic, strong) NSString *informationID;

@end
