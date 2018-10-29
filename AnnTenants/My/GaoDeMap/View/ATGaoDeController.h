//
//  ATGaoDeController.h
//  AnnTenants
//
//  Created by HuangGang on 2018/5/12.
//  Copyright © 2018年 Harely. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapLocationKit/AMapLocationKit.h>

@interface ATGaoDeController : UIViewController

@property(nonatomic, strong) MAMapView *mapView;
@property(nonatomic, strong) AMapLocationManager *locationManager;

@end
