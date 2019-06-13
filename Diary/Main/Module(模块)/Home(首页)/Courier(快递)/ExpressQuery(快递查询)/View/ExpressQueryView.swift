//
//  LogisticsView.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/6/12.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class ExpressQueryView: DiaryBaseView {
    
    /// 查询按钮
    public var inquireButton: UIButton!
    
    private var boxView: UIView!
    
    /// 扫码按钮
    public var sancButton: UIButton!
    
    /// 编码输入框
    public var textField: UITextField!

    override func configUI() {
        createExpressNumberBox()
        createSelectButton()
    }
    
    /// 创建单号框
    private func createExpressNumberBox() {
        boxView = UIView()
        self.addSubview(boxView)
        boxView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(30)
            make.top.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.height.equalTo(40)
        }
        boxView.layer.borderColor = LCZHexadecimalColor(hexadecimal: "#57310C").cgColor;
        boxView.layer.borderWidth = 1
        boxView.layer.cornerRadius = 5
        boxView.clipsToBounds = true
        
        // 左图标
        let leftImageView = UIImageView()
        boxView.addSubview(leftImageView)
        leftImageView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(5)
            make.centerY.equalToSuperview()
        }
        leftImageView.image = UIImage(named: "sousuo")
        leftImageView.setContentHuggingPriority(.required, for: .horizontal)
        leftImageView.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        // 扫码
        sancButton = UIButton(type: .custom)
        boxView.addSubview(sancButton)
        sancButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-5)
            make.centerY.equalToSuperview()
        }
        sancButton.setImage(UIImage(named: "tiaoxingma101"), for: .normal)
        sancButton.setContentHuggingPriority(.required, for: .horizontal)
        sancButton.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        // 输入框
        textField = UITextField()
        boxView.addSubview(textField)
        textField.placeholder = "请输入您的快递单号"
        textField.snp.makeConstraints { (make) in
            make.left.equalTo(leftImageView.snp.right).offset(5)
            make.centerY.equalToSuperview()
            make.right.equalTo(sancButton.snp.left).offset(-5)
            make.height.equalTo(40)
        }
        textField.keyboardType = .asciiCapableNumberPad
    }
    
    /// 创建查询按钮
    private func createSelectButton() {
        inquireButton = UIButton(type: .custom)
        self.addSubview(inquireButton)
        inquireButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(boxView.snp.bottom).offset(30)
            make.width.equalTo(150)
            make.height.equalTo(50)
        }
        inquireButton.layer.cornerRadius = 25
        inquireButton.clipsToBounds = true
        inquireButton.setTitle("查询", for: .normal)
    }

}
