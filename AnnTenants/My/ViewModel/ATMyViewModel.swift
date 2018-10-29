//
//  ATMyViewModel.swift
//  AnnTenants
//
//  Created by HuangGang on 2018/3/17.
//  Copyright © 2018年 Harely. All rights reserved.
//

import UIKit

class ATMyViewModel: NSObject {
    var myModel: ATMyModel?
    
    var functionLaStr: String?
    var functionImgStr: String?
    

    init(myModel: ATMyModel?) {
        super.init()
        if (myModel != nil) {
            self.myModel = myModel
        } else {
            self.myModel = ATMyModel()
        }
    }
    
    func loadDataForImageAndLabel(indexPath: IndexPath?) {
        guard let section = indexPath?.section else { ATLog(indexPath); return }
        guard let row = indexPath?.row else {
            ATLog(indexPath)
            return
        }
        self.functionLaStr = self.myModel?.fuctionArray[section][row]
        self.functionImgStr = self.myModel?.functionImages[section][row]
    }
}
