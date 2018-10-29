//
//  ATPublishSharedHouseController.m
//  AnnTenants
//
//  Created by HuangGang on 2018/4/14.
//  Copyright © 2018年 Harely. All rights reserved.
// 常量：https://blog.csdn.net/mazegong/article/details/51601425

#import "ATPublishSharedHouseController.h"

#pragma mark - 定义常量
#pragma mark - pickView
NSString *const floors = @"楼层/总楼层";
NSString *const houseType = @"户型";
NSString *const onHireDuration = @"起租时长";

#pragma mark - 添加图片
NSString *const addPictures = @"最多添加9张图片";

#pragma mark - 单选
NSString *const district = @"地区";
NSString *const orientation = @"朝向";
NSString *const decoration = @"装修";
NSString *const paymentWay = @"付款方式";


#pragma mark - 多选
NSString *const houseConfiguration = @"房屋配置";
NSString *const renterRequire = @"对租客要求";

#pragma mark - Write
NSString *const area = @"面积";
NSString *const rent = @"房租";
NSString *const detailDescribe = @"详细描述";

typedef NS_ENUM(NSInteger, ATNextPopupViewType) {
    ATPickerViewType,               //弹出pickerView
    ATTableViewControlelrType,      //弹出tableController
    ATAlertViewControllerType,      //弹出提示视图控制器
};

@interface ATPublishSharedHouseController ()<AddressControllerDelegate>

@property(nonatomic, strong) NSMutableArray *cellInfo;
@property(nonatomic, strong) void (^sendValue)(NSString *area);
@property(nonatomic, strong) ATHouseDataViewModel *houseDataVM;

@end

@implementation ATPublishSharedHouseController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"发布合租房源";
//    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[ATTools reSizeImage:[UIImage imageNamed:@"back"] toSize:CGSizeMake(30, 30)] style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
//    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    
    UIBarButtonItem *next = [[UIBarButtonItem alloc] initWithTitle:@"下一步" style:UIBarButtonItemStylePlain target:self action:@selector(nextController)];
    self.navigationItem.rightBarButtonItem = next;
    
    self.cellInfo = [self.shareHouseVM getShareHouseSections];
    self.houseDataVM.shareHouseJsonM.rentType = [self.shareHouseVM getRentType];
    
    [self registerNotification];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.tableView.tableFooterView = [UIView new];
    self.tableView.backgroundColor = ATRGBA(239, 239, 245, 1.0);

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.tabBarController.tabBar.hidden = NO;
}

