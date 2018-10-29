//
//  MacroDefinition.swift
//  AnnTenants
//
//  Created by HuangGang on 2018/3/14.
//  Copyright © 2018年 Harely. All rights reserved.
// 新建swift宏定义文件：选择iOS -> Source -> Swift File

import Foundation
import UIKit

//MARK: - App颜色主色调
let ATMainTonalColor = ATRGBA(r: 86, g: 204, b: 253, alpha: 1.0)    //#56CCFD
let ATDefaultColor = ATRGBA(r: 154, g: 174, b: 186, alpha: 1.0)   //#9AAEBA

//MARK: - 屏幕宽、高
let SCREEN_WIDTH = UIScreen.main.bounds.width
let SCREEN_HEIGHT = UIScreen.main.bounds.height

//MARK: -  屏幕bounds
let SCREEN_BOUNDS = UIScreen.main.bounds


//MARK: - 控件名
//MARK: - 我的
let loginImmediately = "立即登录"
let collectHouses = "收藏房源"
let reservationList = "预约清单"
let housingSubscription = "房源订阅"
let iReleasedTheHouseSource = "我发布的房源"
let versionNumber = "版本号"
let contactUs =   "联系我们"
let loginAndRegistration = "登录和注册"


//#MARK: 注册/登录
let login = "登录"
let register = "注册"
let registerNewUsers = "注册新用户"
let loginWithAnExistingAccount = "使用已有账户登录"
let inputPhoneNumberStr = "输入手机号"
let inputPasswordStr = "输入密码"
let enterANickname = "输入昵称"
let fillInVerificationCode = "填写验证码"
let enterPasswordAgain = "再次输入密码"





//MARK: - FUNCTION
func ATRGBA(r: CGFloat, g: CGFloat,b: CGFloat, alpha: CGFloat) ->UIColor{
    return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: alpha)
}

//MARK: - 宏定义打印语句
//自定义打印日志
func ATLog<T>(_ message: T, fileName: String = #file, methodName: String = #function, lineNumber: Int = #line){
    //文件名、方法、行号、打印信息
    //print("\(fileName as NSString)\n方法:\(methodName)\n行号:\(lineNumber)\n打印信息\(message)");
    print("错误日志:methodName:\(methodName)  lineNumbers:\(lineNumber)\n~~~~~~>:\(message)\n");
}

