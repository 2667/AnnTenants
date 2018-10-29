//
//  AppDelegate.m
//  AnnTenants
//
//  Created by HuangGang on 2018/3/9.
//  Copyright © 2018年 Harely. All rights reserved.
//

#import "AppDelegate.h"
#import <AMapFoundationKit/AMapFoundationKit.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame: [UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.window.rootViewController = [ATRootViewController new];
    
//    设置程序启动时，设置的默认值
    [[ATUserManager shareUser] setUserManagerDefaultValue];
//    程序启动时创建表单
    [AppDelegate initializeTables];
    
//    高德地图配置
    [self configureGaoDeAPIKey];
    
    [self.window makeKeyAndVisible];
    return YES;
}

+ (void) initializeTables {
//    创建user表
    [ATSQLiteManager isCreateTableWithType: SQLiteTableTypeUser];
    
//    房源信息表
    [ATSQLiteManager isCreateTableWithType:SQLiteTableTypeHouse];
    
//    收藏表
    [ATSQLiteManager isCreateTableWithType:SQLiteTableTypeCollect];
    
//    预约表
    [ATSQLiteManager isCreateTableWithType:SQLiteTableTypeReservation];
    
//    资讯
    [ATSQLiteManager isCreateTableWithType:SQLiteTableTypeMessage];
}

- (void) configureGaoDeAPIKey {
    if ([GaoDeAPIKey length] == 0) {
        NSString *reason = [NSString stringWithFormat:@"APIKey为空，请申请Key"];
        ATAlertController *gaoDeAlert = [ATAlertController alertWithTitle:@"高德地图提示" message:reason];
        [gaoDeAlert dissMissAlert];
    }
//    开启 HTTPS 功能
    [[AMapServices sharedServices] setEnableHTTPS:YES];
    [AMapServices sharedServices].apiKey = (NSString *)GaoDeAPIKey;
}


- (void)applicationWillResignActive:(UIApplication *)application {
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
}


- (void)applicationWillTerminate:(UIApplication *)application {
}


@end
