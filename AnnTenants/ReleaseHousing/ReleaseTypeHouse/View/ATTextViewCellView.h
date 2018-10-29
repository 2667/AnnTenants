//
//  ATTextViewCellView.h
//  AnnTenants
//
//  Created by HuangGang on 2018/4/24.
//  Copyright © 2018年 Harely. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ATTextViewCellView : UITableViewCell
@property(nonatomic, strong) UITextView *write;


- (void)bindViewModel:(ATShareHouseModel *) shareHouseVM;

+ (CGFloat)heightWithModel;
@end
