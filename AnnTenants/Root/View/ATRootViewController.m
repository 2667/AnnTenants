//
//  ATRootViewController.m
//  AnnTenants
//
//  Created by HuangGang on 2018/3/12.
//  Copyright © 2018年 Harely. All rights reserved.
//UINavigationController 详解：https://www.cnblogs.com/welcometheday/p/4483732.html

//swift样例代码：https://github.com/potato512/SYSwiftLearning
//swift3.0 朝圣之路： https://www.jianshu.com/p/53abf1703905

#import "ATRootViewController.h"

@interface ATRootViewController ()<UITabBarControllerDelegate>

@end

@implementation ATRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [self createTabBarController];
    self.delegate = self;
    
}

- (void)createTabBarController {
    ATHomePageController *hpc = [[ATHomePageController alloc] init];
    ATReleaseHousingController *rhc = [[ATReleaseHousingController alloc] init];
    ATInformationController *ic = [[ATInformationController alloc] init];
    ATMyController *mc = [[ATMyController alloc] init];
    
    //    注意必须两张图片都具有，否则UITabBar不显示图片,类似的属性有字体大小、字体类型等
    [self setTabBarItem:hpc.tabBarItem title:@"首页" titleSize:9.0 titleFontName:@"HeiTi SC" selectedImage:@"homePage" selectedTitleColor:ATMainTonalColor normalImage:@"uhomePage"  normalTitleColor: ATDefaultColor];
    [self setTabBarItem:rhc.tabBarItem title:@"发布房源" titleSize:9.0 titleFontName:@"HeiTi SC" selectedImage:@"releaseHouse" selectedTitleColor:ATMainTonalColor normalImage:@"unreleaseHouse"  normalTitleColor: ATDefaultColor];
    [self setTabBarItem:ic.tabBarItem title:@"资讯" titleSize:9.0 titleFontName:@"HeiTi SC" selectedImage:@"information" selectedTitleColor:ATMainTonalColor normalImage:@"unInformation"  normalTitleColor: ATDefaultColor];
    [self setTabBarItem:mc.tabBarItem title:@"我的" titleSize:9.0 titleFontName:@"HeiTi SC" selectedImage:@"my" selectedTitleColor:ATMainTonalColor normalImage:@"unmy"  normalTitleColor: ATDefaultColor];
    
    UINavigationController *navHpc = [[UINavigationController alloc] initWithRootViewController:hpc];
    UINavigationController *navRhc = [[UINavigationController alloc] initWithRootViewController:rhc];
    UINavigationController *navIc = [[UINavigationController alloc] initWithRootViewController:ic];
    UINavigationController *navMc = [[UINavigationController alloc] initWithRootViewController:mc];
    
    self.viewControllers = @[navHpc, navRhc, navIc, navMc];
}


- (void) setTabBarItem:(UITabBarItem *)tabBarItem title:(NSString *)title titleSize:(CGFloat)size titleFontName:(NSString *)fontName selectedImage:(NSString *)selectedImage selectedTitleColor:(UIColor *)selectColor normalImage:(NSString *)unselectedImage normalTitleColor:(UIColor *)unselectColor {
    //设置图片
    tabBarItem = [tabBarItem initWithTitle:title image:[[UIImage imageNamed:unselectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    // 未选中字体颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:unselectColor,NSFontAttributeName:[UIFont fontWithName:fontName size:size]} forState:UIControlStateNormal];

    // 选中字体颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:selectColor,NSFontAttributeName:[UIFont fontWithName:fontName size:size]} forState:UIControlStateSelected];
}

#pragma mark - UITabBarController 代理方法
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    static NSString *tabBarDidSelectedNotification = @"tabBarDidSelectedNotification";
    //当tabBar被点击时发出一个通知
    [[NSNotificationCenter defaultCenter] postNotificationName:tabBarDidSelectedNotification object:nil userInfo:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
 导航栏（UINavigationBar）的基本概念：
 
 　　　　一个导航控制器包含有四个对象：UINavigationController;UINavigationBar;UIViewController;UINavigationItem;
 
 　　　　其中NavigationItem存放在UINavigationBar上；
 
 　　　　一个视图控制器（UINavigationController）只有一个导航栏（UINavigationBar），却包含若干个视图控制器（UIViewController）；
 
 　　　　UINavigationItem放在UINavigationBar上，但是UINavigationItem不受UINavigationBar的控制，是由每一个视图控制器（UIViewController）来控制它,且一个视图控制器（UIViewController）控制一个UINavigationItem；
 */

@end
