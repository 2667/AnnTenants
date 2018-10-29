//
//  ATHomePageController.h
//  AnnTenants
//
//  Created by HuangGang on 2018/4/28.
//  Copyright © 2018年 Harely. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, ATHomePageType) {
    ATHomePageTypeHomepage = 0,  //
    ATHomePageTypeCollect = 1,
    ATHomePageTypeReservation  = 2,
    ATHomePageTypeSubscribe = 3,  //订阅
    ATHomePageTypePublishHouse = 4
};

@interface ATHomePageController : UITableViewController
{
    BOOL _isCollect;
}

@property(nonatomic, strong) NSMutableArray *collects;
@property(nonatomic, assign) ATHomePageType hompageType;

@end
