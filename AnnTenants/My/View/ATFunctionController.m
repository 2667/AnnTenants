//
//  ATFunctionController.m
//  AnnTenants
//
//  Created by HuangGang on 2018/5/5.
//  Copyright © 2018年 Harely. All rights reserved.
//

#import "ATFunctionController.h"

@interface ATFunctionController ()

@end

@implementation ATFunctionController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self layoutOfSubViews:self.functionType];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.tabBarController.tabBar.hidden = NO;
}

- (void) layoutOfSubViews:(ATFunctionType) functionType {
    switch (functionType) {
        case ATFunctionTypeVersionNumber:{
            self.view.backgroundColor = [UIColor whiteColor];
            self.title = @"版本";
            [self.view addSubview:[ATFunctionController versionNumberView]];
                break;
        }
        case ATFunctionTypeContactUs:{
            self.view.backgroundColor = [UIColor whiteColor];
            self.title = @"联系方式";
            [self.view addSubview:[ATFunctionController contantUs]];
            break;
        }
            
        default:
            break;
    }
}

+ (UIView *)versionNumberView {
    CGFloat versionX = 20;
    CGFloat versionW = ATSCREEN_WIDTH - 20 *2;
    CGFloat versionY = (ATSCREEN_HEIGHT - versionW) / 2;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(versionX, versionY, versionW, versionW)];
    
    CGFloat controlX = (view.frame.size.width - 60)/2;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(controlX, 70, 60, 60)];
    imageView.layer.cornerRadius = 5.0f;
    imageView.layer.masksToBounds = YES;
    imageView.image = [UIImage imageNamed:@"icon"];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((view.frame.size.width - 100)/2, 150, 100, 15)];
    label.text = @"版本号 2.0.0";
    label.textAlignment = NSTextAlignmentCenter;
    [label setTextColor:ATRGBA(143, 143, 143, 1.0)];
    
    
    
    [view addSubview:imageView];
    [view addSubview:label];
    return view;
}

+ (UIView *) contantUs {
    CGFloat versionX = 20;
    CGFloat versionW = ATSCREEN_WIDTH - 20 *2;
    CGFloat versionY = (ATSCREEN_HEIGHT - versionW) / 2;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(versionX, versionY, versionW, versionW)];
    
    UILabel *contact = [[UILabel alloc] initWithFrame:CGRectMake((view.frame.size.width - 100)/2, 50, 100, 15)];
    contact.text = @"联系方式";
    contact.font = [UIFont systemFontOfSize:18.0];
    contact.textAlignment = NSTextAlignmentCenter;
    [contact setTextColor:ATRGBA(143, 143, 143, 1.0)];
    [view addSubview:contact];
    
    
    UIView *xinLang = [ATFunctionController initWithFrame:CGRectMake(0, 100, view.frame.size.width, 30) customViewOfName:@"官方微博" content:@"安居客AnJuKe"];
    [view addSubview:xinLang];
    
    UIView *web = [ATFunctionController initWithFrame:CGRectMake(0, 140, view.frame.size.width, 30) customViewOfName:@"官方网站" content:@"anjuke.com"];
    [view addSubview:web];
    
    UIView *contactOne = [[UIView alloc] initWithFrame:CGRectMake(0, 180, view.frame.size.width, 30)];
    contactOne.layer.borderColor = ATMainTonalColor.CGColor;
    contactOne.layer.borderWidth = 1.0f;
    contactOne.layer.cornerRadius = 15.0f;
    contactOne.layer.masksToBounds = YES;
    UILabel *labelOne = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 80, 30)];
    [labelOne setTextColor:ATMainTonalColor];
    labelOne.text = @"微信公众号";
    labelOne.textAlignment = NSTextAlignmentLeft;
    labelOne.font = [UIFont systemFontOfSize:12.0];
    UILabel *lableTwo = [[UILabel alloc] initWithFrame:CGRectMake(contactOne.frame.size.width - 110, 0, 100, 30)];
    [lableTwo setTextColor:ATMainTonalColor];
    lableTwo.text = @"安居客AnJuKe";
    lableTwo.textAlignment = NSTextAlignmentRight;
    lableTwo.font = [UIFont systemFontOfSize:12.0];
    [contactOne addSubview:labelOne];
    [contactOne addSubview:lableTwo];
    
    UIView *contactTwo = [[UIView alloc] initWithFrame:CGRectMake(0, 220, view.frame.size.width, 30)];
    contactTwo.layer.borderColor = ATMainTonalColor.CGColor;
    contactTwo.layer.borderWidth = 1.0f;
    contactTwo.layer.cornerRadius = 15.0f;
    contactTwo.layer.masksToBounds = YES;
    UILabel *labelA = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 80, 30)];
    [labelA setTextColor:ATMainTonalColor];
    labelA.text = @"客服电话";
    labelA.textAlignment = NSTextAlignmentLeft;
    labelA.font = [UIFont systemFontOfSize:12.0];
    UILabel *lableB = [[UILabel alloc] initWithFrame:CGRectMake(contactOne.frame.size.width - 110, 0, 100, 30)];
    [lableB setTextColor:ATMainTonalColor];
    lableB.text = @"400-8786-888";
    lableB.textAlignment = NSTextAlignmentRight;
    lableB.font = [UIFont systemFontOfSize:12.0];
    [contactTwo addSubview:labelA];
    [contactTwo addSubview:lableB];
    
    [view addSubview:contactOne];
    [view addSubview:contactTwo];
    
    return view;
    
}


+ (UIView *) initWithFrame:(CGRect )frame customViewOfName:(NSString *) name  content:(NSString *)content {
    UIView *contactOne = [[UIView alloc] initWithFrame:frame];
    contactOne.layer.borderColor = ATMainTonalColor.CGColor;
    contactOne.layer.borderWidth = 1.0f;
    contactOne.layer.cornerRadius = 15.0f;
    contactOne.layer.masksToBounds = YES;
    UILabel *labelOne = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 80, 30)];
    [labelOne setTextColor:ATMainTonalColor];
    labelOne.text = name;
    labelOne.textAlignment = NSTextAlignmentLeft;
    labelOne.font = [UIFont systemFontOfSize:12.0];
    UILabel *lableTwo = [[UILabel alloc] initWithFrame:CGRectMake(contactOne.frame.size.width - 110, 0, 100, 30)];
    [lableTwo setTextColor:ATMainTonalColor];
    lableTwo.text = content;
    lableTwo.textAlignment = NSTextAlignmentRight;
    lableTwo.font = [UIFont systemFontOfSize:12.0];
    [contactOne addSubview:labelOne];
    [contactOne addSubview:lableTwo];
    
    return contactOne;
}


@end
