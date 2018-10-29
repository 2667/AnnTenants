//
//  ATMyHeadView.swift
//  AnnTenants
//
//  Created by HuangGang on 2018/3/14.
//  Copyright © 2018年 Harely. All rights reserved.
//

import UIKit
import SnapKit

@objc
class ATMyHeadView: UIView, ImagePickerDelegate {

    lazy var headPortrait: UIImageView = {
        let headPortrait = UIImageView()
        headPortrait.layer.cornerRadius = 40
        headPortrait.layer.masksToBounds = true
        headPortrait.backgroundColor = UIColor.white
        
//        图片添加点击事件
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(ATMyHeadView.chooseHeadPortrait))
        headPortrait.addGestureRecognizer(tapGesture)
        headPortrait.isUserInteractionEnabled = true
        
        return headPortrait
    }()
    
    lazy var loginBtn: UIButton = {
        let login = UIButton()
        login.setTitle(loginImmediately, for: .normal)
        login.backgroundColor = UIColor.clear
        login.setTitleColor(UIColor.white, for: .normal)
        login.titleLabel?.lineBreakMode = .byWordWrapping
        login.titleLabel?.numberOfLines = 3
        login.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
        login.addTarget(self, action: #selector(showUserInfoAction), for: .touchUpInside)
        return login
    }()
    
    lazy var manageView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5.0
        view.layer.masksToBounds = true
        view.backgroundColor = UIColor.gray
        return view
    }()
    
    lazy var collectHousesBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor.white
        btn.addTarget(self, action: #selector(collectAction), for: .touchUpInside)
        return btn
    }()
    
    lazy var chtlLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30.0)
        label.text = "0"
        return label
    }()
    
    lazy var chtrLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15.0)
        label.text = "套"
        return label
    }()
    
    lazy var chbLabel: UILabel = {
        let label = UILabel()
        label.text = collectHouses
        return label
    }()

    lazy var verticalBarView: UIView = {
        let view = UIView()
        view.backgroundColor = ATDefaultColor
        return view
    }()
    
    lazy var reservationListBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor.white
        btn.addTarget(self, action: #selector(reservationAction), for: .touchUpInside)
        return btn
    }()
    
    lazy var rltlLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30.0)
        label.text = "0"
        return label
    }()
    
    lazy var rltrLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15.0)
        label.text = "套"
        return label
    }()
    
    lazy var rlbLabel: UILabel = {
        let label = UILabel()
        label.text = reservationList
        return label
    }()

    var atMyController: ATMyController?
    var collectResources: NSMutableArray?
    
    
    lazy var pickerController: ATPickerController = {
        let controller = ATPickerController()
        controller.delegate = self
        return controller
    }()

    
    
    deinit {
        print("----------------->ATMyHeadVeiw  内存未泄露")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layoutOfTheControls()
        self.loadData()
    }
    
    
    func loadData() {
        if let headInfo = ATMyHeadViewModel.readHeadPortrait() {
            self.headPortrait.image = headInfo["headImage"] as? UIImage
            self.loginBtn.setTitle(ATUserManager.shareUser().nickName, for: .normal)
        }else {
            self.headPortrait.image = UIImage(named: "headPortrait")
        }
    }
    
    func chooseHeadPortrait() {
        weak var weakMC = self.atMyController
        
        if !ATTools.isBlankString(ATUserManager.shareUser().userId) {
            let alertController = UIAlertController()
            
            alertController.view.tintColor = ATRGBA(r: 21, g: 126, b: 251, alpha: 1.0)
            let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            let directMessagesAction = UIAlertAction(title: "从相册选择", style: .default) { (action) in
                weakMC?.present(self.pickerController, animated: false, completion: {
                    self.pickerController.choosePicture(ofNumbers: 1)
                })
            }
            let focusOnAction = UIAlertAction(title: "拍照", style: .destructive) { (action) in
                self.pickerController.headView = self
                weakMC?.present(self.pickerController, animated: false, completion: {
                    self.pickerController.cameraAction()
                })
                //            self.getHeadPortraitFromCamera(headPortrait: UIImage.init(named: "icon"))
            }
            alertController.addAction(focusOnAction)
            alertController.addAction(directMessagesAction)
            alertController.addAction(cancelAction)
            weakMC?.present(alertController, animated: true, completion: nil)
        }else {
            let alertC = ATAlertController.init(title: "提示", message: "请先登录或者注册", preferredStyle: .alert)
            atMyController?.present(alertC, animated: true, completion: nil)
            alertC.dissMissAlert()
        }
    }
    
