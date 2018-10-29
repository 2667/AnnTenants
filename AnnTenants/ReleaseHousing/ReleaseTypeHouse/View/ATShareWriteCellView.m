//
//  ATShareWriteCellView.m
//  AnnTenants
//
//  Created by HuangGang on 2018/4/17.
//  Copyright © 2018年 Harely. All rights reserved.
//

#import "ATShareWriteCellView.h"

@interface ATShareWriteCellView()<UITextFieldDelegate>

@property(nonatomic, strong) UILabel *sectionTitle;
@property(nonatomic, strong) UILabel *prickle;

@end


@implementation ATShareWriteCellView

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) { }
    return self;
}

//由于cell的布局特殊化，所有约束条件都在layoutSubviews方法中写
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.contentView addSubview:self.sectionTitle];
    [self.contentView addSubview:self.write];
    [self.contentView addSubview:self.prickle];
    
    self.sectionTitle.frame = CGRectMake(15, 10, 100, 25);
    self.write.frame = CGRectMake(self.frame.size.width-152, 10, 100, 25);
    self.prickle.frame = CGRectMake(self.frame.size.width-52, 10, 35, 25);
    
}

- (void)bindViewModel:(ATShareHouseModel *) shareHouseVM {
    self.sectionTitle.text = shareHouseVM.functionTitle;
    shareHouseVM.houseInfo = self.write.text;
    self.prickle.text = shareHouseVM.iconName;
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    ATFloatView *floatView  = [[ATFloatView alloc] initWithFrame:CGRectMake(0, 0, ATSCREEN_WIDTH, ATSCREEN_HEIGHT) keyboardResponder:self.write];
    [floatView showFloatView];
}

//已经结束编辑时执行的方法
- (void)textFieldDidEndEditing:(UITextField *)textField {
    NSLog(@"_______________________>textFieldDidEndEditing");
}
//将要结束编辑时执行的方法
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ATShareWriteCellView" object: nil userInfo:@{self.sectionTitle.text: self.write.text}];
    return YES;
}

//#pragma mark - 获得高度自适应
+ (CGFloat)heightWithModel
{
    ATShareWriteCellView *cell = [[ATShareWriteCellView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ATShareWriteCellView"];
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

- (UITextField *)write {
    if (!_write) {
        _write = [[UITextField alloc] init];
        _write.delegate = self;
        _write.placeholder = @"例: 200";
        _write.textAlignment = NSTextAlignmentRight;
        _write.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _write;
}

- (UILabel *)prickle {
    if (!_prickle) {
        _prickle = [[UILabel alloc] init];
        _prickle.font = [UIFont fontWithName:@"Arial" size:15];
        _prickle.textAlignment = NSTextAlignmentRight;
        _prickle.numberOfLines = 1;
    }
    return _prickle;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self.write resignFirstResponder];
}

@end
