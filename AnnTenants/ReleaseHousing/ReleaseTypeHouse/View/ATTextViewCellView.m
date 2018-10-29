//
//  ATTextViewCellView.m
//  AnnTenants
//
//  Created by HuangGang on 2018/4/24.
//  Copyright © 2018年 Harely. All rights reserved.
//

#import "ATTextViewCellView.h"

@interface ATTextViewCellView()<UITextViewDelegate>

@property(nonatomic, strong) UILabel *sectionTitle;
@property(nonatomic, strong) UIView *line;
@property(nonatomic, strong) UILabel *placeHolder;
@property(nonatomic, strong) UILabel *stringLength;

@end

@implementation ATTextViewCellView

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGRect frame = self.frame;
        frame.size.height = 160;
        self.frame= frame;
    }
    return self;
}

//由于cell的布局特殊化，所有约束条件都在layoutSubviews方法中写
- (void)layoutSubviews {
    [super layoutSubviews];
        
    [self.contentView addSubview:self.sectionTitle];
    [self.contentView addSubview:self.write];
    [self.write addSubview:self.placeHolder];
    [self.write addSubview:self.stringLength];
    [self.contentView addSubview:self.line];
    
    self.sectionTitle.frame = CGRectMake(15, 10, 100, 25);
    self.write.frame = CGRectMake(15, 45, ATSCREEN_WIDTH-30, 125);
    self.placeHolder.frame = CGRectMake(0, 0, ATSCREEN_WIDTH-30, 30);
    self.stringLength.frame = CGRectMake(ATSCREEN_WIDTH-100, 105, 70, 20);
    self.line.frame = CGRectMake(15, 44, ATSCREEN_WIDTH-30, 1);
    
}

- (void)bindViewModel:(ATShareHouseModel *) shareHouseVM {
    self.sectionTitle.text = shareHouseVM.functionTitle;
    shareHouseVM.houseInfo = self.write.text;
}

#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView {
    self.placeHolder.hidden = YES;

//    实时显示字数
    self.stringLength.text = [NSString stringWithFormat:@"%lu/1000",(unsigned long)textView.text.length];
//    字数限制操作
    if (textView.text.length >= 1000) {
        textView.text = [textView.text substringToIndex:1000];
        self.stringLength.text = @"1000/1000";
    }
    
//    取消按钮点击权限，并显示提示文字
    if (textView.text.length == 0) {
        self.placeHolder.hidden = NO;
    }
}
- (void)textViewDidBeginEditing:(UITextView *)textView; {
    self.placeHolder.hidden = YES;
    
    ATFloatView *floatView  = [[ATFloatView alloc] initWithFrame:CGRectMake(0, 0, ATSCREEN_WIDTH, ATSCREEN_HEIGHT) keyboardResponder:self.write];
    [floatView showFloatView];
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ATTextViewCellView" object:textView.text];
    return  YES;
}

//#pragma mark - 获得高度自适应
+ (CGFloat)heightWithModel
{
    ATTextViewCellView *cell = [[ATTextViewCellView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ATTextViewCellView"];
    [cell layoutIfNeeded];//此方法强制立即布局并显示更新,调用 layoutSubviews, 它会自动执行相当于setNeedsLayout的操作
    CGRect frame = cell.write.frame;
    CGFloat height = frame.origin.y + frame.size.height + 10;
    return height;
}

- (UILabel *)sectionTitle {
    if (!_sectionTitle) {
        _sectionTitle = [[UILabel alloc] init];
    }
    return _sectionTitle;
}

- (UITextView *)write {
    if (!_write) {
        _write = [[UITextView alloc] init];
        _write.delegate = self;
//        _write.layer.borderWidth = 0.3;
//        _write.layer.borderColor = ATRGBA(239, 239, 245, 1.0).CGColor;
        _write.textAlignment = NSTextAlignmentLeft;
        _write.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _write;
}

- (UIView *)line {
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = ATRGBA(239, 239, 245, 1.0);
    }
    return _line;
}

- (UILabel *)placeHolder {
    if (!_placeHolder) {
        _placeHolder = [[UILabel alloc] init];
        _placeHolder.text = @"有吸引力的房源描述，让你的房源尽快脱颖而出";
        _placeHolder.userInteractionEnabled = NO;
        _placeHolder.font = [UIFont systemFontOfSize:12.0];
        [_placeHolder setTextColor:ATRGBA(239, 239, 245, 1.0)];
    }
    return _placeHolder;
}

- (UILabel *)stringLength {
    if (!_stringLength) {
        _stringLength = [[UILabel alloc] init];
        _stringLength.userInteractionEnabled = NO;
        _stringLength.text = @"0/1000";
        [_stringLength setTextColor:ATRGBA(239, 239, 245, 1.0)];
    }
    return _stringLength;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self.write resignFirstResponder];
}

@end
