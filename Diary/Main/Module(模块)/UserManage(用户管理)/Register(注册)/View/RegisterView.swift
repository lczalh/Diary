//
//  RegisterView.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/6/19.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class RegisterView: DiaryBaseView {
    
    /// 确认密码输入框
    public var confirmPasswordTextField: UITextField!
    
    /// 密码输入框
    public var passwordTextField: UITextField!
    
    /// 账号输入框
    public var accountTextField: UITextField!
    
    /// 注册按钮
    public var registerButton: UIButton!
    
    /// 验证码图片
    public var codeButton: UIButton!
    
    /// 验证码输入框
    public var codeTextField: UITextField!
    
    /// 邮箱输入框
    public var emailTextField: UITextField!
    
    override func configUI() {
        
        // 账号
        accountTextField = UITextField()
        self.addSubview(accountTextField)
        accountTextField.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(50)
            make.top.equalToSuperview().offset(50)
            make.right.equalToSuperview().offset(-50)
            make.height.equalTo(40 * LCZSizeScale)
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
            make.height.equalTo(40 * LCZSizeScale)
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
            make.height.equalTo(40 * LCZSizeScale)
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
        
        // 邮箱号输入框
        emailTextField = UITextField()
        self.addSubview(emailTextField)
        emailTextField.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(50)
            make.top.equalTo(confirmPasswordLineView.snp.bottom).offset(20)
            make.right.equalToSuperview().offset(-50)
            make.height.equalTo(40 * LCZSizeScale)
        }
        emailTextField.clearButtonMode = .unlessEditing
        emailTextField.placeholder = "请输入您的邮箱"
        emailTextField.font = LCZFontSize(size: 14)
        emailTextField.keyboardType = .emailAddress
        let emailLineView = UIView()
        self.addSubview(emailLineView)
        emailLineView.snp.makeConstraints { (make) in
            make.left.right.equalTo(emailTextField)
            make.top.equalTo(emailTextField.snp.bottom)
            make.height.equalTo(1)
        }
        emailLineView.backgroundColor = LCZRgbColor(239, 240, 244, 1)
        
        // 验证码
        codeButton = UIButton(type: .custom)
        self.addSubview(codeButton)
        codeButton.snp.makeConstraints { (make) in
            make.top.equalTo(emailLineView).offset(20)
            make.right.equalToSuperview().offset(-50)
            make.height.equalTo(40 * LCZSizeScale)
            make.width.equalTo(100 * LCZSizeScale)
        }
        codeButton.setTitle("获取验证码", for: .normal)
        codeButton.titleLabel?.font = LCZFontSize(size: 14)
        codeButton.backgroundColor = LCZRgbColor(239, 240, 244, 1)
        codeButton.layoutIfNeeded()
        let codeBezierPath = UIBezierPath(roundedRect: codeButton.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 5, height: 5))
        let codeShapeLayer = CAShapeLayer()
        codeShapeLayer.path = codeBezierPath.cgPath
        codeShapeLayer.frame = codeButton.bounds
        codeButton.layer.mask = codeShapeLayer
        
        // 验证码输入框
        codeTextField = UITextField()
        self.addSubview(codeTextField)
        codeTextField.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(50)
            make.top.equalTo(codeButton)
            make.right.equalTo(codeButton.snp.left).offset(-5)
            make.height.equalTo(40 * LCZSizeScale)
        }
        codeTextField.clearButtonMode = .unlessEditing
        codeTextField.placeholder = "请输入邮箱验证码"
        codeTextField.font = LCZFontSize(size: 14)
        codeTextField.keyboardType = .numberPad
        // 验证码分割线
        let codeLineView = UIView()
        self.addSubview(codeLineView)
        codeLineView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(-50)
            make.right.equalTo(codeButton.snp.left)
            make.top.equalTo(codeTextField.snp.bottom)
            make.height.equalTo(1)
        }
        codeLineView.backgroundColor = LCZRgbColor(239, 240, 244, 1)
        
        // 注册
        registerButton = UIButton(type: .custom)
        self.addSubview(registerButton)
        registerButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(codeLineView.snp.bottom).offset(40)
            make.size.equalTo(80 * LCZSizeScale)
        }
        registerButton.setTitle("注册", for: .normal)
        registerButton.setTitleColor(UIColor.white, for: .normal)
        registerButton.backgroundColor = LCZRgbColor(239, 240, 244, 1)
        registerButton.layoutIfNeeded()
        let bezierPath = UIBezierPath(roundedRect: registerButton.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 40 * LCZSizeScale, height: 40 * LCZSizeScale))
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = bezierPath.cgPath
        shapeLayer.frame = registerButton.bounds
        registerButton.layer.mask = shapeLayer
        
    }

}
