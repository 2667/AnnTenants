//
//  ATCollectionCellView.h
//  AnnTenants
//
//  Created by HuangGang on 2018/4/24.
//  Copyright © 2018年 Harely. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ATCollectionCellView : UITableViewCell

- (void)setControlelr:(ATPublishSharedHouseController *)controller;
- (void)bindViewModel:(ATShareHouseModel *) shareHouseVM;

@end
