//
//  RegisterViewController.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/6/19.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class RegisterViewController: DiaryBaseViewController {
    
    lazy var registerView: RegisterView = {
        let view = RegisterView(frame: self.view.bounds)
        return view
    }()
    
    lazy var viewModel: RegisterViewModel = {
        let vm = RegisterViewModel()
        return vm
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // 标题
        self.navigationItem.title = "用户注册"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: LCZHexadecimalColor(hexadecimal: "#57310C")]
        
        self.view.addSubview(registerView)
        
        
        let account = registerView.accountTextField.rx.text.orEmpty.map{ $0.count >= 6 && $0.count <= 18}.share(replay: 1)
        let password = registerView.passwordTextField.rx.text.orEmpty.map{ $0.count >= 6 && $0.count <= 18}.share(replay: 1)
        let confirmPassword = registerView.confirmPasswordTextField.rx.text.orEmpty.map{ $0.count >= 6 && $0.count <= 18}.share(replay: 1)
        let code = registerView.codeTextField.rx.text.orEmpty.map{ $0.count == 6 }.share(replay: 1)
        let email = registerView.emailTextField.rx.text.orEmpty.map{ $0.count > 0 }.share(replay: 1)
        
        email.bind(to: registerView.codeButton.rx.isEnabled).disposed(by: rx.disposeBag)
        email.subscribe(onNext: { (state) in
            self.registerView.codeButton.backgroundColor = state && self.registerView.codeButton.isEnabled == true ? LCZHexadecimalColor(hexadecimal: "#FECE1D") : LCZRgbColor(239, 240, 244, 1)
        }).disposed(by: rx.disposeBag)
        // 发送验证码事件
        registerView.codeButton.rx.tap.subscribe(onNext: { () in
            self.registerView.codeButton.isEnabled = false
            self.viewModel.sendVerificationCode(to: self.registerView.emailTextField.text!).subscribe(onSuccess: { (model) in
                LCZProgressHUD.showSuccess(title: "获取验证码成功")
                DispatchQueue.main.async(execute: {
                    self.registerView.codeButton.backgroundColor = LCZRgbColor(239, 240, 244, 1)
                    LCZTimingCounter.addVerifyCode("RegistrationVerificationCode")
                })
            }, onError: { (error) in
                DispatchQueue.main.async(execute: {
                    self.registerView.codeButton.isEnabled = true
                })
            }).disposed(by: self.rx.disposeBag)
        }).disposed(by: rx.disposeBag)
        
        // 监听倒计时
        NotificationCenter.default.rx.notification(Notification.Name(rawValue: "RegistrationVerificationCode"))
                                    .takeUntil(self.rx.deallocated) //页面销毁自动移除通知监听
                                    .subscribe(onNext: { (notification) in
                                        if (notification.object! as! Int) == 0 {
                                            DispatchQueue.main.async(execute: {
                                                self.registerView.codeButton.isEnabled = true
                                                self.registerView.codeButton.backgroundColor = LCZHexadecimalColor(hexadecimal: "#FECE1D")
                                                self.registerView.codeButton.setTitle("获取验证码", for: .normal)
                                            })
                                        }else {
                                            DispatchQueue.main.async(execute: {
                                                self.registerView.codeButton.setTitle("\(notification.object!)s", for: .normal)
                                            })
                                        }
                                    }).disposed(by: rx.disposeBag)
        
        
        // 监听账号、密码、确认密码输入框
        let zip = Observable.combineLatest(account, password, confirmPassword, code) { $0 && $1 && $2 && $3 }
        zip.bind(to: self.registerView.registerButton.rx.isEnabled).disposed(by: rx.disposeBag)
        zip.subscribe(onNext: { (state) in
                self.registerView.registerButton.backgroundColor = state == true ? LCZHexadecimalColor(hexadecimal: "#FECE1D") : LCZRgbColor(239, 240, 244, 1)
            }).disposed(by: rx.disposeBag)
        
        // 注册响应
        registerView.registerButton.rx.tap.subscribe(onNext: { () in
            self.registerView.registerButton.isEnabled = false
            self.viewModel.userRegister(username: self.registerView.accountTextField.text!, password: self.registerView.passwordTextField.text!, passwordTwo: self.registerView.confirmPasswordTextField.text!, code: self.registerView.codeTextField.text!, to: self.registerView.emailTextField.text! ).subscribe(onSuccess: { (model) in
                LCZProgressHUD.showSuccess(title: "注册成功！")
                self.registerView.registerButton.isEnabled = true
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5 , execute: {
                    self.navigationController?.popViewController(animated: true)
                })
            }, onError: { (error) in
                DispatchQueue.main.async(execute: {
                    self.registerView.registerButton.isEnabled = true
                })
            }).disposed(by: self.rx.disposeBag)
            
        }).disposed(by: rx.disposeBag)
    }
    

   

}
