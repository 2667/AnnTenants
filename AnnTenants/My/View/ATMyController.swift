//
//  ATMyController.swift
//  AnnTenants
//
//  Created by HuangGang on 2018/3/12.
//  Copyright © 2018年 Harely. All rights reserved.
//
//swift更新：http://blog.csdn.net/ios_qing/article/details/52812187

import UIKit

class ATMyController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    lazy var headView: ATMyHeadView = {
        let view = ATMyHeadView()
        view.atMyController = self
        view.backgroundColor = ATRGBA(r: 56, g: 149, b: 245, alpha: 1.0)
        return view
    }()
    
    lazy var contentView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ATMyTableCellView.self, forCellReuseIdentifier: "ATMyTableViewCell") //注册cell
        tableView.separatorColor = UIColor.clear
        tableView.backgroundColor = UIColor.white
        tableView.estimatedRowHeight = 44.0 //推测高度，可以随便写
        tableView.rowHeight = UITableViewAutomaticDimension //ios8之后默认这个值
        return tableView
    }()
    
//    绑定的ViewModel属性
    private var viewModel: ATMyViewModel?
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.layoutOfTheControls()
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let userID = ATUserManager.shareUser().userId;
        let collects = ATHouseResourceViewModel.getCollectDataFromSQLDatabase(withUserId: userID)
        let reservations = ATHouseResourceViewModel.getReservationDataFromSQLDatabase(withUserId: userID)
        let empty = "     "
        self.headView.loginBtn.setTitle(String(format:"%@\n%@\n%@", ATUserManager.shareUser().nickName,empty, ATUserManager.shareUser().phoneNumber), for: .normal)
        self.headView.chtlLabel.text = String(collects?.count ?? 0)
        self.headView.rltlLabel.text = String(reservations?.count ?? 0)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        隐藏导航栏
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
//        View绑定ViewModel
        let viewModel = ATMyViewModel(myModel: nil)
        self.viewModel = viewModel
        
        print("---------------------------未执行-")
        if !ATTools.isBlankString(ATUserManager.shareUser().userId) {
            self.viewModel?.myModel?.fuctionArray[1][2] = "注销"
            print("执行代码了-----改为注销---------》\(self.contentView)")
            self.contentView.reloadData()
        }

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func  layoutOfTheControls () {
        self.view.addSubview(self.headView)
        self.headView.snp.makeConstraints({ (make) in
            make.left.top.right.equalTo(self.view)
            make.height.equalTo(200)
        })
        
        self.view.addSubview(self.contentView)
        self.contentView.snp.makeConstraints { (make) in
            make.top.equalTo(self.headView.snp.bottom).inset(-35)
            make.left.right.bottom.equalTo(self.view)
        }
    }

//     MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let sections = self.viewModel?.myModel?.fuctionArray.count else { return 1}
        return sections
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let array = self.viewModel?.myModel?.fuctionArray, array.count > 0 { //可选绑定，if判断正确用于第一个分支，第二个分支不能使用
            return array[section].count
        }
        return 0
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: ATMyTableCellView = tableView.dequeueReusableCell(withIdentifier: "ATMyTableViewCell", for: indexPath) as! ATMyTableCellView
        if cell.isEqual(nil) {
            cell = ATMyTableCellView.init(style: .default, reuseIdentifier: "ATMyTableViewCell")
        }
        self.viewModel?.loadDataForImageAndLabel(indexPath: indexPath)
        cell.viewModel = self.viewModel
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    
//    MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let controller = self.viewModel?.myModel?.controllers[indexPath.section][indexPath.row] else {
            ATLog("didSelectRowAt 错了")
            return
        }
        if controller.isKind(of: ATLoginController.self) {
            if self.viewModel?.myModel?.fuctionArray[1][2] == "注销" {
                ATUserManager.deleteAllUserInformation()
                self.viewModel?.myModel?.fuctionArray[1][2] = "注册和登录"
                self.contentView.reloadData()
                let empty = "     "
                self.headView.loginBtn.setTitle(String(format:"%@\n%@\n%@", ATUserManager.shareUser().nickName,empty, ATUserManager.shareUser().phoneNumber), for: .normal)
                self.headView.headPortrait.image = UIImage(named: "headPortrait")
                let userID = ATUserManager.shareUser().userId;
                let reservations = ATHouseResourceViewModel.getReservationDataFromSQLDatabase(withUserId: userID)
                let collects = ATHouseResourceViewModel.getCollectDataFromSQLDatabase(withUserId: userID)
                self.headView.chtlLabel.text = String(collects?.count ?? 0)
                self.headView.rltlLabel.text = String(reservations?.count ?? 0)
            }else {
                self.navigationController?.pushViewController(controller, animated: true)
            }
        }else {
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    
//    MARK: - 状态栏的改变
//     状态栏的样式
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent //状态栏白色
    }
    
//    状态栏的隐藏与否
    override var prefersStatusBarHidden: Bool  {
        return  true
    }
//    状态栏的隐藏与显示动画方式
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
         return   .slide
    }
}
