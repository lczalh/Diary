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
        
        // 监听账号、密码、确认密码输入框
        Observable.combineLatest(registerView.accountTextField.rx.text, registerView.passwordTextField.rx.text, registerView.confirmPasswordTextField.rx.text, registerView.codeTextField.rx.text) {$0!.count > 0 && $1!.count > 0 && $2!.count > 0 && $3!.count > 0}
            .subscribe(onNext: { (state) in
                self.registerView.registerButton.backgroundColor = state == true ? LCZHexadecimalColor(hexadecimal: "#FECE1D") : LCZRgbColor(239, 240, 244, 1)
                self.registerView.registerButton.isEnabled = state
            }).disposed(by: rx.disposeBag)
        
        // 注册响应
        registerView.registerButton.rx.tap.subscribe(onNext: { () in
            if self.registerView.accountTextField.text!.count < 6 || self.registerView.accountTextField.text!.count > 18 {
                LCZProgressHUD.showError(title: "您的账号不符合要求，请重新输入！")
                return
            }
            
            if self.registerView.passwordTextField.text!.count < 6 || self.registerView.passwordTextField.text!.count > 18 {
                LCZProgressHUD.showError(title: "您的密码不符合要求，请重新输入！")
                return
            }
            
            if self.registerView.confirmPasswordTextField.text! !=  self.registerView.passwordTextField.text! {
                LCZProgressHUD.showError(title: "您两次输入的密码不相符，请重新输入！")
                return
            }
            
            if self.registerView.codeTextField.text!.count <= 0 {
                LCZProgressHUD.showError(title: "请输入验证码！")
                return
            }
            
            self.registerView.registerButton.isEnabled = false
            self.viewModel.userRegister(username: self.registerView.accountTextField.text!, password: self.registerView.passwordTextField.text!, passwordTwo: self.registerView.confirmPasswordTextField.text!).subscribe(onSuccess: { (model) in
                LCZProgressHUD.showSuccess(title: "注册成功！")
                self.registerView.registerButton.isEnabled = true
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5 , execute: {
                    self.navigationController?.popViewController(animated: true)
                })
            }, onError: { (error) in
                self.registerView.registerButton.isEnabled = true
            }).disposed(by: self.rx.disposeBag)
            
        }).disposed(by: rx.disposeBag)
    }
    

   

}
