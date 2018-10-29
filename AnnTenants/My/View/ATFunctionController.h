//
//  ATFunctionController.h
//  AnnTenants
//
//  Created by HuangGang on 2018/5/5.
//  Copyright © 2018年 Harely. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, ATFunctionType) {
    ATFunctionTypeVersionNumber = 0,
    ATFunctionTypeContactUs = 1,
};

@interface ATFunctionController : UIViewController

@property(nonatomic, assign) ATFunctionType functionType;

@end
