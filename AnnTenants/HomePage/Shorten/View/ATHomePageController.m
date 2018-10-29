//
//  ATHomePageController.m
//  AnnTenants
//
//  Created by HuangGang on 2018/4/28.
//  Copyright © 2018年 Harely. All rights reserved.
//

#import "ATHomePageController.h"

@interface ATHomePageController ()

//上次选中的索引(或者控制器)
@property(nonatomic, assign) NSInteger lastSelectedIndex;

@property(nonatomic, strong) NSMutableArray *houseResourceMS;
@property(nonatomic, strong) NSMutableArray *deleteArr; //删除数组

@property(nonatomic, strong) UIView *baseView;
@property(nonatomic, strong) UIButton *deleteBtn;
@property(nonatomic, strong) UIButton *edit;

@end

@implementation ATHomePageController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = ATRGBA(238, 238, 245, 1.0);
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    static NSString *tabBarDidSelectedNotification = @"tabBarDidSelectedNotification";
    //注册接收通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarSeleted) name:tabBarDidSelectedNotification object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    switch (self.hompageType) {
        case ATHomePageTypeHomepage:
            self.navigationItem.title = @"房源";
            self.houseResourceMS = [ATHouseResourceViewModel getHoseResourceFieldFromSQLite];
            break;
        case ATHomePageTypeCollect:
            self.navigationItem.title = @"收藏房源";
            self.tabBarController.tabBar.hidden = YES;
            self.houseResourceMS = [ATHouseResourceViewModel getCollectDataFromSQLDatabaseWithUserId:ATUserManager.shareUser.userId];
            [self.tableView reloadData];
            break;
        case ATHomePageTypeReservation:{
            self.navigationItem.title = @"预约房源";
            self.tabBarController.tabBar.hidden = YES;
            
            UIBarButtonItem *next = [[UIBarButtonItem alloc] initWithCustomView:self.edit];
            self.navigationItem.rightBarButtonItem = next;
            
            self.houseResourceMS = [ATHouseResourceViewModel getReservationDataFromSQLDatabaseWithUserId:ATUserManager.shareUser.userId];
            break;
        }
            
        case ATHomePageTypePublishHouse: {
            self.navigationItem.title = @"我发布的房源";
            self.tabBarController.tabBar.hidden = YES;
            self.houseResourceMS = [ATHouseResourceViewModel getPublishHouseDataFromSQLDatabaseWithUserId:ATUserManager.shareUser.userId];
            UIBarButtonItem *next = [[UIBarButtonItem alloc] initWithCustomView:self.edit];
            self.navigationItem.rightBarButtonItem = next;
            
            break;
        }
            
        default:
            break;
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.tabBarController.tabBar.hidden = FALSE;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - TableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.houseResourceMS.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ATShareHouseJsonModel *shareHouseJsonM = self.houseResourceMS[indexPath.row];
    
    static NSString  *cellID = @"ATShortenCellView";
    ATShortenCellView *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[ATShortenCellView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
//        此处一定不能使用 UITableViewCellSelectionStyleNone, 会造成选中之后再次点击无法改变选中视图的样式
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    }
    
//    if (cell.selected == YES && tableView.editing == YES) {
//        UIImageView *imageView = [[[cell.subviews lastObject]subviews]firstObject];
//        imageView.image = [UIImage imageNamed:@"checked"];
//    }
    
    
    [cell bindModel:shareHouseJsonM];
    return cell;
}

/*
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}

//删除操作
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    ATShareHouseJsonModel *shareHouseJsonM = self.houseResourceMS[indexPath.row];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        考虑到性能这里不建议使用reloadData，使用下面的方法可以局部刷新又有动画效果。将表中的cell删除
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
//        将本地的数组中数据删除
        [self.houseResourceMS removeObject:shareHouseJsonM];
        [self.tableView reloadData];
//        将服务器端数据删除
//        .....
    }
    
//    if (group.contacts.count==0) { 如果当前数组中没有数据则移除
//        [_contacts removeObject:group];
//        [tableView reloadData];
//    }
}

//对表进行处理的方式  默认是删除方式.若在这里添加UITableViewCellEditingStyleInsert，在编辑状态下不会进入。
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.hompageType == ATHomePageTypeReservation || self.hompageType == ATHomePageTypePublishHouse) {
        if (self.edit.isSelected) {
            return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert; //多选模式，左边是蓝色对号
        }else {
            return UITableViewCellEditingStyleDelete;   //删除样式(左边是红色减号)
        }
        
    }
    return UITableViewCellEditingStyleNone; //没有编辑样式
}

// 是否可以编辑  默认的时YES
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

*/

