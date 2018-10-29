//
//  ATPickerCellView.m
//  AnnTenants
//
//  Created by HuangGang on 2018/5/3.
//  Copyright © 2018年 Harely. All rights reserved.
//

#import "ATPickerCellView.h"

@interface ATPickerCellView()<UIPickerViewDataSource, UIPickerViewDelegate>

@property(nonatomic, strong) NSMutableArray *pickerArray;

@end

@implementation ATPickerCellView

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *time = @[@"9:00", @"9:30",@"10:00", @"10:30",@"11:00", @"11:30",@"12:00", @"12:30",@"13:00", @"13:30",@"14:00", @"14:30",@"15:00", @"15:30", @"16:00", @"16:30", @"17:00", @"17:30", @"18:00", @"18:30", @"19:00", @"19:30", @"20:00", @"20:30", @"21:00", @"21:30", @"22:00"];
        self.selectValues = [NSMutableArray array];
        NSMutableArray *times = [NSMutableArray arrayWithArray:time];
        NSMutableArray *futures = [ATTools getWeekDayFordate];
        self.pickerArray = [NSMutableArray arrayWithObjects:futures, times, nil];
        
        for (int i = 0; i < self.pickerArray.count; i ++) {
            NSMutableArray *next = self.pickerArray[i];
            [self.selectValues addObject: next[0]];
        }
    }
    [self layoutIfNeeded];
    return self;
}

- (void)layoutSubviews {
    
    UIView *line = [UIView new];
    line.backgroundColor = ATMainTonalColor;
    UILabel *reservationInfo = [ATRoomInfoCellView createLabel:@"预约看房时间" fontSize:14.0 fontColor:ATRGBA(171, 179, 186, 1.0)];
    
    
    [self.contentView addSubview:line];
    [self.contentView addSubview:reservationInfo];
    [self.contentView addSubview:self.pickerView];
    
    line.frame = CGRectMake(15, 15, 1, 12);
    reservationInfo.frame = CGRectMake(20, 15, 100, 12);
    self.pickerView.frame = CGRectMake(15, 40, ATSCREEN_WIDTH - 30, 150);
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return self.pickerArray.count;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSMutableArray *pickers = self.pickerArray[component];
    return pickers.count;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return  25.0f;
}

//返回指定列的宽度
- (CGFloat) pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    
    return  self.frame.size.width/self.pickerArray.count;
    
}

//自定义指定列的每行的视图，即指定列的每行的视图行为一致

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    if (!view){
        
        view = [[UIView alloc]init];
        
    }
    
    UILabel *text = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width/self.pickerArray.count, 20)];
    
    text.textAlignment = NSTextAlignmentCenter;
    NSMutableArray *components  = self.pickerArray[component];
    //    label.text = [NSString stringWithFormat:@"%@",components[row]];
    text.text = [components objectAtIndex:row];
    
    //    [view addSubview:text];
    
    //隐藏上下直线
    
    [self.pickerView.subviews objectAtIndex:1].backgroundColor = [UIColor clearColor];
    
    [self.pickerView.subviews objectAtIndex:2].backgroundColor = [UIColor clearColor];
    //    view.backgroundColor = [UIColor redColor];
    
    return text;
    
}

//被选择的行
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    NSString *selectComponent = nil;
    for (int i = 0; i < self.pickerArray.count; i ++) {
        NSMutableArray *details = self.pickerArray[component];
        if (i == component) {
            selectComponent = [NSString stringWithFormat:@"%@", details[row]];//获取选中的值；
            self.selectValues[component] = selectComponent;
        }
    }
}

- (UIPickerView *)pickerView {
    if (!_pickerView) {
        _pickerView = [UIPickerView new];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
    }
    return _pickerView;
}

@end
