//
//  ATRegisterViewModel.swift
//  AnnTenants
//
//  Created by HuangGang on 2018/4/1.
//  Copyright © 2018年 Harely. All rights reserved.
//

import UIKit

@objc
class ATRegisterViewModel: NSObject {
//    private 只允许在当前类中调用，不包括 Extension
    private var registerModel = ATRegisterModel()
    private var headModel = ATMyHeadModel()
//    public修饰的属性或者方法可以在其他作用域被访问
    
//    使用依赖注入，便于解耦和单元测试
    public func setRegisterModel(model: ATRegisterModel) {
        self.registerModel = model
    }
    
    func register(nickName: String, phoneNumber: String, password: String, success: ()-> Bool) {
        if success() {
            self.registerModel.userId = ATTools.createUniqueUUID()
//            self.registerModel.nickName = nickName
//            self.registerModel.phoneNumber = phoneNumber
//            self.registerModel.password = password
            self.headModel.userId = ATTools.createUniqueUUID()
            self.headModel.nickName = nickName
            self.headModel.phoneNumber = phoneNumber
            self.headModel.password = password
            self.headModel.sex = "man"
            self.headModel.avatarPath = "headPortrait"
            
            //         模型转化为字典
//            let registerDic: [String: Any] = self.registerModel.toJSON()
            let registerDic: [String: Any] = ["userId": self.headModel.userId, "nickName": nickName, "phoneNumber": phoneNumber, "password": password, "sex": 1, "avatarPath": "headPortrait"]
            
            let isRegister = ATSQLiteManager.isInsertData(forRegister: registerDic)
            if !isRegister {
                ATLog("注册失败!")
            }else {
                ATUserManager.shareUser().userId = self.headModel.userId
                ATUserManager.shareUser().nickName = nickName
                ATUserManager.shareUser().password = password
                ATUserManager.shareUser().phoneNumber = phoneNumber
                ATUserManager.shareUser().sex = 1
                ATUserManager.shareUser().avatarPath = "headPortrait"
            }
        }else {
            ATLog("\("密码或者手机号错误")")
        }
    }
    
//    MARK: - 判断字符串是不是手机号
    class func isTelNumber(num:NSString)->Bool {
        let mobile = "^1((3[0-9]|4[57]|5[0-35-9]|7[0678]|8[0-9])\\d{8}$)"
        let  CM = "(^1(3[4-9]|4[7]|5[0-27-9]|7[8]|8[2-478])\\d{8}$)|(^1705\\d{7}$)";
        let  CU = "(^1(3[0-2]|4[5]|5[56]|7[6]|8[56])\\d{8}$)|(^1709\\d{7}$)";
        let  CT = "(^1(33|53|77|8[019])\\d{8}$)|(^1700\\d{7}$)";
        
        let regextestmobile = NSPredicate(format: "SELF MATCHES %@",mobile)
        let regextestcm = NSPredicate(format: "SELF MATCHES %@",CM )
        let regextestcu = NSPredicate(format: "SELF MATCHES %@" ,CU)
        let regextestct = NSPredicate(format: "SELF MATCHES %@" ,CT)
        
        if ((regextestmobile.evaluate(with: num) == true) || (regextestcm.evaluate(with: num)  == true)
            || (regextestct.evaluate(with: num) == true) || (regextestcu.evaluate(with: num) == true)) {
            return true
        }else {
            return false
        }
    }
    
}
