//
//  ATPublishSharedHouseController.h
//  AnnTenants
//
//  Created by HuangGang on 2018/4/14.
//  Copyright © 2018年 Harely. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ATShareHouseViewModel;

@interface ATPublishSharedHouseController : UITableViewController

@property(nonatomic, strong) ATShareHouseViewModel *shareHouseVM;
@property(nonatomic, strong) NSMutableArray *pictures;

@end
