//
//  ATRegisterModel.swift
//  AnnTenants
//
//  Created by HuangGang on 2018/4/1.
//  Copyright © 2018年 Harely. All rights reserved.
//

import UIKit
import ObjectMapper

class ATRegisterModel: Mappable {
    var userId: String?
    var nickName: String?
    var phoneNumber: String?
    var password: String?
    var sex: Int?
    var avatarPath:String?
    
    
    
    init() {}
    
    required init?(map: Map) {}
    
//    Mappable
    func mapping(map: Map) {
        userId <- map["userId"]
        nickName <- map["nickName"]
        phoneNumber <- map["phoneNumber"]
        password <- map["password"]
        sex <- map["sex"]
        avatarPath <- map["avatarPath"]
    }
    
}
