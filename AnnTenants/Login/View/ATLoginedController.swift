//
//  ATLoginedController.swift
//  AnnTenants
//
//  Created by HuangGang on 2018/3/19.
//  Copyright © 2018年 Harely. All rights reserved.
//

import UIKit

@objc
class ATLoginedController: UIViewController, UITextFieldDelegate {
    lazy var registerVM = ATRegisterViewModel()
    
    lazy var enterANicknameText: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.placeholder = enterANickname
        return textField
    }()
    
    lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = ATDefaultColor
        return  view
    }()
    
    lazy var inputPhoneNumberText: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.placeholder = inputPhoneNumberStr
        return textField
    }()
    
    lazy var lineViewOne: UIView = {
        let view = UIView()
        view.backgroundColor = ATDefaultColor
        return  view
    }()
    
    lazy var fillInVerificationCodeText: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.placeholder = fillInVerificationCode
        return textField
    }()
    
    lazy var lineViewTwo: UIView = {
        let view = UIView()
        view.backgroundColor = ATDefaultColor
        return  view
    }()
    
    lazy var inputPasswordText: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.placeholder = inputPasswordStr
        textField.isSecureTextEntry = true
        return textField
    }()
    
    lazy var lineViewThree: UIView = {
        let view = UIView()
        view.backgroundColor = ATDefaultColor
        return  view
    }()
    
    lazy var enterPasswordAgainText: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.placeholder = enterPasswordAgain
        textField.isSecureTextEntry = true
        return textField
    }()
    
    lazy var lineViewFour: UIView = {
        let view = UIView()
        view.backgroundColor = ATDefaultColor
        return  view
    }()
    
    lazy var registerBtn: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.setTitle(register, for: .normal)
        button.backgroundColor = ATMainTonalColor
        button.addTarget(self, action: #selector(registerAction), for: .touchUpInside)
        return button
    }()
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = "注册新账号"
        
        self.layoutOfTheControls()
    }
    
    func registerAction()  {
        guard let nickName = self.enterANicknameText.text else {
            ATLog("nil")
            return
        }
        guard let phoneNumber = self.inputPhoneNumberText.text else {
            ATLog("nil")
            return
        }
        guard let password = self.enterPasswordAgainText.text else {
            ATLog("nil")
            return
        }
        
        self.registerVM.register(nickName: nickName, phoneNumber: phoneNumber, password: password) { [weak self](_)  -> Bool in
            guard let weakSelf = self else { return false}
            let isPassword = weakSelf.enterPasswordAgainText.text == weakSelf.inputPasswordText.text
            guard weakSelf.inputPhoneNumberText.text != nil else {
                return false
            }
            let isPhoneNumber = ATRegisterViewModel.isTelNumber(num: NSString.init(string: "13524356520"))//phoneNumber
            let isRegister: Bool = isPassword && isPhoneNumber
            if isRegister != true {
                weakSelf.showAlertView(statements: "密码(或者手机号输错!)", statements: "您确定需要重新输入吗?")
            }
            
            if isRegister {
                self?.navigationController?.popToRootViewController(animated: true)
            }else {
                self?.showAlertView(statements: "注册失败", statements: "请确认填写信息")
            }
            
            return isRegister
        }
    }
    
    func showAlertView(statements title: String?, statements message: String?) {
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
    
    //    MARK: - UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //        收起键盘
        textField.resignFirstResponder()
        return true
    }
    
    //    询问是否可以编辑 true 可以编辑  false 不能编辑
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    fileprivate func layoutOfTheControls() {
        
        self.view.addSubview(self.enterANicknameText)
        self.enterANicknameText.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(80)
            make.left.equalTo(self.view).offset(13)
            make.right.equalTo(self.view).offset(-13)
            make.height.equalTo(40)
        }
        self.enterANicknameText.addSubview(self.lineView)
        self.lineView.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.enterANicknameText).offset(-1)
            make.height.equalTo(1)
            make.left.right.equalTo(self.enterANicknameText)
        }
        
        self.view.addSubview(self.inputPhoneNumberText)
        self.inputPhoneNumberText.snp.makeConstraints { (make) in
            make.top.equalTo(self.enterANicknameText.snp.bottom).inset(-16)
            make.left.right.height.equalTo(self.enterANicknameText)
        }
        self.inputPhoneNumberText.addSubview(self.lineViewOne)
        self.lineViewOne.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.inputPhoneNumberText).offset(-1)
            make.height.equalTo(1)
            make.left.right.equalTo(self.inputPhoneNumberText)
        }
        
        self.view.addSubview(self.fillInVerificationCodeText)
        self.fillInVerificationCodeText.snp.makeConstraints { (make) in
            make.top.equalTo(self.inputPhoneNumberText.snp.bottom)
            make.left.right.equalTo(self.enterANicknameText)
            make.height.equalTo(0)
        }
        
        self.view.addSubview(self.inputPasswordText)
        self.inputPasswordText.snp.makeConstraints { (make) in
            make.top.equalTo(self.fillInVerificationCodeText.snp.bottom).inset(-16)
            make.left.right.height.equalTo(self.enterANicknameText)
        }
        self.view.addSubview(self.lineViewThree)
        self.lineViewThree.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.inputPasswordText).offset(-1)
            make.height.equalTo(1)
            make.left.right.equalTo(self.inputPasswordText)
        }
        
        self.view.addSubview(self.enterPasswordAgainText)
        self.enterPasswordAgainText.snp.makeConstraints { (make) in
            make.top.equalTo(self.inputPasswordText.snp.bottom).inset(-16)
            make.left.right.height.equalTo(self.inputPasswordText)
        }
        self.view.addSubview(self.lineViewFour)
        self.lineViewFour.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.enterPasswordAgainText).offset(-1)
            make.height.equalTo(1)
            make.left.right.equalTo(self.enterPasswordAgainText)
        }
        
        self.view.addSubview(self.registerBtn)
        self.registerBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.enterPasswordAgainText.snp.bottom).inset(-16)
            make.width.equalTo(200)
            make.height.equalTo(44)
        }
    }
    
}
