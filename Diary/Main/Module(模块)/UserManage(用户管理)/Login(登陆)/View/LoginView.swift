//
//  LoginView.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/6/18.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class LoginView: DiaryBaseView {
    
    /// 账号输入框
    public var accountTextField: UITextField!
    
    /// 密码输入框
    public var passwordTextField: UITextField!
    
    /// 登陆
    public var loginButton: UIButton!
    
    /// 忘记密码
    public var forgotPasswordButton: UIButton!
    
    /// 用户注册
    public var userRegistrationButton: UIButton!
    
    override func configUI() {
        // appIcon图标
        let iconImageView = UIImageView()
        self.addSubview(iconImageView)
        iconImageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview().offset(-50)
            make.top.equalToSuperview().offset(150)
        }
        iconImageView.image = UIImage(named: "logo")
        iconImageView.contentMode = .scaleAspectFill
        
        // 应用名称
        let appNameLabel = UILabel()
        self.addSubview(appNameLabel)
        appNameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(iconImageView.snp.right).offset(5)
            make.centerY.equalTo(iconImageView)
        }
        appNameLabel.text = LCZAppName
        appNameLabel.font = LCZBoldFontSize(size: 20)
        appNameLabel.textColor = LCZHexadecimalColor(hexadecimal: "#FECE1D")
        
        // 账号
        let accountView = UIView()
        self.addSubview(accountView)
        accountView.backgroundColor = LCZRgbColor(239, 240, 244, 1)
        accountView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(50)
            make.right.equalToSuperview().offset(-50)
            make.top.equalTo(iconImageView.snp.bottom).offset(30)
            make.height.equalTo(60)
        }
        accountView.layoutIfNeeded()
        let accountBezierPath = UIBezierPath(roundedRect: accountView.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: accountView.bounds.width / 2, height: accountView.bounds.height / 2))
        let accountShapeLayer = CAShapeLayer()
        accountShapeLayer.frame = accountView.bounds
        accountShapeLayer.path = accountBezierPath.cgPath
        accountView.layer.mask = accountShapeLayer
        
        // 账号图标
        let accountImageView = UIImageView()
        accountView.addSubview(accountImageView)
        accountImageView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
        }
        accountImageView.image = UIImage(named: "zhanghaodenglu")
        accountImageView.setContentHuggingPriority(.required, for: .horizontal)
        accountImageView.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        // 账号输入框
        accountTextField = UITextField()
        accountView.addSubview(accountTextField)
        accountTextField.snp.makeConstraints { (make) in
            make.left.equalTo(accountImageView.snp.right).offset(5)
            make.centerY.equalTo(accountImageView)
            make.right.equalToSuperview().offset(-10)
        }
        accountTextField.clearButtonMode = .unlessEditing
        accountTextField.placeholder = "请输入您的账号"
        accountTextField.font = LCZFontSize(size: 16)
        accountTextField.keyboardType = .numberPad
        
        // 密码
        let passwordView = UIView()
        self.addSubview(passwordView)
        passwordView.backgroundColor = LCZRgbColor(239, 240, 244, 1)
        passwordView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(50)
            make.right.equalToSuperview().offset(-50)
            make.top.equalTo(accountView.snp.bottom).offset(30)
            make.height.equalTo(60)
        }
        passwordView.layoutIfNeeded()
        let passwordBezierPath = UIBezierPath(roundedRect: passwordView.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: passwordView.bounds.width / 2, height: passwordView.bounds.height / 2))
        let passwordShapeLayer = CAShapeLayer()
        passwordShapeLayer.frame = passwordView.bounds
        passwordShapeLayer.path = passwordBezierPath.cgPath
        passwordView.layer.mask = passwordShapeLayer
        
        // 密码图标
        let passwordImageView = UIImageView()
        passwordView.addSubview(passwordImageView)
        passwordImageView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
        }
        passwordImageView.image = UIImage(named: "zhucedenglumima")
        passwordImageView.setContentHuggingPriority(.required, for: .horizontal)
        passwordImageView.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        // 密码输入框
        passwordTextField = UITextField()
        passwordView.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { (make) in
            make.left.equalTo(passwordImageView.snp.right).offset(5)
            make.centerY.equalTo(passwordImageView)
            make.right.equalToSuperview().offset(-10)
        }
        passwordTextField.clearButtonMode = .unlessEditing
        passwordTextField.placeholder = "请输入您的密码"
        passwordTextField.font = LCZFontSize(size: 16)
        passwordTextField.keyboardType = .twitter
        passwordTextField.isSecureTextEntry = true
        
        // 登陆
        loginButton = UIButton(type: .custom)
        self.addSubview(loginButton)
        loginButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(passwordView.snp.bottom).offset(50)
            make.size.equalTo(80)
        }
        loginButton.setImage(UIImage(named: "jiantoudingweixiangyou"), for: .normal)
        loginButton.layoutIfNeeded()
        let loginBezierPath = UIBezierPath(roundedRect: loginButton.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: loginButton.bounds.width / 2, height: loginButton.bounds.height / 2))
        let loginShapeLayer = CAShapeLayer()
        loginShapeLayer.frame = loginButton.bounds
        loginShapeLayer.path = loginBezierPath.cgPath
        loginButton.layer.mask = loginShapeLayer
        loginButton.backgroundColor = LCZRgbColor(239, 240, 244, 1)
        loginButton.isEnabled = false
        
        // 分割线
        let verticalLineView = UIView()
        self.addSubview(verticalLineView)
        verticalLineView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-100)
            make.width.equalTo(2)
            make.height.equalTo(20)
        }
        verticalLineView.backgroundColor = LCZRgbColor(239, 240, 244, 1)
        
        // 忘记密码
        forgotPasswordButton = UIButton(type: .custom)
        self.addSubview(forgotPasswordButton)
        forgotPasswordButton.snp.makeConstraints { (make) in
            make.right.equalTo(verticalLineView.snp.left).offset(-30)
            make.centerY.equalTo(verticalLineView)
        }
        forgotPasswordButton.setTitle("忘记密码", for: .normal)
        forgotPasswordButton.setTitleColor(UIColor.black, for: .normal)
        forgotPasswordButton.titleLabel?.font = LCZFontSize(size: 12)
        
        // 用户注册
        userRegistrationButton = UIButton(type: .custom)
        self.addSubview(userRegistrationButton)
        userRegistrationButton.snp.makeConstraints { (make) in
            make.left.equalTo(verticalLineView.snp.right).offset(30)
            make.centerY.equalTo(verticalLineView)
        }
        userRegistrationButton.setTitle("用户注册", for: .normal)
        userRegistrationButton.setTitleColor(UIColor.black, for: .normal)
        userRegistrationButton.titleLabel?.font = LCZFontSize(size: 12)
    }

}
