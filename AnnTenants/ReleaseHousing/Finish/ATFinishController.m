//
//  ATLandlordController.m
//  AnnTenants
//
//  Created by HuangGang on 2018/4/25.
//  Copyright © 2018年 Harely. All rights reserved.
//

#import "ATFinishController.h"

@interface ATFinishController ()

@property(nonatomic, strong) UIImageView *imageView;
@property(nonatomic, strong) UILabel *publish;
@property(nonatomic, strong) UILabel *reminderOne;
@property(nonatomic, strong) UILabel *reminderTwo;
@property(nonatomic, strong) UILabel *reminderThree;
@property(nonatomic, strong) UIButton *over;
@property(nonatomic, strong) UIButton *goOn;

@end

@implementation ATFinishController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self layoutOfSubviews];
}

- (void)layoutOfSubviews {
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.publish];
    [self.view addSubview:self.reminderOne];
    [self.view addSubview:self.reminderTwo];
    [self.view addSubview:self.reminderThree];
    [self.view addSubview:self.over];
    [self.view addSubview:self.goOn];
    
    
    self.imageView.frame = CGRectMake(110, 114, 100, 100);
    self.publish.frame = CGRectMake(120, 234, 100, 30);
    self.reminderOne.frame = CGRectMake(20, 300, ATSCREEN_WIDTH-20, 20);
    self.reminderTwo.frame = CGRectMake(20, 320, ATSCREEN_WIDTH-20, 20);
    self.reminderThree.frame = CGRectMake(20, 340, ATSCREEN_WIDTH-20, 20);
    self.over.frame = CGRectMake(20, 390, 130, 45);
    self.goOn.frame = CGRectMake(170, 390, 130, 45);
}


#pragma mark - Action
- (void) overAction {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void) goOnAction {
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[ATPublishSharedHouseController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
    }
}

#pragma  mark - UI初始化
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"publish"]];
        
    }
    return _imageView;
}

- (UILabel *)publish {
    if (!_publish) {
        _publish = [UILabel new];
        _publish.text = @"发布成功";
        [_publish setTextColor: [ATTools colorWithHexString:@"74CB74"]];
        [_publish setFont:[UIFont fontWithName:@"Helvetica-Bold" size:20]];
    }
    return _publish;
}

- (UILabel *)reminderOne {
    if (!_reminderOne) {
        _reminderOne = [UILabel new];
        NSDictionary *attDict = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:12.0],NSFontAttributeName, [ATTools colorWithHexString:@"A5A4A7"], NSForegroundColorAttributeName, nil];
        NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:@"1.当日18点前发布的房源会在当天审核" attributes:attDict];
        [attributedStr addAttribute:NSForegroundColorAttributeName value:ATMainTonalColor range:NSMakeRange(4, 4.5)];
        [attributedStr addAttribute:NSForegroundColorAttributeName value:ATMainTonalColor range:NSMakeRange(15, 2)];
        
        _reminderOne.attributedText = attributedStr;

    }
    return _reminderOne;
}

- (UILabel *)reminderTwo {
    if (!_reminderTwo) {
        _reminderTwo = [UILabel new];
        NSDictionary *attDict = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:12.0],NSFontAttributeName, [ATTools colorWithHexString:@"A5A4A7"], NSForegroundColorAttributeName, nil];
        NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:@"2.当日18点后发布的房源会在次日审核" attributes:attDict];
        [attributedStr addAttribute:NSForegroundColorAttributeName value:ATMainTonalColor range:NSMakeRange(4, 4.5)];
        [attributedStr addAttribute:NSForegroundColorAttributeName value:ATMainTonalColor range:NSMakeRange(15, 2)];
        
        _reminderTwo.attributedText = attributedStr;

    }
    return _reminderTwo;
}

- (UILabel *)reminderThree {
    if (!_reminderThree) {
        _reminderThree = [UILabel new];
        NSDictionary *attDict = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:12.0],NSFontAttributeName, [ATTools colorWithHexString:@"A5A4A7"], NSForegroundColorAttributeName, nil];
        NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:@"3.为了提高租房体验,若房源已出租请及时下架" attributes:attDict];
        _reminderThree.attributedText = attributedStr;
        
    }
    return _reminderThree;
}

- (UIButton *)over {
    if (!_over) {
        _over = [[UIButton alloc] init];
        [_over setTitle:@"完成" forState:UIControlStateNormal];
        _over.layer.borderColor = ATMainTonalColor.CGColor;
        _over.layer.borderWidth = 1.0f;
        _over.layer.cornerRadius = 10.0;
        _over.layer.masksToBounds = YES;
        [_over setTitleColor:ATMainTonalColor forState:UIControlStateNormal];
        [_over addTarget:self action:@selector(overAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _over;
}

- (UIButton *)goOn {
    if (!_goOn) {
        _goOn = [[UIButton alloc] init];
        [_goOn setTitle:@"继续" forState:UIControlStateNormal];
        _goOn.backgroundColor = ATMainTonalColor;
        _goOn.layer.cornerRadius = 10.0;
        _goOn.layer.masksToBounds = YES;
        [_goOn addTarget:self action:@selector(goOnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _goOn;
}

@end
