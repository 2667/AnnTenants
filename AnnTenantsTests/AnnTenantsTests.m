//
//  AnnTenantsTests.m
//  AnnTenantsTests
//
//  Created by HuangGang on 2018/4/18.
//  Copyright © 2018年 Harely. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ATTools.h"
#import "ATInformationViewModel.h"
#import "ATSQLiteManager.h"
#import "ATSQLiteManager+Login.h"
#import "ATInformationModel.h"


@interface AnnTenantsTests : XCTestCase

@end

@implementation AnnTenantsTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

//测试插入message表数据
- (void) testInsertDataFromTable {
    NSString *time = [ATTools currentTimestamp:0];
    NSString *informationID  = [ATTools getSha1String:time];
    
    ATInformationModel *informationM = [ATInformationModel new];
    informationM.informationID = informationID;
    informationM.imageName = @"达美中心广场";
    informationM.mainTitle = @"达美中心广场";
    informationM.abstract = @"达美中心总建筑面积350000平方米，其中写字楼产品建筑面积180000平方米。目前2号楼的18、19层和3号楼的22层，可租可售，在售均价约80000元/平，最高价约120000元/平，按揭最高五成，贷10年。租赁价格约10-13";
    informationM.url = @"http://house.ifeng.com/homedetail/105820.shtml";
    XCTAssertTrue([ATSQLiteManager isInsertDataForMessage:informationM], @"插入数据失败");
}

//测试删除数据
- (void) testDeleteDataFromTable {
    NSString *condition = [NSString stringWithFormat:@"informationID = '%@'", @"ca7a808df4776b58560bbeaf9289deb16b1504a8"];
    NSString *table = @"message";
    
    XCTAssertTrue([ATSQLiteManager deleteSQLTableForCondition:condition withTableName:table], @"删除数据失败");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