#pragma mark 注册通知
- (void) registerNotification {
    NSNotificationCenter *areaNotification = [NSNotificationCenter defaultCenter];
    [areaNotification addObserver:self selector:@selector(notificationArea:) name:@"areaNotificationC" object:nil];
    
    NSNotificationCenter *shareWriteNotification = [NSNotificationCenter defaultCenter];
    [shareWriteNotification addObserver:self selector:@selector(notificationWrite:) name:@"ATShareWriteCellView" object:nil];
    
    NSNotificationCenter *textViewNotification = [NSNotificationCenter defaultCenter];
    [textViewNotification addObserver:self selector:@selector(notificationTextValueWrite:) name:@"ATTextViewCellView" object:nil];
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.cellInfo.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    ATShareHouseSectionsModel *sectionM  = self.cellInfo[section];
    NSMutableArray *rows = sectionM.sectionHousesInfo;
    return rows.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ATShareHouseSectionsModel *shareHouseSectionsM = self.cellInfo[indexPath.section];
    ATShareHouseModel *shareHouseM = shareHouseSectionsM.sectionHousesInfo[indexPath.row];
    NSString *cellClassName = shareHouseM.cellStyle;
    
    static NSString  *cellID = nil;
    Class CellClass = NSClassFromString(cellClassName);
    id cell = nil;
    
//    运用工厂模式和运行时
    if ([cellClassName isEqualToString:@"ATShareHouseCellView"]) {
        cellID = @"ATShareHouseCellView";
        cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[CellClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        [cell bindViewModel:shareHouseM];
    } else if ([cellClassName isEqualToString:@"ATCollectionCellView"]){
        cellID = @"ATCollectionCellView";
        cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[CellClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        [cell setControlelr:self];
        [cell bindViewModel:shareHouseM];
        
    }else if ([cellClassName isEqualToString:@"ATShareCellView"]) {
        cellID = @"ATShareCellView";
        cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[CellClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        [cell bindViewModel:shareHouseM];
    }else if ([cellClassName isEqualToString:@"ATShareWriteCellView"]) {
        cellID = @"ATShareWriteCellView";
        cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[CellClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        [cell bindViewModel:shareHouseM];
    }else {
        cellID = @"ATTextViewCellView";
        cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[CellClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        [cell bindViewModel:shareHouseM];
    }
    return cell;
}


#pragma mark - UITableDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {
    ATShareHouseSectionsModel *shareHouseSectionsM = self.cellInfo[indexPath.section];
    ATShareHouseModel *shareHouseM = shareHouseSectionsM.sectionHousesInfo[indexPath.row];
    if ([detailDescribe isEqualToString:shareHouseM.functionTitle]) {
        return 180;
    }else if ([addPictures isEqualToString:shareHouseM.houseInfo]) {
        return 87.5 * (self.pictures.count /4 +1);
    }
    return 45;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headView = [UIView new];
    UILabel *headerFooter = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, self.view.frame.size.width, 30)];
    headerFooter.font = [UIFont systemFontOfSize:10.0];
    headerFooter.textColor = ATRGBA(141, 156, 153, 1.0);
    
    ATShareHouseSectionsModel *shareHouseSectionsM = self.cellInfo[section];
    headerFooter.text = shareHouseSectionsM.sectionTitle;
    
    [headView addSubview: headerFooter];
    return headView;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    取数据
    ATShareHouseSectionsModel *shareHouseSectionsM = self.cellInfo[indexPath.section];
    ATShareHouseModel *shareHouseM = shareHouseSectionsM.sectionHousesInfo[indexPath.row];
    NSMutableArray * totalArray = nil;
    ATShareCellView *cell = [tableView cellForRowAtIndexPath:indexPath];

    
//    PickerView
    if ([floors isEqualToString:shareHouseM.functionTitle]) {
        totalArray = [shareHouseM PickerViewForfloors];
        [self popupViewType:ATPickerViewType shareHouseModel:shareHouseSectionsM selectRowAtIndexPath:indexPath rollArray: totalArray];
    }if ([houseType isEqualToString:shareHouseM.functionTitle]) {
        totalArray = [shareHouseM PickerViewForHouseTypes];
        [self popupViewType:ATPickerViewType shareHouseModel:shareHouseSectionsM selectRowAtIndexPath:indexPath rollArray: totalArray];
    }if ([onHireDuration isEqualToString:shareHouseM.functionTitle ]) {
        totalArray = [shareHouseM PickerViewForOnHireDuration];
        [self popupViewType:ATPickerViewType shareHouseModel:shareHouseSectionsM selectRowAtIndexPath:indexPath rollArray: totalArray];
    }
    
//    地区选择
    if ([district isEqualToString:shareHouseM.functionTitle]) {
        AddressViewController *addressVC = [[AddressViewController alloc]init];
        addressVC.selectValue = ^(NSString *district) {
            shareHouseM.houseInfo = district;
            cell.houseInfoDetail.text = district;
        };
//        addressVC.delegate = self;
        self.sendValue = ^(NSString *area) {
            shareHouseM.houseInfo = area;
            cell.houseInfoDetail.text = area;
        };
        [self.navigationController pushViewController:addressVC animated:YES];
    }
    

    ATSelectedValuesController *selectController = [[ATSelectedValuesController alloc] init];
    __weak typeof(self) weakSelf = self;
//    单选
    if ([orientation isEqualToString: shareHouseM.functionTitle]) {
        NSArray *array = [shareHouseM orientations];
        [selectController selectTitle:orientation cellData:array selectType:RadioSelectType results:^NSMutableArray *(NSMutableArray *results) {
            NSLog(@"返回的选择数据是：%@", results);
            NSString *str = [results componentsJoinedByString:@","];

            shareHouseM.houseInfo = str;
            return results;
        }];
        
        selectController.selectValues = ^(NSMutableArray *selectValues) {
            NSLog(@"------------>%@",selectValues);
            shareHouseM.houseInfo = selectValues.firstObject;
            cell.houseInfoDetail.text = selectValues.firstObject;
            weakSelf.houseDataVM.shareHouseJsonM.orientation = selectValues.firstObject;
        };
        [self.navigationController pushViewController:selectController animated:YES];
    }if ([decoration isEqualToString:shareHouseM.functionTitle]) {
        NSArray *array = [shareHouseM decorations];
        [selectController selectTitle:decoration  cellData:array selectType:RadioSelectType results:^NSMutableArray *(NSMutableArray *results) {
            NSLog(@"返回的选择数据是：%@", results);
            return results;
        }];
        selectController.selectValues = ^(NSMutableArray *selectValues) {
            NSLog(@"------------>%@",selectValues);
            shareHouseM.houseInfo = selectValues.firstObject;
            cell.houseInfoDetail.text = selectValues.firstObject;
            weakSelf.houseDataVM.shareHouseJsonM.decorated = selectValues.firstObject;
        };
        [self.navigationController pushViewController:selectController animated:FALSE];
    } if ([paymentWay isEqualToString:shareHouseM.functionTitle]) {
        NSArray *array = [shareHouseM paymentWays];
        [selectController selectTitle:paymentWay  cellData:array selectType:RadioSelectType results:^NSMutableArray *(NSMutableArray *results) {
            NSLog(@"返回的选择数据是：%@", results);
            return results;
        }];
        selectController.selectValues = ^(NSMutableArray *selectValues) {
            NSLog(@"------------>%@",selectValues);
            shareHouseM.houseInfo = selectValues.firstObject;
            cell.houseInfoDetail.text = selectValues.firstObject;
            weakSelf.houseDataVM.shareHouseJsonM.paymentWays = selectValues.firstObject;
        };
        [self.navigationController pushViewController:selectController animated:FALSE];
    }
    
//    多选
    if ([houseConfiguration isEqualToString:shareHouseM.functionTitle]) {
        NSArray *array = [shareHouseM houseConfigurations];
        [selectController selectTitle:houseConfiguration  cellData:array selectType:MultipleSelectType results:^NSMutableArray *(NSMutableArray *results) {
            NSLog(@"返回的选择数据是：%@", results);
            return results;
        }];
        selectController.selectValues = ^(NSMutableArray *selectValues) {
            NSLog(@"------------>%@",selectValues);
            NSString *str = [selectValues componentsJoinedByString:@","];
            shareHouseM.houseInfo = str;
            cell.houseInfoDetail.text = str;
            weakSelf.houseDataVM.shareHouseJsonM.houseConfiguration = str;
        };
        [self.navigationController pushViewController:selectController animated:FALSE];
    }if ([renterRequire isEqualToString:shareHouseM.functionTitle]) {
        NSArray *array = [shareHouseM retenrRequires];
        [selectController selectTitle:renterRequire  cellData:array selectType:MultipleSelectType results:^NSMutableArray *(NSMutableArray *results) {
            NSLog(@"返回的选择数据是：%@", results);
            return results;
        }];
        selectController.selectValues = ^(NSMutableArray *selectValues) {
            NSLog(@"------------>%@",selectValues);
            NSString *str = [selectValues componentsJoinedByString:@","];
            shareHouseM.houseInfo = str;
            cell.houseInfoDetail.text = str;
            weakSelf.houseDataVM.shareHouseJsonM.renterRequire = str;
        };
        [self.navigationController pushViewController:selectController animated:FALSE];

    }
    
//    填写
    if ([area isEqualToString:shareHouseM.functionTitle]) {
        [self popupViewType:ATAlertViewControllerType shareHouseModel:shareHouseSectionsM selectRowAtIndexPath:indexPath rollArray:nil];
    }
    
}

#pragma mark - AddressControllerDelegate
- (void)getSelectArea:(NSString *)value {
    NSLog(@"-----------_>%@", value);
}

#pragma mark - 通知方法
- (void) notificationArea:(NSNotification *) notification {
    NSLog(@"------------_>%@", notification.object);
    self.sendValue(notification.object);
    self.houseDataVM.shareHouseJsonM.location = notification.object;
}

- (void) notificationWrite:(NSNotification *) notification {
    if ([notification.userInfo objectForKey:area] != nil) {
        self.houseDataVM.shareHouseJsonM.area = [notification.userInfo objectForKey:area];
    } else {
        self.houseDataVM.shareHouseJsonM.rent = [notification.userInfo objectForKey:rent];
    }
}

- (void) notificationTextValueWrite:(NSNotification *) notification {
    self.houseDataVM.shareHouseJsonM.detailDescribe = notification.object;
}


#pragma  mark - 弹出不同的视图控制器
- (void) popupViewType:(ATNextPopupViewType) nextType shareHouseModel:(ATShareHouseSectionsModel *) shareHouseSectionsModel selectRowAtIndexPath:(NSIndexPath *) indexPath rollArray:(NSMutableArray *)rolls{
    ATShareHouseModel *shareHouseM = shareHouseSectionsModel.sectionHousesInfo[indexPath.row];
    
    switch (nextType) {
        case ATPickerViewType:{
            ATShareCellView *cell = [self.tableView cellForRowAtIndexPath:indexPath];
            CGRect pickerFrame = CGRectMake(0, 0, ATSCREEN_WIDTH, ATSCREEN_HEIGHT);
            ATPickerView *pickerView = [[ATPickerView alloc] initWithFrame:pickerFrame pickerTitle:shareHouseM.functionTitle rollArrays:rolls defaultValue:nil];
            pickerView.selectValue = ^(NSMutableArray *values) {
//                将字符串数组转化为字符串、
                NSString *str = [values componentsJoinedByString:@""];
                shareHouseM.houseInfo = str;
                cell.houseInfoDetail.text = str;
                if ([floors isEqualToString:shareHouseM.functionTitle]) {
                    self.houseDataVM.shareHouseJsonM.floor = str;
                }else if ([houseType isEqualToString:shareHouseM.functionTitle]) {
                    self.houseDataVM.shareHouseJsonM.houseType = str;
                }else {
                    self.houseDataVM.shareHouseJsonM.onHireDuration = str;
                }
            };
            [pickerView popubPickerView];
            break;
        }
        
        case ATTableViewControlelrType:
            
            break;
            
        case ATAlertViewControllerType:{
            ATShareWriteCellView *cell = [self.tableView cellForRowAtIndexPath:indexPath];
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:shareHouseM.functionTitle message:[NSString stringWithFormat:@"请输入%@", shareHouseM.functionTitle] preferredStyle:UIAlertControllerStyleAlert];
            [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                if (textField.text == nil || [textField.text  isEqual: @""]) {
                    textField.placeholder = @"例:500";
                }else{
                    textField.text = shareHouseM.houseInfo;
                }
                
            }];
            UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                shareHouseM.houseInfo = alertController.textFields.lastObject.text;
                [cell bindViewModel:shareHouseM];
                NSLog(@"------------%@", alertController.textFields.lastObject.text);
            }];
            UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                NSString *text = alertController.textFields.lastObject.text;
                if (text == nil || [text  isEqual: @""]) {
                    alertController.textFields.lastObject.placeholder = @"例:500";
                }else{
                    shareHouseM.houseInfo = alertController.textFields.lastObject.text;
                }
                NSLog(@"点击了取消");
            }];
            
            
            [alertController addAction:confirmAction];
            [alertController addAction:cancleAction];
            
            [self presentViewController:alertController animated:YES completion:nil];
        }
            
        default:
            break;
    }
}


