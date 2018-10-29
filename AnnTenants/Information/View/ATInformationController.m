//
//  ATInformationController.m
//  AnnTenants
//
//  Created by HuangGang on 2018/5/4.
//  Copyright © 2018年 Harely. All rights reserved.
//

#import "ATInformationController.h"

@interface ATInformationController ()

@property(nonatomic, strong) NSMutableArray *informations;

@end

@implementation ATInformationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    http 通过需要设置
    self.tableView.backgroundColor = ATRGBA(239, 239, 245, 1.0);
    self.informations = [ATInformationViewModel getInformationModel];
    self.navigationItem.title = @"资讯";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.informations.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 360.0f;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ATInformationModel *informationModel = self.informations[indexPath.section];
    
    static NSString *cellID = @"ATInformationCellView";
    ATInformationCellView *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[ATInformationCellView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    [cell bindInformationModel:informationModel];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ATInformationModel *informationModel = self.informations[indexPath.section];
    
    ATWebController *webC = [ATWebController new];
    webC.urlStr = informationModel.url;
    [self.navigationController pushViewController:webC animated:YES];
}

@end
