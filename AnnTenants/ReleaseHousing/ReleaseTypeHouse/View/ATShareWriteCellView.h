//
//  ATShareWriteCellView.h
//  AnnTenants
//
//  Created by HuangGang on 2018/4/17.
//  Copyright © 2018年 Harely. All rights reserved.
//

#import <UIKit/UIKit.h>

//@protocol ShareWriteCellDelegate
//
//@optional
//- (void)reverseTransferOfValue:(NSString *) writeValue;
//@end

@interface ATShareWriteCellView : UITableViewCell

@property(nonatomic, strong) UITextField *write;
//@property(nonatomic, weak) id<ShareWriteCellDelegate> delegate;

- (void)bindViewModel:(ATShareHouseModel *) shareHouseVM;

+ (CGFloat)heightWithModel;

@end
