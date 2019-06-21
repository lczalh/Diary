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
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: LCZHexadecimalColor(hexadecimal: "#57310C")]
        
        self.view.addSubview(retrievePasswordView)
        
        let account = retrievePasswordView.accountTextField.rx.text.orEmpty.map { $0.count >= 6 && $0.count <= 18 }.share(replay: 1)
        let password = retrievePasswordView.passwordTextField.rx.text.orEmpty.map { $0.count >= 6 && $0.count <= 18 }.share(replay: 1)
        let confirmPassword = retrievePasswordView.confirmPasswordTextField.rx.text.orEmpty.map { $0.count >= 6 && $0.count <= 18 }.share(replay: 1)
        let code = retrievePasswordView.codeTextField.rx.text.orEmpty.map { $0.count == 4 }.share(replay: 1)
        let encryptedProblem = retrievePasswordView.encryptedProblemTextField.rx.text.orEmpty.map { $0.count > 0 }.share(replay: 1)
        let encryptedAnswers = retrievePasswordView.encryptedAnswersTextField.rx.text.orEmpty.map { $0.count > 0 }.share(replay: 1)
        
        
        // 监听账号、密码、确认密码等输入框
        let zip = Observable.combineLatest(account, password, confirmPassword, code, encryptedProblem, encryptedAnswers) { $0 && $1 && $2 && $3 && $4 && $5}
        zip.bind(to: self.retrievePasswordView.retrievePasswordButton.rx.isEnabled).disposed(by: rx.disposeBag)
        zip.subscribe(onNext: { (state) in
            self.retrievePasswordView.retrievePasswordButton.backgroundColor = state == true ? LCZHexadecimalColor(hexadecimal: "#FECE1D") : LCZRgbColor(239, 240, 244, 1)
        }).disposed(by: rx.disposeBag)
        
        // 找回事件
        self.retrievePasswordView.retrievePasswordButton.rx.tap.subscribe(onNext: { () in
            self.retrievePasswordView.retrievePasswordButton.isEnabled = false
            self.viewModel.retrievePassword(user_name: self.retrievePasswordView.accountTextField.text!,
                                            user_question: self.retrievePasswordView.encryptedProblemTextField.text!,
                                            user_answer: self.retrievePasswordView.encryptedAnswersTextField.text!,
                                            user_pwd: self.retrievePasswordView.passwordTextField.text!,
                                            user_pwd2: self.retrievePasswordView.confirmPasswordTextField.text!,
                                            verify: self.retrievePasswordView.codeTextField.text!).subscribe(onSuccess: { (model) in
                                                DispatchQueue.main.async(execute: {
                                                    self.retrievePasswordView.retrievePasswordButton.isEnabled = true
                                                    LCZProgressHUD.showSuccess(title: "成功找回")
                                                    self.navigationController?.popViewController(animated: true)
                                                })
                                            }, onError: { (error) in
                                                DispatchQueue.main.async(execute: {
                                                    self.retrievePasswordView.retrievePasswordButton.isEnabled = true
                                                    self.retrievePasswordView.getCodeImage()
                                                })
                                            }).disposed(by: self.rx.disposeBag)
        }).disposed(by: rx.disposeBag)
        
//        networkServicesProvider.rx.request(MultiTarget(MovieNetworkServices.retrievePasswordSendVerificationCode(ac: "email", to: "824092805@qq.com"))).mapJSON().subscribe(onSuccess: { (re) in
//            let r = re as! Dictionary<String, Any>
//            LCZPrint(r["msg"])
//        }) { (error) in
//            
//        }
    }
    

    

}
