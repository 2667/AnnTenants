//
//  ATMyViewModel.swift
//  AnnTenants
//
//  Created by HuangGang on 2018/3/17.
//  Copyright © 2018年 Harely. All rights reserved.
//

import UIKit

class ATMyModel: NSObject {

    lazy var fuctionArray: [[String]] = {
        var array = [[String]]()
        array.append(["房源订阅","我发布的房源"])//,
        array.append(["版本号", "联系我们", "登录和注册"])
        return array
    }()
    
    lazy var functionImages: [[String]] = {
        var array = [[String]]()
        array.append(["housingSubscription", "housingResource"])
        array.append(["versionNumber", "contact", "loginAndRegist@3x"])
        return array
    }()
    
    lazy var controllers: [[UIViewController]] = {
        var array = [[UIViewController]]()
        
        let gaoDeMapC = ATGaoDeController()
        gaoDeMapC.hidesBottomBarWhenPushed = true;
        
        let myPublishHouse = ATHomePageController()
        myPublishHouse.hompageType = ATHomePageType.publishHouse
        
        let functionVN = ATFunctionController()
        functionVN.functionType = ATFunctionType.versionNumber
        
        let functionCU = ATFunctionController()
        functionCU.functionType = ATFunctionType.contactUs
        
        array.append([gaoDeMapC, myPublishHouse])//ViewController(), 
        array.append([functionVN, functionCU, ATLoginController()])
        return array
    }()
    
    
}