//    func getHeadPortraitFromCamera(headPortrait: UIImage?, completion:(_ avatarImage: UIImage) ->()) {
//        self.headPortrait.image = headPortrait
//    }
    func getHeadPortraitFromCamera(headPortrait: UIImage?) {
        self.headPortrait.image = headPortrait
        ATMyHeadViewModel.saveHeadPortrait(headPortrait, withName: "ATHeadPortrait")
//        if let userDic = ATUserManager.shareUser().user, let avatarPath = String(userDic["avatarPath"]), avatarPath.isEmpty {
//            
//        }
    }
    
//    MARK: - ImagePickerDelegate
    func pickerPhotos(_ arrayPhotos: NSMutableArray!, assets arrayAssets: NSMutableArray!) {
        if arrayPhotos.count > 0 {
            guard let headImage = arrayPhotos.firstObject as? UIImage else { return }
            self.getHeadPortraitFromCamera(headPortrait: headImage)
            ATMyHeadViewModel.saveHeadPortrait(headImage, withName: "ATHeadPortrait")
        }else {
            ATLog("图片没有选择上")
        }
    }
    
//    MARK: - Action
    func reservationAction() {
        let homePageC = ATHomePageController()
        homePageC.hompageType = ATHomePageType.reservation
        atMyController?.navigationController?.pushViewController(homePageC, animated: true)
    }
    
    func collectAction() {
        let homePageC = ATHomePageController()
        homePageC.hompageType = ATHomePageType.collect
        atMyController?.navigationController?.pushViewController(homePageC, animated: true)
    }
    
    func showUserInfoAction() {
        
        if !ATTools.isBlankString(ATUserManager.shareUser().userId) {
            let myInfoC = ATMyInfoController()
            atMyController?.navigationController?.pushViewController(myInfoC, animated: true);
        }else {
            let alertC = ATAlertController.init(title: "提示", message: "请先登录或者注册", preferredStyle: .alert)
            atMyController?.present(alertC, animated: true, completion: nil)
            alertC.dissMissAlert()
        }
        
        
    }
    
//    MARK: - UI布局
    func layoutOfTheControls() {
        self.addSubview(self.headPortrait)
        self.headPortrait.snp.makeConstraints { (make) in
            make.width.height.equalTo(80)
            make.left.equalTo(self).offset(14)
            make.top.equalTo(self).offset(60)
        }
        
        self.addSubview(self.loginBtn)
        self.loginBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self.headPortrait.snp.right).inset(-14)
            make.height.equalTo(80)
            make.width.equalTo(180)
            make.centerY.equalTo(self.headPortrait)
        }
        
        self.addSubview(self.manageView)
        self.manageView.snp.makeConstraints { (make) in
            make.width.equalTo(290)
            make.height.equalTo(70)
            make.left.equalTo(self).offset(15)
            make.top.equalTo(self).offset(165)
        }
        
        self.manageView.addSubview(self.collectHousesBtn)
        self.collectHousesBtn.snp.makeConstraints { (make) in
            make.left.top.bottom.equalTo(self.manageView)
            make.width.equalTo(self.manageView).multipliedBy(0.5)
        }
        
        self.collectHousesBtn.addSubview(self.chtlLabel)
        self.chtlLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.collectHousesBtn).offset(-13)
            make.top.equalTo(self.collectHousesBtn).offset(5)
        }
        self.collectHousesBtn.addSubview(self.chtrLabel)
        self.chtrLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.chtlLabel.snp.right).inset(-3)
            make.bottom.equalTo(self.chtlLabel).inset(5)
        }
        self.collectHousesBtn.addSubview(self.chbLabel)
        self.chbLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.collectHousesBtn)
            make.bottom.equalTo(self.collectHousesBtn).offset(-5)
        }
        
        self.manageView.addSubview(self.verticalBarView)
        self.verticalBarView.snp.makeConstraints { (make) in
            make.center.equalTo(self.manageView)
            make.width.equalTo(3)
            make.height.equalTo(self.manageView).multipliedBy(0.75)
        }
        
        self.manageView.addSubview(self.reservationListBtn)
        self.reservationListBtn.snp.makeConstraints { (make) in
            make.top.right.bottom.equalTo(self.manageView)
            make.width.equalTo(self.manageView).multipliedBy(0.5)
        }
        self.reservationListBtn.addSubview(self.rltlLabel)
        self.rltlLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.reservationListBtn).offset(-13)
            make.top.equalTo(self.collectHousesBtn).offset(5)
        }
        self.reservationListBtn.addSubview(self.rltrLabel)
        self.rltrLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.rltlLabel.snp.right).inset(-3)
            make.bottom.equalTo(self.rltlLabel).inset(5)
        }
        self.reservationListBtn.addSubview(self.rlbLabel)
        self.rlbLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.reservationListBtn)
            make.bottom.equalTo(self.reservationListBtn).offset(-5)
        }
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
