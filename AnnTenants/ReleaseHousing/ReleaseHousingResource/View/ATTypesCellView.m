//
//  ATTypesViewCell.m
//  AnnTenants
//
//  Created by HuangGang on 2018/4/14.
//  Copyright © 2018年 Harely. All rights reserved.
//

#import "ATTypesCellView.h"

@interface ATTypesCellView()

@property (nonatomic, strong) UIImageView *selectImage;
@property(nonatomic, strong) UILabel *typeLb;
@property(nonatomic) BOOL isSelected;

@end

@implementation ATTypesCellView

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        [self layoutOfTheControls];
    }
    return self;
}

//自动调用
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.contentView addSubview:self.typeLb];
    self.typeLb.frame = CGRectMake(15, 15, 70, 30);
    [self.contentView addSubview:self.selectImage];
    self.selectImage.frame = CGRectMake(self.frame.size.width - 50, 21, 20, 20);
}

- (void) layoutOfTheControls {
//    [self addSubview:self.typeLb];
//    [self.typeLb mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.contentView);
//        make.top.equalTo(self.contentView).with.offset(40);
//        make.width.equalTo(@185);
//        make.height.equalTo(@38);
//    }];
//    [self.contentView addSubview:self.isRentType];
//    [self.isRentType mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self.contentView).with.offset(13);
//        make.centerX.equalTo(self.contentView);
//    }];
    [self.contentView addSubview:self.typeLb];
    self.typeLb.frame = CGRectMake(15, 15, 70, 30);
    [self.contentView addSubview:self.selectImage];
    self.selectImage.frame = CGRectMake(self.frame.size.width - 50, 21, 20, 20);
}

- (UILabel *)typeLb {
    if (!_typeLb) {
        _typeLb = [[UILabel alloc] init];
    }
    return  _typeLb;
}

- (UIImageView *)selectImage {
    if (!_selectImage) {
        _selectImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"radioButtonUnselect"]];
    }
    return _selectImage;
}

- (void)setIsSelected:(BOOL)isSelected {
    if (isSelected) {
        [self.selectImage setImage:[UIImage imageNamed:@"radioButtonSelect"]];
    }else {
        [self.selectImage setImage:[UIImage imageNamed:@"radioButtonUnselect"]];
    }
}

#pragma mark -依赖注入，使用MVVM的赋值绑定
- (void)bindViewModel:(ATTypeCellViewModel *)viewModel {
    self.typeLb.text = viewModel.type;
    self.isSelected = viewModel.isSelected;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
