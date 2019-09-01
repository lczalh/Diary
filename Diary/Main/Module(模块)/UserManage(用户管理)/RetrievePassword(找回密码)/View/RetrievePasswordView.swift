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
    
    /// 邮箱输入框
    public var emailTextField: UITextField!
    
    /// 邮箱验证码输入框
    public var emailCodeTextField: UITextField!
    
    //  邮箱获取验证码按钮
    public var emailCodeButton: UIButton!
    
    /// 找回按钮
    public var retrievePasswordButton: UIButton!
    
    /// 验证码图片
    private var codeImageView: UIImageView!
    
    /// 验证码输入框
    public var codeTextField: UITextField!
    
//    /// 密保问题
//    public var encryptedProblemTextField: UITextField!
//
//    /// 密保答案
//    public var encryptedAnswersTextField: UITextField!
    
    override func configUI() {
        
        // 邮箱输入框
        emailTextField = UITextField()
        self.addSubview(emailTextField)
        emailTextField.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(50)
            make.top.equalToSuperview().offset(50)
            make.right.equalToSuperview().offset(-50)
            make.height.equalTo(40 * cz_ScreenSizeScale)
        }
        emailTextField.clearButtonMode = .unlessEditing
        emailTextField.placeholder = "请输入您绑定的邮箱"
        emailTextField.font = cz_ConventionFont(size: 14)
        emailTextField.keyboardType = .emailAddress
        let emailLineView = UIView()
        self.addSubview(emailLineView)
        emailLineView.snp.makeConstraints { (make) in
            make.left.right.equalTo(emailTextField)
            make.top.equalTo(emailTextField.snp.bottom)
            make.height.equalTo(1)
        }
        emailLineView.backgroundColor = cz_RgbColor(239, 240, 244, 1)
        
        //  邮箱获取验证码按钮
        emailCodeButton = UIButton(type: .custom)
        self.addSubview(emailCodeButton)
        emailCodeButton.snp.makeConstraints { (make) in
            make.top.equalTo(emailLineView.snp.bottom).offset(20)
            make.right.equalToSuperview().offset(-50)
            make.height.equalTo(40 * cz_ScreenSizeScale)
            make.width.equalTo(100 * cz_ScreenSizeScale)
        }
        emailCodeButton.setTitle("获取验证码", for: .normal)
        emailCodeButton.titleLabel?.font = cz_ConventionFont(size: 14)
        emailCodeButton.backgroundColor = cz_RgbColor(239, 240, 244, 1)
        emailCodeButton.layoutIfNeeded()
        let emailCodeBezierPath = UIBezierPath(roundedRect: emailCodeButton.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 5, height: 5))
        let emailCodeShapeLayer = CAShapeLayer()
        emailCodeShapeLayer.path = emailCodeBezierPath.cgPath
        emailCodeShapeLayer.frame = emailCodeButton.bounds
        emailCodeButton.layer.mask = emailCodeShapeLayer
        
        // 邮箱验证码输入框
        emailCodeTextField = UITextField()
        self.addSubview(emailCodeTextField)
        emailCodeTextField.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(50)
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.right.equalTo(emailCodeButton.snp.left).offset(-5)
            make.height.equalTo(40 * cz_ScreenSizeScale)
        }
        emailCodeTextField.clearButtonMode = .unlessEditing
        emailCodeTextField.placeholder = "请输入邮箱验证码"
        emailCodeTextField.font = cz_ConventionFont(size: 14)
        emailCodeTextField.keyboardType = .numberPad
        let emailCodeLineView = UIView()
        self.addSubview(emailCodeLineView)
        emailCodeLineView.snp.makeConstraints { (make) in
            make.left.right.equalTo(emailCodeTextField)
            make.top.equalTo(emailCodeTextField.snp.bottom)
            make.height.equalTo(1)
        }
        emailCodeLineView.backgroundColor = cz_RgbColor(239, 240, 244, 1)
        
        // 密码
        passwordTextField = UITextField()
        self.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(50)
            make.top.equalTo(emailCodeLineView.snp.bottom).offset(20)
            make.right.equalToSuperview().offset(-50)
            make.height.equalTo(40 * cz_ScreenSizeScale)
        }
        passwordTextField.clearButtonMode = .unlessEditing
        passwordTextField.placeholder = "请输入您的密码（6~18位）"
        passwordTextField.font = cz_ConventionFont(size: 14)
        passwordTextField.keyboardType = .asciiCapable
        passwordTextField.isSecureTextEntry = true
        let passwordLineView = UIView()
        self.addSubview(passwordLineView)
        passwordLineView.snp.makeConstraints { (make) in
            make.left.right.equalTo(passwordTextField)
            make.top.equalTo(passwordTextField.snp.bottom)
            make.height.equalTo(1)
        }
        passwordLineView.backgroundColor = cz_RgbColor(239, 240, 244, 1)
        
        // 确认密码
        confirmPasswordTextField = UITextField()
        self.addSubview(confirmPasswordTextField)
        confirmPasswordTextField.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(50)
            make.top.equalTo(passwordLineView.snp.bottom).offset(20)
            make.right.equalToSuperview().offset(-50)
            make.height.equalTo(40 * cz_ScreenSizeScale)
        }
        confirmPasswordTextField.clearButtonMode = .unlessEditing
        confirmPasswordTextField.placeholder = "请确认您的密码（6~18位）"
        confirmPasswordTextField.font = cz_ConventionFont(size: 14)
        confirmPasswordTextField.keyboardType = .asciiCapable
        confirmPasswordTextField.isSecureTextEntry = true
        let confirmPasswordLineView = UIView()
        self.addSubview(confirmPasswordLineView)
        confirmPasswordLineView.snp.makeConstraints { (make) in
            make.left.right.equalTo(confirmPasswordTextField)
            make.top.equalTo(confirmPasswordTextField.snp.bottom)
            make.height.equalTo(1)
        }
        confirmPasswordLineView.backgroundColor = cz_RgbColor(239, 240, 244, 1)
        
        // 验证码
        codeImageView = UIImageView()
        self.addSubview(codeImageView)
        codeImageView.snp.makeConstraints { (make) in
            make.top.equalTo(confirmPasswordLineView).offset(20)
            make.right.equalToSuperview().offset(-50)
            make.height.equalTo(40 * cz_ScreenSizeScale)
            make.width.equalTo(100 * cz_ScreenSizeScale)
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
            make.height.equalTo(40 * cz_ScreenSizeScale)
        }
        codeTextField.clearButtonMode = .unlessEditing
        codeTextField.placeholder = "请输入验证码"
        codeTextField.font = cz_ConventionFont(size: 14)
        codeTextField.keyboardType = .numberPad
        // 验证码分割线
        let codeLineView = UIView()
        self.addSubview(codeLineView)
        codeLineView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().offset(-50)
            make.top.equalTo(codeTextField.snp.bottom)
            make.height.equalTo(1)
        }
        codeLineView.backgroundColor = cz_RgbColor(239, 240, 244, 1)
        
        // 注册
        retrievePasswordButton = UIButton(type: .custom)
        self.addSubview(retrievePasswordButton)
        retrievePasswordButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(codeLineView.snp.bottom).offset(40)
            make.size.equalTo(80 * cz_ScreenSizeScale)
        }
        retrievePasswordButton.setTitle("找回", for: .normal)
        retrievePasswordButton.setTitleColor(UIColor.white, for: .normal)
        retrievePasswordButton.backgroundColor = cz_RgbColor(239, 240, 244, 1)
        retrievePasswordButton.layoutIfNeeded()
        let bezierPath = UIBezierPath(roundedRect: retrievePasswordButton.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 40 * cz_ScreenSizeScale, height: 40 * cz_ScreenSizeScale))
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = bezierPath.cgPath
        shapeLayer.frame = retrievePasswordButton.bounds
        retrievePasswordButton.layer.mask = shapeLayer
        
    }
    
    @objc public func getCodeImage() {
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
