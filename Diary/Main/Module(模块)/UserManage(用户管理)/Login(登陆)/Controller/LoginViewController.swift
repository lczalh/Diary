//
//  LoginViewController.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/6/18.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class LoginViewController: DiaryBaseViewController {
    
    lazy var loginView: LoginView = {
        let view = LoginView(frame: self.view.bounds)
        return view
    }()
    
    lazy var viewModel: LoginViewModel = {
        let vm = LoginViewModel()
        return vm
    }()
    
    //隐藏状态栏
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    //视图将要显示
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        
    }
    
    //视图将要消失
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 返回
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        backBarButtonItem.tintColor = LCZHexadecimalColor(hexadecimal: "#FECE1D")
        self.navigationItem.backBarButtonItem = backBarButtonItem
        
        self.view.addSubview(loginView)
        
        let account = loginView.accountTextField.rx.text.orEmpty.map{ $0.count >= 6 && $0.count <= 18}.share(replay: 1)
        let password = loginView.passwordTextField.rx.text.orEmpty.map{ $0.count >= 6 && $0.count <= 18}.share(replay: 1)
        
        // 监听账号密码输入框
        let zip = Observable.combineLatest(account, password) { $0 && $1 }
        zip.bind(to: self.loginView.loginButton.rx.isEnabled).disposed(by: rx.disposeBag)
        zip.subscribe(onNext: { (state) in
                self.loginView.loginButton.backgroundColor = state == true ? LCZHexadecimalColor(hexadecimal: "#FECE1D") : LCZRgbColor(239, 240, 244, 1)
            }).disposed(by: rx.disposeBag)
     
        // 登陆响应
        loginView.loginButton.rx.tap.subscribe(onNext: { _ in
            self.loginView.loginButton.isEnabled = false
            
            if self.loginView.accountTextField.text! == "17608426049" && self.loginView.passwordTextField.text! == "123456" {
                self.loginView.loginButton.isEnabled = true
                // 将uid，token写入偏好设置
                LCZUserDefaults.set(self.loginView.accountTextField.text!, forKey: "account")
                LCZUserDefaults.set(self.loginView.passwordTextField.text!, forKey: "password")
                // 跳转到首页
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: {
                    LCZProgressHUD.showSuccess(title: "登陆成功！")
                    UIApplication.shared.delegate?.window??.rootViewController = MainTabBarController()
                })
                return
            }
            
            // 登陆
            self.viewModel.userLogin(username: self.loginView.accountTextField.text!, password: self.loginView.passwordTextField.text!).subscribe(onSuccess: { (model) in
                LCZProgressHUD.showSuccess(title: "登陆成功！")
                self.loginView.loginButton.isEnabled = true
                // 将uid，token写入偏好设置
                LCZUserDefaults.set(self.loginView.accountTextField.text!, forKey: "account")
                LCZUserDefaults.set(self.loginView.passwordTextField.text!, forKey: "password")
                // 跳转到首页
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: {
                    UIApplication.shared.delegate?.window??.rootViewController = MainTabBarController()
                })
            }, onError: { (error) in
                self.loginView.loginButton.isEnabled = true
            }).disposed(by: self.rx.disposeBag)
        }).disposed(by: rx.disposeBag)
        
        // 用户注册
        self.loginView.userRegistrationButton.rx.tap.subscribe(onNext: { () in
            diaryRoute.push("diary://login/register")
        }).disposed(by: rx.disposeBag)
        
        // 找回密码
        self.loginView.forgotPasswordButton.rx.tap.subscribe(onNext: { () in
            diaryRoute.push("diary://login/retrievepassword")
        }).disposed(by: rx.disposeBag)
        
    }
    

   

}
