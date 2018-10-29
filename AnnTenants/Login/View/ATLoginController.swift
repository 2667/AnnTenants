//
//  ATLoginController.swift
//  AnnTenants
//
//  Created by HuangGang on 2018/3/12.
//  Copyright © 2018年 Harely. All rights reserved.
//

import UIKit

class ATLoginController: UIViewController {
    lazy var inputPhoneNumber: UITextField = {
        let textField = UITextField()
        textField.placeholder = inputPhoneNumberStr
        return textField
    }()
    
    lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = ATDefaultColor
        return  view
    }()
    
    lazy var inputPassword: UITextField = {
        let textField = UITextField()
        textField.placeholder = inputPasswordStr
        textField.isSecureTextEntry = true;
        return textField
    }()
    
    lazy var lineViewOne: UIView = {
        let view = UIView()
        view.backgroundColor = ATDefaultColor
        return  view
    }()
    
    lazy var loginBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle(login, for: .normal)
        btn.setTitleColor(ATMainTonalColor, for: .normal)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 5.0
        btn.layer.borderWidth = 1.5
        btn.layer.borderColor = ATMainTonalColor.cgColor
        btn.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
        return btn
    }()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = login
        self.view.backgroundColor = UIColor.white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: register, style: UIBarButtonItemStyle.plain, target: self, action: #selector(pushToLoginController))
        
        self.layoutOfTheControls()
    }
    
    func loginAction() {
        guard let phoneNumber = self.inputPhoneNumber.text else {
            ATLog("手机号错误")
            return
        }
        guard let password = self.inputPassword.text else {
            ATLog("输入密码错误")
            return
        }
        let isLogin = ATLoginViewModel.login(phoneNumber, password)
        if !isLogin.isPhoneNumber {
            self.alert(title: "输入提示", message: "手机号错误，可以思考下")
        }
        
        if !isLogin.isPassword {
            self.alert(title: "输入提示", message: "密码错误，可以思考下")
        }
        
        if isLogin.isPassword && isLogin.isPhoneNumber {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    func pushToLoginController() {
        self.navigationController?.pushViewController(ATLoginedController(), animated: true)
    }
    
    func alert(title: String?, message: String) {
        let alertController = UIAlertController(title: title,
                                                message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "好的", style: .default, handler: {
            action in
            print("点击了确定")
        })
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    fileprivate func layoutOfTheControls() {
        
        self.view.addSubview(self.inputPhoneNumber)
        self.inputPhoneNumber.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(80)
            make.left.equalTo(self.view).offset(13)
            make.right.equalTo(self.view).offset(-13)
            make.height.equalTo(40)
        }
        self.inputPhoneNumber.addSubview(self.lineView)
        self.lineView.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.inputPhoneNumber).offset(-1)
            make.height.equalTo(1)
            make.left.right.equalTo(self.inputPhoneNumber)
        }
        
        self.view.addSubview(self.inputPassword)
        self.inputPassword.snp.makeConstraints { (make) in
            make.top.equalTo(self.inputPhoneNumber.snp.bottom).inset(-16)
            make.left.right.height.equalTo(self.inputPhoneNumber)
        }
        self.inputPassword.addSubview(self.lineViewOne)
        self.lineViewOne.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.inputPassword).offset(-1)
            make.height.equalTo(1)
            make.left.right.equalTo(self.inputPassword)
        }
        
        self.view.addSubview(self.loginBtn)
        self.loginBtn.snp.makeConstraints { (make) in
            make.top.equalTo(self.inputPassword.snp.bottom).inset(-16)
            make.left.right.height.equalTo(self.inputPhoneNumber)
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
