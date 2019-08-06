//
//  ExpressQueryResultsView.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/6/13.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit
import MapKit

class ExpressQueryResultsView: DiaryBaseView {
    
    public var tableView: UITableView!
    
    /// 快递公司logo
    public var logoImageView: UIImageView!
    
    /// 快递公司
    public var courierCompanyLeabel: UILabel!
    
    /// 快递单号
    public var courieNumberLabel: UILabel!
    
    /// 耗时
    public var timeConsumingLabel: UILabel!

    override func configUI() {
        createTableView()
    }
    
    private func createTableView() {
        tableView = UITableView(frame: self.bounds, style: .plain)
        self.addSubview(tableView)
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(ExpressQueryResultsTableViewCell.self, forCellReuseIdentifier: "ExpressQueryResultsTableViewCell")
        tableView.backgroundColor = UIColor.clear
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 34, right: 0)
        tableView.separatorStyle = .none
        tableView.tableHeaderView = createTabelHeaderView()
        tableView.showsVerticalScrollIndicator = false
    }
    
    private func createTabelHeaderView() -> UIView {
        let tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: LCZPublicHelper.shared.getScreenWidth!, height: 200))
        
        let backView = UIView()
        tableHeaderView.addSubview(backView)
        backView.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(15)
            make.bottom.equalToSuperview()
            make.right.equalToSuperview().offset(-15)
        }
        backView.backgroundColor = UIColor.white
        backView.layoutIfNeeded()
        // 切圆角
        let bezierPath = UIBezierPath(roundedRect: backView.bounds, byRoundingCorners: [.topLeft,.topRight], cornerRadii: CGSize(width: 5, height: 5))
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = backView.bounds
        shapeLayer.path = bezierPath.cgPath
        backView.layer.mask = shapeLayer
        
        // logo
        logoImageView = UIImageView()
        backView.addSubview(logoImageView)
        logoImageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(15)
            make.size.equalTo(60)
        }
        logoImageView.contentMode = .scaleAspectFill
        logoImageView.layoutIfNeeded()
        let bezierPathTwo = UIBezierPath(roundedRect: logoImageView.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 30, height: 30))
        let shapeLayerTwo = CAShapeLayer()
        shapeLayerTwo.frame = logoImageView.bounds
        shapeLayerTwo.path = bezierPathTwo.cgPath
        logoImageView.layer.mask = shapeLayerTwo
        
        // 快递公司
        courierCompanyLeabel = UILabel()
        backView.addSubview(courierCompanyLeabel)
        courierCompanyLeabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(logoImageView)
            make.top.equalTo(logoImageView.snp.bottom).offset(5)
        }
        courierCompanyLeabel.font = LCZPublicHelper.shared.getBoldFont(size: 18)
        
        // 快递单号
        courieNumberLabel = UILabel()
        backView.addSubview(courieNumberLabel)
        courieNumberLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(courierCompanyLeabel)
            make.top.equalTo(courierCompanyLeabel.snp.bottom).offset(5)
        }
        courieNumberLabel.textColor = LCZPublicHelper.shared.getRgbColor(161, 159, 161, 1)
        courieNumberLabel.font = LCZPublicHelper.shared.getConventionFont(size: 14)
        
        // 虚线
        let dottedLineImageView = UIImageView()
        backView.addSubview(dottedLineImageView)
        dottedLineImageView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(courieNumberLabel.snp.bottom).offset(5)
            make.height.equalTo(5)
        }
        dottedLineImageView.layoutIfNeeded()
        UIGraphicsBeginImageContext(dottedLineImageView.frame.size) // 位图上下文绘制区域
        dottedLineImageView.image?.draw(in: dottedLineImageView.bounds)
        let context:CGContext = UIGraphicsGetCurrentContext()!
        context.setLineCap(CGLineCap.square)
        // 第一个是绘制的宽度，第二个表示跳过的宽度
        let lengths:[CGFloat] = [4,5]
        context.setStrokeColor(LCZPublicHelper.shared.getRgbColor(213, 212, 214, 1).cgColor)
        context.setLineWidth(1)
        context.setLineDash(phase: 0, lengths: lengths)
        context.move(to: CGPoint(x: 5, y: 3))
        context.addLine(to: CGPoint(x: dottedLineImageView.frame.size.width, y: 3))
        context.strokePath()
        dottedLineImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        
        // 耗时
        timeConsumingLabel = UILabel()
        backView.addSubview(timeConsumingLabel)
        timeConsumingLabel.snp.makeConstraints({ (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(dottedLineImageView.snp.bottom).offset(10)
        })
        timeConsumingLabel.text = "耗时2天15小时"
        timeConsumingLabel.textColor = UIColor.black
        timeConsumingLabel.font = LCZPublicHelper.shared.getConventionFont(size: 14)

        return tableHeaderView
        
    }

}
