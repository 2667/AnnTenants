//
//  ATMyHeadViewModel.h
//  AnnTenants
//
//  Created by HuangGang on 2018/4/11.
//  Copyright © 2018年 Harely. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ATMyHeadViewModel : NSObject

//存储头像
+ (void)saveHeadPortrait:(UIImage *)headImage withName:(NSString *)name;
//获取头像
+ (NSDictionary *) readHeadPortrait;




@end
