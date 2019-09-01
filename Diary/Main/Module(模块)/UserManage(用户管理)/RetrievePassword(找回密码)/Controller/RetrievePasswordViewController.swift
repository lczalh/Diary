//
//  RetrievePasswordViewController.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/6/20.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class RetrievePasswordViewController: DiaryBaseViewController {
    
    lazy var retrievePasswordView: RetrievePasswordView = {
        let view = RetrievePasswordView(frame: self.view.frame)
        return view
    }()
    
    lazy var viewModel: RetrievePasswordViewModel = {
        let vm = RetrievePasswordViewModel()
        return vm
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // 标题
        self.navigationItem.title = "找回密码"
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: cz_HexadecimalColor(hexadecimal: AppTitleColor)]
        
        self.view.addSubview(retrievePasswordView)
        
        // 邮箱输入框
        let email = retrievePasswordView.emailTextField.rx.text.orEmpty.map { $0.count > 0 }.share(replay: 1)
        // 密码输入框
        let password = retrievePasswordView.passwordTextField.rx.text.orEmpty.map { $0.count >= 6 && $0.count <= 18 }.share(replay: 1)
        // 确认密码输入框
        let confirmPassword = retrievePasswordView.confirmPasswordTextField.rx.text.orEmpty.map { $0.count >= 6 && $0.count <= 18 }.share(replay: 1)
        // 验证码输入框
        let code = retrievePasswordView.codeTextField.rx.text.orEmpty.map { $0.count == 4 }.share(replay: 1)
        // 邮箱验证码输入框
        let emailCode = retrievePasswordView.emailCodeTextField.rx.text.orEmpty.map{ $0.count == 6 }.share(replay: 1)
        
        email.subscribe(onNext: { (state) in
            self.retrievePasswordView.emailCodeButton.backgroundColor = state && self.retrievePasswordView.emailCodeButton.isEnabled  == true  ? cz_HexadecimalColor(hexadecimal: AppContentColor) : cz_RgbColor(239, 240, 244, 1)
        }).disposed(by: rx.disposeBag)
        email.bind(to: retrievePasswordView.emailCodeTextField.rx.isEnabled).disposed(by: rx.disposeBag)
        
        // 获取邮箱验证码
        self.retrievePasswordView.emailCodeButton.rx.tap.subscribe(onNext: { () in
            self.retrievePasswordView.emailCodeButton.isEnabled = false
            self.viewModel.geteMailCode(to: self.retrievePasswordView.emailTextField.text!).subscribe(onSuccess: { (model) in
                LCZProgressHUD.showSuccess(title: "获取验证码成功")
                DispatchQueue.main.async(execute: {
                    self.retrievePasswordView.emailCodeButton.backgroundColor = cz_RgbColor(239, 240, 244, 1)
                    LCZTimingCounter.addVerifyCode("RetrievePasswordVerificationCode")
                })
            }, onError: { (error) in
                DispatchQueue.main.async(execute: {
                    self.retrievePasswordView.emailCodeButton.isEnabled = true
                })
            }).disposed(by: self.rx.disposeBag)
        }).disposed(by: rx.disposeBag)
        
        // 监听倒计时
        NotificationCenter.default.rx.notification(Notification.Name(rawValue: "RetrievePasswordVerificationCode"))
            .takeUntil(self.rx.deallocated) //页面销毁自动移除通知监听
            .subscribe(onNext: { (notification) in
                if (notification.object! as! Int) == 0 {
                    DispatchQueue.main.async(execute: {
                        self.retrievePasswordView.emailCodeButton.isEnabled = true
                        self.retrievePasswordView.emailCodeButton.backgroundColor = cz_HexadecimalColor(hexadecimal: AppContentColor)
                        self.retrievePasswordView.emailCodeButton.setTitle("获取验证码", for: .normal)
                    })
                }else {
                    DispatchQueue.main.async(execute: {
                        self.retrievePasswordView.emailCodeButton.setTitle("\(notification.object!)s", for: .normal)
                    })
                }
            }).disposed(by: rx.disposeBag)
        
        // 监听账号、密码、确认密码等输入框
        let zip = Observable.combineLatest(email, password, confirmPassword, code, emailCode) { $0 && $1 && $2 && $3 && $4 }
        zip.bind(to: self.retrievePasswordView.retrievePasswordButton.rx.isEnabled).disposed(by: rx.disposeBag)
        zip.subscribe(onNext: { (state) in
            self.retrievePasswordView.retrievePasswordButton.backgroundColor = state == true ? cz_HexadecimalColor(hexadecimal: AppContentColor) : cz_RgbColor(239, 240, 244, 1)
        }).disposed(by: rx.disposeBag)
        
        // 找回事件
        self.retrievePasswordView.retrievePasswordButton.rx.tap.subscribe(onNext: { () in
            self.retrievePasswordView.retrievePasswordButton.isEnabled = false
            
            self.viewModel.retrievePassword(to: self.retrievePasswordView.emailTextField.text!,
                                            user_pwd: self.retrievePasswordView.passwordTextField.text!,
                                            user_pwd2: self.retrievePasswordView.confirmPasswordTextField.text!,
                                            verify: self.retrievePasswordView.codeTextField.text!,
                                            code: self.retrievePasswordView.emailCodeTextField.text!).subscribe(onSuccess: { (model) in
                                                DispatchQueue.main.async(execute: {
                                                    self.retrievePasswordView.retrievePasswordButton.isEnabled = true
                                                    LCZProgressHUD.showSuccess(title: "成功找回")
                                                    self.navigationController?.popViewController(animated: true)
                                                })
                                            }, onError: { (error) in
                                                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: {
                                                    self.retrievePasswordView.retrievePasswordButton.isEnabled = true
                                                    self.retrievePasswordView.getCodeImage()
                                                })
                                            }).disposed(by: self.rx.disposeBag)
            }).disposed(by: rx.disposeBag)
            
    }
    

    

}
