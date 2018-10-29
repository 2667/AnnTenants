//
//  ATSelectedValuesController.m
//  AnnTenants
//
//  Created by HuangGang on 2018/4/18.
//  Copyright © 2018年 Harely. All rights reserved.
//

#import "ATSelectedValuesController.h"

@interface ATSelectedValuesController ()

@property(nonatomic, strong) NSArray *datas;
//单选，当前选中的行
@property(nonatomic, assign) NSIndexPath *selIndex;
//多选选中的行
@property (strong, nonatomic) NSMutableArray *selectIndexs;
@property (nonatomic, strong) NSMutableArray *selectData;

@property(nonatomic, assign) RadioOrMultipleSelectType type;

    
@end

@implementation ATSelectedValuesController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.selectIndexs = [NSMutableArray array];
    self.selectData = [NSMutableArray array];
    [self customBarButtonItem];
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

- (void) customBarButtonItem {
    if (self.type == MultipleSelectType) {
        UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc]
                                              initWithTitle:@"完成"
                                              style:UIBarButtonItemStylePlain
                                              target:self
                                              action:@selector(finishedAction)];
        self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    }
    
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[ATTools reSizeImage:[UIImage imageNamed:@"back"] toSize:CGSizeMake(30, 30)] style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;

}


- (void) backAction {
    [self.navigationController popViewControllerAnimated: YES];
}

- (void) finishedAction {
    self.selectValues(self.selectData);
    [self backAction];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
    
- (void)selectTitle:(NSString *)title cellData:(NSArray *)data selectType:(RadioOrMultipleSelectType)selectType results:(NSMutableArray *(^)(NSMutableArray *))results {
    self.navigationItem.title = title;
    self.datas = data;
    self.type = selectType;
//    results(self.selectIndexs);
}

//- (void)cellStruct:(ShareHouseModelStruct)cellStruct results:(NSMutableArray *(^)(NSMutableArray *))results {
//    NSArray *array = nil;
//    NSLog(@"----------->%@",&cellStruct.rowsInfo);//https://blog.csdn.net/u010244140/article/details/50836422
//    NSLog(@"-----------%@",cellStruct.sectionTitle);
//    self.type = cellStruct.selectType;
//}
    
    
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return MultipleSelectType;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"ATSelectedValuesController";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.text = self.datas[indexPath.row];
    
//    判断单选还是多选
    if (self.type == RadioSelectType) {
//        当上下拉动的时候，因为cell的复用性，我们需要重新判断一下哪一行是打钩的
        if (_selIndex == indexPath) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }else {
        cell.accessoryType = UITableViewCellAccessoryNone;//设置勾
        for (NSIndexPath *index in _selectIndexs) {
            if (index == indexPath) { //改行在选择的数组里面有记录
                cell.accessoryType = UITableViewCellAccessoryCheckmark; //打勾
                break;
            }
        }
    }

    return cell;
}
    
#pragma  mark - UITableViewDataSource
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.type == RadioSelectType) {
//        之前选中的，取消选择
        UITableViewCell *celled = [tableView cellForRowAtIndexPath:_selIndex];
        celled.accessoryType = UITableViewCellAccessoryNone;
        
//        记录当前选中的位置索引
        _selIndex = indexPath;
//        当前选择的打勾
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        
        [self.selectIndexs addObject:self.datas[indexPath.row]];
//        __weak typeof(self) weakSelf = self;
//        self.selectValues = ^NSMutableArray *(NSMutableArray *values) {
//            return weakSelf.selectIndexs;
//        };
        self.selectValues(self.selectIndexs);
        [self.navigationController popViewControllerAnimated:YES];
    }else {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (cell.accessoryType == UITableViewCellAccessoryCheckmark) { //如果为选中状态
            cell.accessoryType = UITableViewCellAccessoryNone; //切换为未选中
            [_selectIndexs removeObject:indexPath]; //数据移除
            [self.selectData removeObject:self.datas[indexPath.row]];
        }else {//未选中
            cell.accessoryType = UITableViewCellAccessoryCheckmark; //切换为选中
            [_selectIndexs addObject:indexPath]; //添加索引数据到数组
            [self.selectData addObject:self.datas[indexPath.row]];
        }
    }
}



@end
