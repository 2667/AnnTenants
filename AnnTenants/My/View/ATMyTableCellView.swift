//
//  ATMyTableView.swift
//  AnnTenants
//
//  Created by HuangGang on 2018/3/16.
//  Copyright © 2018年 Harely. All rights reserved.
//

import UIKit

class ATMyTableCellView: UITableViewCell {
    
//    private只能用于本类中，不能用于子类、扩展类中
    private var housingSubscriptionIV: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private var housingSubscriptionLb: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private var rightArrowImg: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "rightArrow"))
        return imageView
    }()
    
    private var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = ATRGBA(r: 230, g: 230, b: 230, alpha: 1.0)
        return view
    }()
    
//    绑定数据
    var viewModel: ATMyViewModel? {
        didSet{
            if let model = self.viewModel {
                guard let imageStr = model.functionImgStr else {
                    ATLog(model.functionImgStr)
                    return
                }
                guard let labelTitle = model.functionLaStr else {
                    ATLog(model.functionImgStr)
                    return
                }
                self.housingSubscriptionIV.image = UIImage(named: imageStr)
                self.housingSubscriptionLb.text = labelTitle
            }
        }
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.layoutOfTheControls()
    }
    
//    fileprivate只能在其子类、本类、扩展类中使用
    fileprivate func layoutOfTheControls() {
        
        self.contentView.addSubview(self.housingSubscriptionIV)
        self.housingSubscriptionIV.snp.makeConstraints { (make) in
            make.width.height.equalTo(18)
            make.left.equalTo(self.contentView).offset(17)
            make.centerY.equalTo(self.contentView)
        }
        
        self.contentView.addSubview(self.housingSubscriptionLb)
        self.housingSubscriptionLb.snp.makeConstraints { (make) in
            make.left.equalTo(self.housingSubscriptionIV.snp.right).inset(-10)
            make.centerY.equalTo(self.contentView)
        }
        
        self.contentView.addSubview(self.rightArrowImg)
        self.rightArrowImg.snp.makeConstraints { (make) in
            make.width.height.equalTo(20)
            make.right.equalTo(self.contentView).inset(20)
            make.centerY.equalTo(self.contentView)
        }
        
        self.contentView.addSubview(self.lineView)
        self.lineView.snp.makeConstraints { (make) in
            make.height.equalTo(1)
            make.left.equalTo(self.housingSubscriptionLb)
            make.right.equalTo(self.contentView)
            make.bottom.equalTo(self.contentView).inset(-1)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
