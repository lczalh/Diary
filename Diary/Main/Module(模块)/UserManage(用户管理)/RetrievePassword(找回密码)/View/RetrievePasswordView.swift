//
//  RetrievePasswordView.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/6/20.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class RetrievePasswordView: DiaryBaseView {

    /// 确认密码输入框
    public var confirmPasswordTextField: UITextField!
    
    /// 密码输入框
    public var passwordTextField: UITextField!
    
    /// 账号输入框
    public var accountTextField: UITextField!
    
    /// 找回按钮
    public var retrievePasswordButton: UIButton!
    
    /// 验证码图片
    private var codeImageView: UIImageView!
    
    /// 验证码输入框
    public var codeTextField: UITextField!
    
    /// 密保问题
    public var encryptedProblemTextField: UITextField!
    
    /// 密保答案
    public var encryptedAnswersTextField: UITextField!
    
    override func configUI() {
        
        // 账号
        accountTextField = UITextField()
        self.addSubview(accountTextField)
        accountTextField.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(50)
            make.top.equalToSuperview().offset(50)
            make.right.equalToSuperview().offset(-50)
            make.height.equalTo(40)
        }
        accountTextField.clearButtonMode = .unlessEditing
        accountTextField.placeholder = "请输入您的账号（6~18位）"
        accountTextField.font = LCZFontSize(size: 14)
        accountTextField.keyboardType = .numberPad
        let accountLineView = UIView()
        self.addSubview(accountLineView)
        accountLineView.snp.makeConstraints { (make) in
            make.left.right.equalTo(accountTextField)
            make.top.equalTo(accountTextField.snp.bottom)
            make.height.equalTo(1)
        }
        accountLineView.backgroundColor = LCZRgbColor(239, 240, 244, 1)
        
        // 密码
        passwordTextField = UITextField()
        self.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(50)
            make.top.equalTo(accountLineView.snp.bottom).offset(20)
            make.right.equalToSuperview().offset(-50)
            make.height.equalTo(40)
        }
        passwordTextField.clearButtonMode = .unlessEditing
        passwordTextField.placeholder = "请输入您的密码（6~18位）"
        passwordTextField.font = LCZFontSize(size: 14)
        passwordTextField.keyboardType = .asciiCapable
        passwordTextField.isSecureTextEntry = true
        let passwordLineView = UIView()
        self.addSubview(passwordLineView)
        passwordLineView.snp.makeConstraints { (make) in
            make.left.right.equalTo(passwordTextField)
            make.top.equalTo(passwordTextField.snp.bottom)
            make.height.equalTo(1)
        }
        passwordLineView.backgroundColor = LCZRgbColor(239, 240, 244, 1)
        
        // 确认密码
        confirmPasswordTextField = UITextField()
        self.addSubview(confirmPasswordTextField)
        confirmPasswordTextField.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(50)
            make.top.equalTo(passwordLineView.snp.bottom).offset(20)
            make.right.equalToSuperview().offset(-50)
            make.height.equalTo(40)
        }
        confirmPasswordTextField.clearButtonMode = .unlessEditing
        confirmPasswordTextField.placeholder = "请确认您的密码（6~18位）"
        confirmPasswordTextField.font = LCZFontSize(size: 14)
        confirmPasswordTextField.keyboardType = .asciiCapable
        confirmPasswordTextField.isSecureTextEntry = true
        let confirmPasswordLineView = UIView()
        self.addSubview(confirmPasswordLineView)
        confirmPasswordLineView.snp.makeConstraints { (make) in
            make.left.right.equalTo(confirmPasswordTextField)
            make.top.equalTo(confirmPasswordTextField.snp.bottom)
            make.height.equalTo(1)
        }
        confirmPasswordLineView.backgroundColor = LCZRgbColor(239, 240, 244, 1)
        
        // 密保问题
        encryptedProblemTextField = UITextField()
        self.addSubview(encryptedProblemTextField)
        encryptedProblemTextField.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(50)
            make.top.equalTo(confirmPasswordLineView.snp.bottom).offset(20)
            make.right.equalToSuperview().offset(-50)
            make.height.equalTo(40)
        }
        encryptedProblemTextField.clearButtonMode = .unlessEditing
        encryptedProblemTextField.placeholder = "请输入您的密保问题"
        encryptedProblemTextField.font = LCZFontSize(size: 14)
        encryptedProblemTextField.keyboardType = .numberPad
        let encryptedProblemLineView = UIView()
        self.addSubview(encryptedProblemLineView)
        encryptedProblemLineView.snp.makeConstraints { (make) in
            make.left.right.equalTo(encryptedProblemTextField)
            make.top.equalTo(encryptedProblemTextField.snp.bottom)
            make.height.equalTo(1)
        }
        encryptedProblemLineView.backgroundColor = LCZRgbColor(239, 240, 244, 1)
        
        // 密保答案
        encryptedAnswersTextField = UITextField()
        self.addSubview(encryptedAnswersTextField)
        encryptedAnswersTextField.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(50)
            make.top.equalTo(encryptedProblemLineView.snp.bottom).offset(20)
            make.right.equalToSuperview().offset(-50)
            make.height.equalTo(40)
        }
        encryptedAnswersTextField.clearButtonMode = .unlessEditing
        encryptedAnswersTextField.placeholder = "请输入您的密码答案"
        encryptedAnswersTextField.font = LCZFontSize(size: 14)
        encryptedAnswersTextField.keyboardType = .asciiCapable
        encryptedAnswersTextField.isSecureTextEntry = true
        let encryptedAnswersLineView = UIView()
        self.addSubview(encryptedAnswersLineView)
        encryptedAnswersLineView.snp.makeConstraints { (make) in
            make.left.right.equalTo(encryptedAnswersTextField)
            make.top.equalTo(encryptedAnswersTextField.snp.bottom)
            make.height.equalTo(1)
        }
        encryptedAnswersLineView.backgroundColor = LCZRgbColor(239, 240, 244, 1)
        
        // 验证码
        codeImageView = UIImageView()
        self.addSubview(codeImageView)
        codeImageView.snp.makeConstraints { (make) in
            make.top.equalTo(encryptedAnswersLineView).offset(20)
            make.right.equalToSuperview().offset(-50)
            make.height.equalTo(40)
            make.width.equalTo(100)
        }
        codeImageView.isUserInteractionEnabled = true
        getCodeImage()
        let tapCodeImageView = UITapGestureRecognizer(target: self, action: #selector(getCodeImage))
        codeImageView.addGestureRecognizer(tapCodeImageView)
        // 验证码输入框
        codeTextField = UITextField()
        self.addSubview(codeTextField)
        codeTextField.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(50)
            make.top.equalTo(codeImageView)
            make.right.equalTo(codeImageView.snp.left).offset(-5)
            make.height.equalTo(40)
        }
        codeTextField.clearButtonMode = .unlessEditing
        codeTextField.placeholder = "请输入验证码"
        codeTextField.font = LCZFontSize(size: 14)
        codeTextField.keyboardType = .numberPad
        // 验证码分割线
        let codeLineView = UIView()
        self.addSubview(codeLineView)
        codeLineView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().offset(-50)
            make.top.equalTo(codeTextField.snp.bottom)
            make.height.equalTo(1)
        }
        codeLineView.backgroundColor = LCZRgbColor(239, 240, 244, 1)
        
        // 注册
        retrievePasswordButton = UIButton(type: .custom)
        self.addSubview(retrievePasswordButton)
        retrievePasswordButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(codeLineView.snp.bottom).offset(40)
            make.size.equalTo(80)
        }
        retrievePasswordButton.setTitle("找回", for: .normal)
        retrievePasswordButton.setTitleColor(UIColor.white, for: .normal)
        retrievePasswordButton.backgroundColor = LCZRgbColor(239, 240, 244, 1)
        retrievePasswordButton.layoutIfNeeded()
        let bezierPath = UIBezierPath(roundedRect: retrievePasswordButton.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 40, height: 40))
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = bezierPath.cgPath
        shapeLayer.frame = retrievePasswordButton.bounds
        retrievePasswordButton.layer.mask = shapeLayer
        
    }
    
    @objc private func getCodeImage() {
        LCZProgressHUD.show()
        DispatchQueue.global().async {
            let image = UIImage(data: try! Data(contentsOf: URL(string: "https://www.letaoshijie.com/index.php/verify/index.html?v=1560934558?v=1560934558")!))
            DispatchQueue.main.async(execute: {
                LCZProgressHUD.dismiss()
                self.codeImageView.image = image
            })
        }
    }


}
