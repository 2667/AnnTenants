//
//  ATATReservationController.m
//  AnnTenants
//
//  Created by HuangGang on 2018/5/3.
//  Copyright © 2018年 Harely. All rights reserved.
//

#import "ATReservationController.h"

@interface ATReservationController ()<UIPickerViewDelegate, UIPickerViewDataSource>
{
    BOOL _isReservation;
}

@property(nonatomic, strong) ATPickerView *pickerView;
@property(nonatomic, strong) NSArray *proTimeList;
@property(nonatomic, strong) NSArray *proTitleList;

@end

@implementation ATReservationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ATRGBA(239, 239, 245, 1.0);
    
    self.navigationItem.title = @"预约";
    
//    禁止TableView滚动
//    [self.tableView setScrollEnabled:FALSE];
//    [self setPicke];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;

    NSString *isReservation = [ATReservationViewModel getReservationDataFromSQLTableWithUserID:self.shareHouseJsonM.userId houseResourceID:self.shareHouseJsonM.houseingResourceID].isReservation;
    if (![ATTools isBlankString:isReservation]) {
        _isReservation = YES;
    }else {
        _isReservation = NO;
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    
}

- (void) setPicke {
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 100, 320, 216)];
    // 显示选中框
    pickerView.showsSelectionIndicator=YES;
    pickerView.dataSource = self;
    pickerView.delegate = self;
    [self.view addSubview:pickerView];
    
    _proTimeList = [[NSArray alloc]initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",nil];
    _proTitleList = [[NSArray alloc]initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",nil];
}

#pragma Mark -- UIPickerViewDataSource
// pickerView 列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

// pickerView 每列个数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return [_proTitleList count];
    }
    
    return [_proTimeList count];
}

// 每列宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    
    if (component == 1) {
        return 40;
    }
    return 180;
}
// 返回选中的行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) {
        NSString  *_proNameStr = [_proTitleList objectAtIndex:row];
        NSLog(@"nameStr=%@",_proNameStr);
    } else {
        NSString  *_proTimeStr = [_proTimeList objectAtIndex:row];
        NSLog(@"_proTimeStr=%@",_proTimeStr);
    }
    
}

-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0) {
        return [_proTitleList objectAtIndex:row];
    } else {
        return [_proTimeList objectAtIndex:row];
        
    }
}












- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - TableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        static NSString  *cellID = @"ATShortenCellView";
        ATShortenCellView *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[ATShortenCellView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        [cell bindModel:self.shareHouseJsonM];
        return cell;
    }else if (indexPath.section == 1) {
        static NSString *cellID = @"ATReservationObjectCellView";
        ATReservationObjectCellView *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[ATReservationObjectCellView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        ATMyHeadModel * myHeadM = [ATReservationViewModel getUserDataFromHousingResourceTableForHouseResourceID:self.shareHouseJsonM.houseingResourceID];
        [cell bindModel:myHeadM];
        return  cell;
    }else if (indexPath.section == 2) {//
        static NSString *cellID = @"ATPickerCellView";
        ATPickerCellView *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[ATPickerCellView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        return cell;
    }else {
    static NSString *cellID = @"CommonCellView";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    UILabel *label = [self reservationLabel];
    label.frame = CGRectMake(15, 15, ATSCREEN_WIDTH - 30, 50);
    [cell addSubview:label];
    return cell;
    }
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 135;
    }else if (indexPath.section == 1) {
        return 91;
    }else if (indexPath.section == 2)  {
        return 205;
    }
    return 80;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }
    return 20;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ATSCREEN_WIDTH, 0)];
    view.backgroundColor = ATRGBA(239, 239, 245, 1.0);
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!_isReservation) {
        if (indexPath.section == 3) {
            ATReservationModel *reservationM = [ATReservationModel new];
            
            NSIndexPath *picker = [NSIndexPath indexPathForRow:0 inSection:2];
            ATPickerCellView *cell = [tableView cellForRowAtIndexPath:picker];
            NSString *timeValue = [cell.selectValues componentsJoinedByString:@""];
            
            reservationM.userId = self.shareHouseJsonM.userId;
            reservationM.houseResourcID = self.shareHouseJsonM.houseingResourceID;
            reservationM.reservationTime = timeValue;
            reservationM.isReservation = @"预约";
            
            [ATSQLiteManager isInsertDataForReservation:reservationM];
            
            for (UIViewController *controller in self.navigationController.viewControllers) {
                if ([controller isKindOfClass:[ATHouseDetailController class]]) {
                    [self.navigationController popToViewController:controller animated:YES];
                }
            }
        }
    }
}

- (ATPickerView *)pickerView {
    if (!_pickerView) {
        NSArray *time = @[@"9:00", @"9:30",@"10:00", @"10:30",@"11:00", @"11:30",@"12:00", @"12:30",@"13:00", @"13:30",@"14:00", @"14:30",@"15:00", @"15:30", @"16:00", @"16:30", @"17:00", @"17:30", @"18:00", @"18:30", @"19:00", @"19:30", @"20:00", @"20:30", @"21:00", @"21:30", @"22:00"];
        NSMutableArray *times = [NSMutableArray arrayWithArray:time];
        NSMutableArray *futures = [ATTools getWeekDayFordate];
        NSMutableArray *pickers = [NSMutableArray arrayWithObjects:times, futures, nil];
        
        _pickerView = [[ATPickerView alloc] initWithFrame:CGRectZero pickerTitle:nil rollArrays:pickers defaultValue:[NSString stringWithFormat:@"%@,%@", times.firstObject, futures.firstObject]];
    }
    return _pickerView;
}
- (UILabel *) reservationLabel {
    UILabel *label = [UILabel new];
    if (_isReservation) {
        label.backgroundColor = ATRGBA(140, 151, 159, 1.0);
    }else {
        label.backgroundColor = ATMainTonalColor;
    }
    label.textAlignment = NSTextAlignmentCenter;
    label.layer.masksToBounds = YES;
    label.layer.cornerRadius = 20.0f;
    label.text = @"确定预约";
    [label setTextColor:[UIColor whiteColor]];
    return label;
}
@end
