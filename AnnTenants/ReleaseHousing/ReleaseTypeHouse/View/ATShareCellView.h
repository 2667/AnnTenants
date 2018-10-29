//
//  ATShareCellView.h
//  AnnTenants
//
//  Created by HuangGang on 2018/4/16.
//  Copyright © 2018年 Harely. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ATShareCellView : UITableViewCell

@property(nonatomic, strong) UILabel *houseInfoDetail;


- (void)bindViewModel:(ATShareHouseModel *) shareHouseVM;

+ (CGFloat)heightWithModel;

@end
