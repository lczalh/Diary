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
    
    /// 历史查询记录
    public var tableView: UITableView!

    override func configUI() {
        createExpressNumberBox()
        createSelectButton()
        createHistoryQuery()
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
        boxView.layer.borderColor = LCZHexadecimalColor(hexadecimal: AppTitleColor).cgColor;
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
            make.height.equalTo(40)
        }
        inquireButton.setTitle("查询", for: .normal)
        inquireButton.layoutIfNeeded()
        let bezierPath = UIBezierPath(roundedRect: inquireButton.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 20, height: 20))
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = bezierPath.cgPath
        shapeLayer.frame = inquireButton.bounds
        inquireButton.layer.mask = shapeLayer
        
    }
    
    // 历史查询记录
    private func createHistoryQuery() {
        tableView = UITableView(frame: CGRect.zero, style: .plain)
        self.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.top.equalTo(inquireButton.snp.bottom).offset(50)
            make.bottom.equalToSuperview()
        }
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: LCZStatusBarHeight + LCZTabbarHeight + LCZNaviBarHeight + LCZSafeAreaBottomHeight + 30, right: 0)
        tableView.rowHeight = 40
        tableView.register(HistoryQueryTableViewCell.self, forCellReuseIdentifier: "HistoryQueryTableViewCell")
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
    }

}
