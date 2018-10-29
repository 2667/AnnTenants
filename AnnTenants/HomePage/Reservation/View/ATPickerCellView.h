//
//  ATPickerCellView.h
//  AnnTenants
//
//  Created by HuangGang on 2018/5/3.
//  Copyright © 2018年 Harely. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ATPickerCellView : UITableViewCell

//@property(nonatomic, copy) void(^selectValue)(NSMutableArray *values);
@property(nonatomic, strong) NSMutableArray *selectValues;

@property(nonatomic, strong) ATReservationController *rc;
@property(nonatomic, strong) UIPickerView *pickerView;

@end
