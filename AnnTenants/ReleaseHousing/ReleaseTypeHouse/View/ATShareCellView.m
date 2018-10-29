//
//  ATShareCellView.m
//  AnnTenants
//
//  Created by HuangGang on 2018/4/16.
//  Copyright © 2018年 Harely. All rights reserved.
//

#import "ATShareCellView.h"

@interface ATShareCellView()

@property(nonatomic, strong) UILabel *sectionTitle;
@property(nonatomic, strong) UIImageView *backImage;

@end

@implementation ATShareCellView


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) { }
    return self;
}

//由于cell的布局特殊化，所有约束条件都在layoutSubviews方法中写
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.contentView addSubview:self.sectionTitle];
    [self.contentView addSubview:self.houseInfoDetail];
    [self.contentView addSubview:self.backImage];
    
    self.sectionTitle.frame = CGRectMake(15, 10, 100, 25);
    self.houseInfoDetail.frame = CGRectMake(self.frame.size.width-124, 10, 100, 25);
    self.backImage.frame = CGRectMake(self.frame.size.width-22, 10, 20, 25);

}

- (void)bindViewModel:(ATShareHouseModel *) shareHouseVM {
    self.sectionTitle.text = shareHouseVM.functionTitle;
    self.houseInfoDetail.text = shareHouseVM.houseInfo;
    self.backImage.image = [UIImage imageNamed: shareHouseVM.iconName];
}

//#pragma mark - 获得高度自适应
+ (CGFloat)heightWithModel
{
    ATShareCellView *cell = [[ATShareCellView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ATShareHouseCellView"];
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
        _houseInfoDetail.font = [UIFont fontWithName:@"Arial" size:14];
        _houseInfoDetail.textAlignment = NSTextAlignmentRight;
        _houseInfoDetail.numberOfLines = 1;
    }
    return _houseInfoDetail;
}

- (UIImageView *)backImage {
    if (!_backImage) {
        _backImage = [[UIImageView alloc] init];
    }
    return _backImage;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
