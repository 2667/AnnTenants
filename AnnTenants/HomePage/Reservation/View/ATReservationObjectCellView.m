//
//  ATReservationObjectCellView.m
//  AnnTenants
//
//  Created by HuangGang on 2018/5/3.
//  Copyright © 2018年 Harely. All rights reserved.
//

#import "ATReservationObjectCellView.h"

@interface ATReservationObjectCellView()
{
    BOOL isReservation;
}

@property(nonatomic,strong) UIImageView *headPortrait;
@property(nonatomic, strong) UILabel *nickName;
@property(nonatomic, strong) UIImageView *unReservation;
@property (nonatomic, strong) UILabel *reservation;

@end

@implementation ATReservationObjectCellView

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    UIView *line = [UIView new];
    line.backgroundColor = ATMainTonalColor;
    UILabel *reservationInfo = [ATRoomInfoCellView createLabel:@"预约对象" fontSize:14.0 fontColor:ATRGBA(171, 179, 186, 1.0)];
    
    
    [self.contentView addSubview:line];
    [self.contentView addSubview:reservationInfo];
    [self.contentView addSubview: self.headPortrait];
    [self.contentView addSubview:self.nickName];
    [self.contentView addSubview:self.unReservation];
    
    
    line.frame = CGRectMake(15, 15, 1, 12);
    reservationInfo.frame = CGRectMake(20, 15, 70, 12);
    self.headPortrait.frame = CGRectMake(15, 40, 36, 36);
    self.nickName.frame = CGRectMake(60, 40, 90, 36);
    self.unReservation.frame = CGRectMake(ATSCREEN_WIDTH - 22 - 15, 47, 22, 22);
}

//- (void)bindMyModel:(ATMyHeadModel *)myM  withReservationModel:(ATReservationModel *) reservationModel
- (void) bindModel:(ATMyHeadModel *) myHeadM {
    self.headPortrait.image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@%@",ATDocumentPath,myHeadM.avatarPath]];
    self.nickName.text = myHeadM.nickName;
    
//    if (![ATTools isBlankString:reservationModel.isPrecontract]) {
//        self.reservation.text = @"您已预约过";
//    }else {
        self.unReservation.image = [UIImage imageNamed:@"radioButtonSelect"];
//    }
    
}

- (UIImageView *)headPortrait {
    if (!_headPortrait) {
        _headPortrait = [UIImageView new];
        _headPortrait.layer.masksToBounds = YES;
        _headPortrait.layer.cornerRadius = 18.0;
    }
    return _headPortrait;
}

- (UILabel *)nickName {
    if (!_nickName) {
        _nickName = [ATRoomInfoCellView createLabel:nil fontSize:16.0 fontColor:[UIColor blackColor]];
        _nickName.textAlignment = NSTextAlignmentCenter;
    }
    return _nickName;
}

- (UIImageView *)unReservation {
    if (!_unReservation) {
        _unReservation = [UIImageView new];

    }
    return _unReservation;
}

@end
