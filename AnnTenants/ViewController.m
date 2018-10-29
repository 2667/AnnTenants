//
//  ViewController.m
//  AnnTenants
//
//  Created by HuangGang on 2018/3/9.
//  Copyright © 2018年 Harely. All rights reserved.
//
//创建数据库：http://www.360doc.com/content/16/0621/18/33122719_569589858.shtml， http://blog.csdn.net/heng615975867/article/details/45317847

//http://blog.csdn.net/lv_ruanruan/article/details/42104235， http://blog.csdn.net/wakice/article/details/55190428

//用这个关键字搜：Objective-C 使用mysql 配置
//OC使用mysql：http://www.cocoachina.com/ios/20100610/1667.html 错的

//https://www.cnblogs.com/visonhome/p/4604247.html， http://blog.csdn.net/dangfm/article/details/25243105

//使用sqlite：https://www.cnblogs.com/yajunLi/p/7204905.html

#import "ViewController.h"
//#import "mysql.h"

@interface ViewController ()
{
    sqlite3 *db; //数据库句柄
    
//    MYSQL *myconnect;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor redColor];
    

}


@end
