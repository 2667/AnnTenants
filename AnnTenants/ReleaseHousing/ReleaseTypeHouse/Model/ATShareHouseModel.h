//
//  ATShareHouseModel.h
//  AnnTenants
//
//  Created by HuangGang on 2018/4/16.
//  Copyright © 2018年 Harely. All rights reserved.
//联系多张表：https://blog.csdn.net/bbnbf/article/details/6319123

#import <Foundation/Foundation.h>

//在`ARC`环境下，在结构体中使用`objc`对象，必须使用  `__unsafe_unretained`，这个是苹果的规定。struct 只能用于基本数据类型，放对象易形成野指针
struct ShareHouseModelStruct {
	 __unsafe_unretained NSString *sectionTitle;
	int selectType;
//	__unsafe_unretained NSArray *rowsInfo;  //__unsafe_unretained:和__weak 一样，唯一的区别便是，对象即使被销毁，指针也不会自动置空 ,此时指针指向的是一个无用的野地址。如果使用此指针，程序会抛出 BAD_ACCESS 的异常。
};
typedef struct ShareHouseModelStruct ShareHouseModelStruct;

//CG_INLINE:CoreGraphics里的内联函数，在函数前声明后编译器执行起来更具效率，使宏的定义更节省，不涉及栈的操作。
CG_INLINE ShareHouseModelStruct ShareHouseModelStructMake(NSString *sectionTitle, int type, NSArray *rowsInfo) {
	ShareHouseModelStruct shareHouseMStruct;
	shareHouseMStruct.sectionTitle = sectionTitle;
	shareHouseMStruct.selectType = type;
//	shareHouseMStruct.rowsInfo = rowsInfo;
	return shareHouseMStruct;
};

@interface ATShareHouseModel : NSObject

//功能名称(每个Cell的Section标题)
@property (nonatomic, copy) NSString *functionTitle;
//房源发布信息
@property (nonatomic, copy) NSString *houseInfo;
//图标样式
@property (nonatomic, copy) NSString *iconName;
//Cell的样式
@property (nonatomic, copy) NSString *cellStyle;

@property (nonatomic, strong) NSMutableArray *infos;


//带参构造函数
- (ATShareHouseModel *) initWithFunctionTitle:(NSString *)funcitonTitle andHouseInfo:(NSString *)houseInfo icon:(NSString *)iconName cellStyle:(NSString *) cellStyle;

//带参的静态对象初始化方法
+ (ATShareHouseModel *) initWithFunctionTitle:(NSString *)funcitonTitle andHouseInfo:(NSString *)houseInfo icon:(NSString *)iconName cellStyle:(NSString *) cellStyle;

//楼层/总楼层数组
- (NSMutableArray *) PickerViewForfloors;
- (NSMutableArray *) PickerViewForHouseTypes;
- (NSMutableArray *) PickerViewForOnHireDuration;


//地区
- (NSArray *) districts;
//朝向
- (NSArray *) orientations;
//装修
- (NSArray *) decorations;
- (ShareHouseModelStruct) decorationStruct;
//配置
- (NSArray *) houseConfigurations;
//付款方式
- (NSArray *) paymentWays;
//对租客要求
- (NSArray *) retenrRequires;


    
@end
