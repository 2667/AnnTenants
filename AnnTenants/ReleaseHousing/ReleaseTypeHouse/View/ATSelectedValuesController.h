//
//  ATSelectedValuesController.h
//  AnnTenants
//
//  Created by HuangGang on 2018/4/18.
//  Copyright © 2018年 Harely. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, RadioOrMultipleSelectType) {
    RadioSelectType,               //单选
    MultipleSelectType             //多选
};

@interface ATSelectedValuesController : UITableViewController

@property(nonatomic, strong) void (^selectValues)(NSMutableArray *values);

    
/**
 加载数据和返回数据

 @param data 传来的数组
 @param selectType 选择类型
 @param results 返回结果
 */
- (void) selectTitle:(NSString *)title cellData:(NSArray *) data selectType:(RadioOrMultipleSelectType)selectType results:( NSMutableArray* (^)(NSMutableArray* results)) results;

//- (void)selectTitle:(NSString *)title cellStruct:(ShareHouseModelStruct) cellStruct results:( NSMutableArray* (^)(NSMutableArray* results)) results;

    
@end
