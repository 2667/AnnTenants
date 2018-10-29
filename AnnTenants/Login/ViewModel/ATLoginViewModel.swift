//
//  ATLoginViewModel.swift
//  AnnTenants
//
//  Created by HuangGang on 2018/4/5.
//  Copyright © 2018年 Harely. All rights reserved.
//
//访问关键字：https://blog.csdn.net/Mazy_ma/article/details/70135990

import UIKit

class ATLoginViewModel: NSObject {
    
//    typealias 定义一个别名相当于OC的Typedef
    /// 定义一个判断登录是否有这个用户的元组
    public typealias isLogin = (isPhoneNumber: Bool, isPassword: Bool)
    
    public class func login(_ phoneNumber: String, _ password: String) -> isLogin {
//        判断输入是为空
        let isPN = ATLoginViewModel.isStringEmpty(content: phoneNumber)
        let isPW = ATLoginViewModel.isStringEmpty(content: password)
        if !isPN || !isPW {
            return isLogin(isPhoneNumber: isPN, isPassword: isPW)
        }
        
        guard let resultPN:NSMutableArray = ATSQLiteManager.selectData("userId, nickName, phoneNumber, password", fromDatabase: "user", conditions: "phoneNumber = '\(phoneNumber)'") else { return isLogin(isPhoneNumber: false, isPassword: true) }
        guard let resultPW:NSMutableArray = ATSQLiteManager.selectData("userId, nickName, phoneNumber, password", fromDatabase: "user", conditions: "password = '\(password)'") else { return isLogin(isPhoneNumber: true, isPassword: false) }
        
        guard let result:NSMutableArray = ATSQLiteManager.selectData("userId, nickName, phoneNumber, password, sex, avatarPath", fromDatabase: "user", conditions: "password = '\(password)' and phoneNumber = '\(phoneNumber)'") else { return isLogin(isPhoneNumber: true, isPassword: false) }
        
        if resultPN.count > 0 && resultPW.count > 0{
            guard let dic:NSDictionary = result.firstObject as? NSDictionary else {
                ATLog("登录转化数据错误")
                return isLogin(isPhoneNumber: true, isPassword: true)
                
            }
            let userManager = ATUserManager.shareUser()
            userManager?.userId = dic["userId"] as! String
            userManager?.nickName = dic["nickName"] as! String
            userManager?.phoneNumber = dic["phoneNumber"] as! String
            userManager?.password = dic["password"] as! String
            userManager?.sex = UInt(Int(dic["sex"] as! String)!)
            userManager?.avatarPath = dic["avatarPath"] as! String
            
            return isLogin(isPhoneNumber: true, isPassword: true)
        }else if resultPN.count > 0 && resultPW.count == 0 {
            return isLogin(isPhoneNumber: true, isPassword: false)
        }else if resultPN.count == 0 && resultPW.count > 0 {
            return isLogin(isPhoneNumber: false, isPassword: true)
        }else {
            return isLogin(isPhoneNumber: false, isPassword: false)
        }
    }
    
//    MARK:- 字符串为空判断
    public class func isStringEmpty(content: String?) -> Bool{
//        创建一个字符集对象, 包含所有的空格和换行字符
        let set = NSCharacterSet.whitespacesAndNewlines
//        从字符串中过滤掉首尾的空格和换行, 得到一个新的字符串
        guard let contents = content?.trimmingCharacters(in: set) else { return false }
//        判断新字符串的长度是否大于0
        if contents.count > 0 {
            return true
        }else {
            return false
        }
    }
}