- (void) nextController {
    
    if (![ATTools isBlankString:ATUserManager.shareUser.userId]) {
        ATFinishController *finish = [[ATFinishController alloc] init];
        
        self.houseDataVM.shareHouseJsonM.housePictures = self.pictures;
        __weak typeof (self) weakSelf = self;
        [ATHouseDataViewModel publishHouseInformation:self.houseDataVM.shareHouseJsonM isSuccess:^(bool isSuccess, NSString *emptyTitle) {
            if (isSuccess) {
                [weakSelf.navigationController pushViewController:finish animated:YES];
            }else {
                UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"提示"
                                                                               message:[NSString stringWithFormat:@"请输入%@信息", emptyTitle]
                                                                        preferredStyle:UIAlertControllerStyleAlert];
                [self.navigationController presentViewController:alert animated:YES completion:nil];
                [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerAction:)userInfo:alert repeats:NO];
                
                
            }
        }];
    }else {
        ATAlertController *alert = [ATAlertController alertWithTitle:@"提示" message:@"请先登录或者注册"];
        [self.navigationController presentViewController:alert animated:YES completion:nil];
        [alert dissMissAlert];
    }
    
}

- (void)timerAction:(NSTimer*)timer
{
    UIAlertController * alert = (UIAlertController *)[timer userInfo];
    [alert dismissViewControllerAnimated:YES completion:nil];
    
    alert = nil;
}

- (ATHouseDataViewModel *)houseDataVM {
    if (!_houseDataVM) {
        _houseDataVM = [ATHouseDataViewModel new];
    }
    return _houseDataVM;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
