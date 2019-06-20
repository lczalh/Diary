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
            LCZPrint("1313414")
        }).disposed(by: rx.disposeBag)
    }
    

    

}
