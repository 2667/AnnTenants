//
//  ATShareHouseCellView.m
//  AnnTenants
//
//  Created by HuangGang on 2018/4/16.
//  Copyright © 2018年 Harely. All rights reserved.
//

#import "ATShareHouseCellView.h"

@interface ATShareHouseCellView()

@property(nonatomic, strong) UILabel *sectionTitle;
@property(nonatomic, strong) UIImageView *backImage;
@property(nonatomic, strong) UILabel *houseInfoDetail;

@end

@implementation ATShareHouseCellView

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        [self layoutOfTheControls];
    }
    return self;
}

//由于cell的布局特殊化，所有约束条件都在layoutSubviews方法中写
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.contentView addSubview:self.sectionTitle];
    [self.contentView addSubview:self.houseInfoDetail];
    [self.contentView addSubview:self.backImage];
    
    self.sectionTitle.frame = CGRectMake(15, 10, 70, 25);
    self.houseInfoDetail.frame = CGRectMake(self.frame.size.width-116, 10, 100, 25);
}

- (void)bindViewModel:(ATShareHouseModel *) shareHouseVM {
    self.sectionTitle.text = shareHouseVM.functionTitle;
    self.houseInfoDetail.text = shareHouseVM.houseInfo;
}

//#pragma mark - 获得高度自适应
+ (CGFloat)heightWithModel
{
    ATShareHouseCellView *cell = [[ATShareHouseCellView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ATShareHouseCellView"];
    [cell layoutIfNeeded];//此方法强制立即布局并显示更新,调用 layoutSubviews, 它会自动执行相当于setNeedsLayout的操作
    CGRect frame = cell.sectionTitle.frame;
    CGFloat height = frame.origin.y + frame.size.height + 10;
    return height;
}

- (UILabel *)sectionTitle {
    if (!_sectionTitle) {
        _sectionTitle = [[UILabel alloc] init];
    }
    return _sectionTitle;
}
- (UILabel *)houseInfoDetail {
    if (!_houseInfoDetail) {
        _houseInfoDetail = [[UILabel alloc] init];
    }
    return _houseInfoDetail;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
