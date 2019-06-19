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
        
        // 监听账号密码输入框
        Observable.combineLatest(loginView.accountTextField.rx.text, loginView.passwordTextField.rx.text) {$0!.count > 0 && $1!.count > 0}
            .subscribe(onNext: { (state) in
                self.loginView.loginButton.backgroundColor = state == true ? LCZHexadecimalColor(hexadecimal: "#FECE1D") : LCZRgbColor(239, 240, 244, 1)
                self.loginView.loginButton.isEnabled = state
            }).disposed(by: rx.disposeBag)
     
        // 登陆响应
        loginView.loginButton.rx.tap.subscribe(onNext: { _ in
            self.loginView.loginButton.isEnabled = false
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
            self.navigationController?.pushViewController(RegisterViewController(), animated: true)
        }).disposed(by: rx.disposeBag)
        
    }
    

   

}
