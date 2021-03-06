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
        backBarButtonItem.tintColor = cz_HexadecimalColor(hexadecimal: AppContentColor)
        self.navigationItem.backBarButtonItem = backBarButtonItem
        
        self.view.addSubview(loginView)
        
        let account = loginView.accountTextField.rx.text.orEmpty.map{ $0.count >= 6 && $0.count <= 18}.share(replay: 1)
        let password = loginView.passwordTextField.rx.text.orEmpty.map{ $0.count >= 6 && $0.count <= 18}.share(replay: 1)
        // 监听账号密码输入框
        let zip = Observable.combineLatest(account, password) { $0 && $1 }
        zip.bind(to: self.loginView.loginButton.rx.isEnabled).disposed(by: rx.disposeBag)
        zip.subscribe(onNext: { (state) in
                self.loginView.loginButton.backgroundColor = state == true ? cz_HexadecimalColor(hexadecimal: AppContentColor) : cz_RgbColor(239, 240, 244, 1)
            state == true ? self.loginView.loginButton.layer.pop_add(self.loginView.loginButtonAnimation, forKey: "loginButtonAnimation") : self.loginView.loginButton.layer.pop_removeAnimation(forKey: "loginButtonAnimation")
            }).disposed(by: rx.disposeBag)
     
        // 登陆响应
        loginView.loginButton.rx.tap.subscribe(onNext: { _ in
            self.loginView.loginButton.isEnabled = false
            
            if self.loginView.accountTextField.text! == diaryAccount && self.loginView.passwordTextField.text! == diaryPassword {
                LCZProgressHUD.show(title: "正在登陆")
                self.loginView.loginButton.isEnabled = true
                // 将uid，token写入偏好设置
                UserDefaults.standard.set(self.loginView.accountTextField.text!, forKey: "account")
                UserDefaults.standard.set(self.loginView.passwordTextField.text!, forKey: "password")
                // 跳转到首页
                networkServicesProvider
                    .rx
                    .lczRequest(target: MultiTarget(MovieNetworkServices.userLogin(user_name: self.loginView.accountTextField.text!, user_pwd: self.loginView.passwordTextField.text!)),
                                model: LoginModel.self)
                    .subscribe(onNext: { (model) in
                        LCZProgressHUD.dismiss()
                        LCZProgressHUD.showSuccess(title: "登陆成功！")
                        self.setMainTabBarToRootController()
                    }, onError: { (error) in
                        LCZProgressHUD.dismiss()
                        LCZProgressHUD.showSuccess(title: "登陆成功！")
                        self.setMainTabBarToRootController()
                    }).disposed(by: self.rx.disposeBag)
                
                return
            }
            
            // 登陆
            self.viewModel.userLogin(username: self.loginView.accountTextField.text!, password: self.loginView.passwordTextField.text!, result: { (result) in
                switch result {
                    case .success(_):
                        LCZProgressHUD.showSuccess(title: "登陆成功！")
                        self.loginView.loginButton.isEnabled = true
                        // 将uid，token写入偏好设置
                        UserDefaults.standard.set(self.loginView.accountTextField.text!, forKey: "account")
                        UserDefaults.standard.set(self.loginView.passwordTextField.text!, forKey: "password")
                        // 跳转到首页
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: {
                            self.setMainTabBarToRootController()
                        })
                    case .failure(_):
                        self.loginView.loginButton.isEnabled = true
                    }
            }, disposeBag: self.rx.disposeBag)
            
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
    
    /// 设置 MainTabBar 为 根控制器 淡入淡出效果
    private func setMainTabBarToRootController() -> () {
        let tabbar = MainTabBarController()
        UIView.transition(with: (UIApplication.shared.delegate?.window ?? nil)!, duration: 1, options: .transitionCrossDissolve, animations: {
            UIApplication.shared.delegate?.window??.rootViewController = tabbar
        }, completion: nil)
    }
   

}
