//
//  ATTypesViewCell.h
//  AnnTenants
//
//  Created by HuangGang on 2018/4/14.
//  Copyright © 2018年 Harely. All rights reserved.
// 按钮多选：https://www.cnblogs.com/xiaopin/p/6565260.html

#import <UIKit/UIKit.h>
@class ATTypeCellViewModel;

@interface ATTypesCellView : UITableViewCell

- (void)bindViewModel:(ATTypeCellViewModel *)viewModel;

@end
