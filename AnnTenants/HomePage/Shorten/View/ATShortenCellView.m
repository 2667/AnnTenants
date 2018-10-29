//
//  ATShortenCellView.m
//  AnnTenants
//
//  Created by HuangGang on 2018/4/28.
//  Copyright © 2018年 Harely. All rights reserved.
//

#import "ATShortenCellView.h"

@interface ATShortenCellView()

@property(nonatomic, strong) UIImageView *housePicture;
@property(nonatomic, strong) UILabel *title;
@property(nonatomic, strong) UILabel *area;
@property(nonatomic, strong) UILabel *price;
@property(nonatomic, strong) UILabel *pricePostfix;
@property(nonatomic, strong) UILabel *location;
@property(nonatomic, strong) UILabel *current;
@property(nonatomic, strong) UILabel *deposit;
@property(nonatomic, strong) UILabel *decoration;
@property(nonatomic, strong) UIView *line;

@end

@implementation ATShortenCellView

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    }
    return self;
}

//如果使用layoutSubViews方法，必须加[super layoutSubviews];则无法进入编辑状态
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.contentView addSubview:self.housePicture];
    [self.contentView addSubview:self.title];
    [self.contentView addSubview:self.area];
    [self.contentView addSubview:self.price];
    [self.contentView addSubview:self.pricePostfix];
    [self.contentView addSubview:self.location];
    [self.contentView addSubview:self.current];
    [self.contentView addSubview:self.deposit];
    [self.contentView addSubview:self.decoration];
    [self.contentView addSubview:self.line];
    
    self.housePicture.frame = CGRectMake(15, 15, 120, 105);
    self.title.frame = CGRectMake(145, 15, ATSCREEN_WIDTH - 120, 15);
    self.area.frame = CGRectMake(145, 40, 60, 14);
    self.price.frame = CGRectMake(205, 35, 70, 20);
    self.pricePostfix.frame = CGRectMake(275, 38, 40, 20);
    self.location.frame = CGRectMake(145, 65, ATSCREEN_WIDTH - 120, 15);
    self.current.frame = CGRectMake(145, 85, 65, 15);
    self.deposit.frame = CGRectMake(220, 85, 60, 15);
    self.decoration.frame = CGRectMake(145, 105, 50, 15);
    self.line.frame = CGRectMake(15, 134.5, ATSCREEN_WIDTH - 30, 0.5);
    
    
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIControl * _Nonnull control, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([control isMemberOfClass:NSClassFromString(@"UITableViewCellEditControl")]) {
            
            for (UIView *view in control.subviews) {
                
                if ([view isKindOfClass:[UIImageView class]]) {
                    
                    UIImageView *imageView = (UIImageView *)view;
                    if (self.selected) {
                        //设置选中时的照片
                        imageView.image = [UIImage imageNamed:@"checked"];
                    }else{
                        //设置未选中时的照片
                        imageView.image = [UIImage imageNamed:@"unchecked"];
                    }
                }
            }
        }
    }];
}

- (void) bindModel:(ATShareHouseJsonModel *)shareHouseJosnM {
    self.housePicture.image = shareHouseJosnM.housePictures.firstObject;
    self.title.text = shareHouseJosnM.rentType;
    self.area.text = [NSString stringWithFormat:@"面积·%@㎡",shareHouseJosnM.area];
    self.price.text = shareHouseJosnM.rent;
    self.location.text = [NSString stringWithFormat:@"地区·%@",shareHouseJosnM.location];
    
    NSDate * myDate=[NSDate dateWithTimeIntervalSince1970:[shareHouseJosnM.publishTime doubleValue]];
    //设置时间格式
    NSDateFormatter * formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY/MM/dd"];
    //将时间转换为字符串
    NSString *timeStr=[formatter stringFromDate:myDate];
    self.current.text = timeStr;//shareHouseJosnM.publishTime;
    self.deposit.text = shareHouseJosnM.paymentWays;
    self.decoration.text = shareHouseJosnM.decorated;
}

- (UIImageView *)housePicture {
    if (!_housePicture) {
        _housePicture = [[UIImageView alloc] init];
        _housePicture.layer.masksToBounds = YES;
        _housePicture.layer.cornerRadius = 5.0;
    }
    return _housePicture;
}

- (UILabel *)title {
    if (!_title) {
        _title = [UILabel new];
        _title.font = [UIFont systemFontOfSize:12.0];
    }
    return _title;
}

- (UILabel *)area {
    if (!_area) {
        _area = [UILabel new];
        _area.font = [UIFont systemFontOfSize:10.0];
        [_area setTextColor:ATRGBA(143, 154, 161, 0.8)];
    }
    return  _area;
}

- (UILabel *)price {
    if (!_price) {
        _price = [UILabel new];
        _price.font = [UIFont systemFontOfSize:18.0];
        [_price setTextColor:ATRGBA(134, 213, 106, 1.0)];
        _price.textAlignment = NSTextAlignmentRight;
    }
    return _price;
}

- (UILabel *)pricePostfix {
    if (!_pricePostfix) {
        _pricePostfix = [UILabel new];
        _pricePostfix.text = @"元/月起";
        _pricePostfix.textAlignment = NSTextAlignmentLeft;
        _pricePostfix.font = [UIFont systemFontOfSize:10.0];
        [_pricePostfix setTextColor:ATRGBA(229, 138, 38, 0.9)];
    }
    return _pricePostfix;
}

- (UILabel *)location {
    if (!_location) {
        _location = [UILabel new];
        _location.font = [UIFont systemFontOfSize:10.0];
        [_location setTextColor:ATRGBA(143, 154, 161, 0.8)];
    }
    return _location;
}

- (UILabel *)current {
    if (!_current) {
        _current = [UILabel new];
        _current.font = [UIFont systemFontOfSize:10.0];
        _current.backgroundColor = ATRGBA(238, 245, 245, 0.7);
        _current.textAlignment = NSTextAlignmentCenter;
        _current.layer.cornerRadius = 3.0;
        _current.layer.masksToBounds = YES;
        [_current setTextColor:ATMainTonalColor];

    }
    return _current;
}

- (UILabel *)deposit {
    if (!_deposit) {
        _deposit = [UILabel new];
        _deposit.font = [UIFont systemFontOfSize:10.0];
        _deposit.backgroundColor = ATRGBA(238, 245, 245, 0.7);
        _deposit.textAlignment = NSTextAlignmentCenter;
        _deposit.layer.cornerRadius = 3.0;
        _deposit.layer.masksToBounds = YES;
        [_deposit setTextColor:ATMainTonalColor];
    }
    return _deposit;
}

- (UILabel *)decoration {
    if (!_decoration) {
        _decoration = [UILabel new];
        _decoration.font = [UIFont systemFontOfSize:10.0];
        _decoration.backgroundColor = ATRGBA(238, 245, 245, 0.7);
        _decoration.textAlignment = NSTextAlignmentCenter;
        _decoration.layer.cornerRadius = 3.0;
        _decoration.layer.masksToBounds = YES;
        [_decoration setTextColor:ATMainTonalColor];
    }
    return _decoration;
}

- (UIView *)line {
    if (!_line) {
        _line = [UIView new];
        _line.backgroundColor = ATRGBA(238, 238, 245, 1.0);
    }
    return _line;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
