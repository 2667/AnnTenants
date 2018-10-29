//
//  ATReleaseHousingController.m
//  AnnTenants
//
//  Created by HuangGang on 2018/4/14.
//  Copyright © 2018年 Harely. All rights reserved.
//自定义：https://www.cnblogs.com/edensyd/p/8780597.html

#import "ATReleaseHousingController.h"

@interface ATReleaseHousingController ()

@property (nonatomic, copy) NSMutableArray *houseTypes;

@end

@implementation ATReleaseHousingController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"房源类型";
    //    设置导航栏颜色
    self.navigationController.navigationBar.barTintColor = ATMainTonalColor;
    
    self.houseTypes = [ATReleaseViewModel houseTypes];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.scrollEnabled = FALSE;
    self.tableView.backgroundColor = ATRGBA(239, 239, 245, 1.0);
    [self customTableFooterView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.houseTypes.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *rowTitles = self.houseTypes[section];
    return rowTitles.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"ATTypesViewCell";
    ATTypesCellView *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[ATTypesCellView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    [cell bindViewModel:self.houseTypes[indexPath.section][indexPath.row]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return  30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return  60;
}

#pragma mark - UITableViewDelegate
//返回组头部view方法
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headView = [UIView new];
    UILabel *headerFooter = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, self.view.frame.size.width, 30)];
    headerFooter.font = [UIFont systemFontOfSize:10.0];
    headerFooter.textColor = ATRGBA(141, 156, 153, 1.0);
    
    if (section == 0) {
        
        headerFooter.text = @"您打算发布什么类型的房源?";
        
    }else{
        
        headerFooter.text = @"发布的房源是转租吗?";
        
    }
    [headView addSubview: headerFooter];
    return headView;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    不加此句时，在二级栏目点击返回时，此行会由选中状态慢慢变成非选中状态,加上此句，返回时直接就是非选中状态。
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    for (NSInteger i = 0; i<[self.houseTypes[indexPath.section] count]; i++) {
        ATTypeCellViewModel *typeVM = self.houseTypes[indexPath.section][i];
        if (i != indexPath.row) {
            typeVM.isSelected = FALSE;
        }else {
            typeVM.isSelected = YES;
        }
    }
    
    for (NSArray *a in self.houseTypes) {
        for (ATTypeCellViewModel *b in a) {
            NSLog(@"type:%@,   bool:%@", b.type, b.isSelected?@"YES":@"NO");
        }
    }
    
    [tableView reloadData];
}

#pragma mark - CustomMethod
- (void) customTableFooterView {
    UIButton *footerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    // 为button设置frame
    footerButton.frame = CGRectMake(0, 30, self.view.bounds.size.width, 40);
    footerButton.layer.cornerRadius = 5;
    [footerButton setTitle:@"下一步" forState:UIControlStateNormal];
    [footerButton setBackgroundColor:ATRGBA(86, 204, 253, 1.0)];
    [footerButton addTarget:self action:@selector(nextShareHouseController) forControlEvents:UIControlEventTouchUpInside];
    // 这里为button添加相应事件
    // 将 footerView 设置为 tableView 的 tableFooterView
    self.tableView.tableFooterView = footerButton;
}

- (void) nextShareHouseController {
    NSMutableArray *houseTypes = [ATReleaseViewModel getHouseTypes:self.houseTypes];
    ATShareHouseViewModel *shareHouseVM = [ATShareHouseViewModel shareHouseVM];
    [shareHouseVM rentTypes:houseTypes];
    [shareHouseVM loadBaseCellInfo];
    ATPublishSharedHouseController *publishShareHouseC = [ATPublishSharedHouseController new];
    publishShareHouseC.shareHouseVM = shareHouseVM;
    [self.navigationController pushViewController:publishShareHouseC animated:FALSE]; //若为YES,则publishShareHouseC中的多余单元格慢慢消失丑死了。
}

@end