#pragma mark - UITableDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 135;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    非选中状态
//    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (self.edit.isSelected) {
            [self.deleteArr addObject:self.houseResourceMS[indexPath.row]];
    }else {
        ATShareHouseJsonModel *shareHouseJsonM = self.houseResourceMS[indexPath.row];
        ATHouseDetailController *houseDetailC = [ATHouseDetailController new];
        houseDetailC.shareHouseJsonModel = shareHouseJsonM;
        [self.navigationController pushViewController:houseDetailC animated:YES];
    }
}

//- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (self.hompageType == ATHomePageTypeReservation) {
//        [self.deleteArr removeObject: self.houseResourceMS[indexPath.row]]; //取消选中时，将self.deleteArr中的数据移除
//    }
//}

//cell左滑时添加Action按钮
- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    __weak typeof(self) weakSelf = self;
    
//    设置删除按钮
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        [weakSelf.deleteArr addObject:weakSelf.houseResourceMS[indexPath.row]];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf deleteAction:nil];
        });
    }];
    
//    设置修改按钮
    UITableViewRowAction *modifyRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"修改" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        ATReleaseHousingController *releaseHouseC = [ATReleaseHousingController new];
        [self.navigationController pushViewController:releaseHouseC animated:YES];
        
    }];
    modifyRowAction.backgroundColor = [UIColor greenColor];
    modifyRowAction.backgroundEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    


    if (self.hompageType == ATHomePageTypeReservation || self.hompageType == ATHomePageTypePublishHouse) {
        return @[deleteRowAction, modifyRowAction];
    }else {
        return @[];
    }
}



#pragma mark - Action
- (void) removeReservation:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    if(sender.selected){
        [sender setTitle:@"完成" forState:UIControlStateNormal];
        
        [self.tableView setEditing:YES animated:YES];
        
        CGRect frame = self.baseView.frame;
        frame.origin.y -= 60;
        [UIView animateWithDuration:0.5 animations:^{
            self.baseView.frame = frame;
            [self.view addSubview:self.baseView];
        }];
    }else {
        [sender setTitle:@"编辑" forState:UIControlStateNormal];
        [self.tableView setEditing:NO animated:YES];
        
        [self.view addSubview: self.baseView];
        
        [UIView animateWithDuration:0.5 animations:^{
            CGPoint point = self.baseView.center;
            point.y      += 60;
            self.baseView.center   = point;
            
        } completion:^(BOOL finished) {
            [self.baseView removeFromSuperview];
        }];
    }
}


- (void) deleteAction:(UIButton *)sender {
    
    if (self.hompageType == ATHomePageTypeReservation) {
        [ATHouseResourceViewModel deleteDataFromSQLiteWithDataArray:self.deleteArr tableName:@"reservationHouseResource"];
    }else {
        [ATHouseResourceViewModel deleteDataFromSQLiteWithDataArray:self.deleteArr tableName:@"housingResource"];
    }
    
    [self.houseResourceMS removeObjectsInArray:self.deleteArr];
    [self.deleteArr removeAllObjects];
    [self.tableView reloadData];
}

//接收到通知实现方法
- (void)tabBarSeleted {
//    如果是连续选中2次, 直接刷新
//    if (self.lastSelectedIndex == self.tabBarController.selectedIndex) {
//        //直接写刷新代码
//    }
    
    [self.tableView reloadData];
}

- (UIView *)baseView {
    if (!_baseView) {
        _baseView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 60, self.view.frame.size.width, 60)];
        _baseView.backgroundColor = [UIColor grayColor];
        [_baseView addSubview: self.deleteBtn];
    }
    return _baseView;
}

- (UIButton *)deleteBtn {
    if (!_deleteBtn) {
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _deleteBtn.frame = CGRectMake(0, 0, self.view.frame.size.width, 60);
        _deleteBtn.backgroundColor = ATMainTonalColor;
        [_deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        [_deleteBtn addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteBtn;
}

- (UIButton *)edit {
    if (!_edit) {
        _edit = [UIButton buttonWithType:UIButtonTypeCustom];
        _edit.frame = CGRectMake(0, 0, 50, 44);
        [_edit setTitle:@"编辑" forState:UIControlStateNormal];
        [_edit setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_edit addTarget:self action:@selector(removeReservation:) forControlEvents:UIControlEventTouchUpInside];
        self.deleteArr = [NSMutableArray array];
    }
    return _edit;
}


@end
