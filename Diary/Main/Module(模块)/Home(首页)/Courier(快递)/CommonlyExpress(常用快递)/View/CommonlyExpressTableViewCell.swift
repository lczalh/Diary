//
//  CommonlyExpressTableViewCell.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/6/13.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class CommonlyExpressTableViewCell: DiaryBaseTableViewCell {
    
    /// 快递公司logo
    public var logoImageView: UIImageView!
    
    /// 快递公司名称
    public var titleLabel: UILabel!
    
    /// 电话号码
    public var phoneNumber: UILabel!
    
    public var rightImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func config() {
        
        // 快递公司logo
        logoImageView = UIImageView()
        self.contentView.addSubview(logoImageView)
        logoImageView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.centerY.equalToSuperview()
            make.size.equalTo(40)
        }
        logoImageView.contentMode = .scaleAspectFill
        logoImageView.layoutIfNeeded()
        let bezierPath = UIBezierPath(roundedRect: logoImageView.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 20, height: 20))
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = logoImageView.bounds
        shapeLayer.path = bezierPath.cgPath
        logoImageView.layer.mask = shapeLayer
        
        
        // 快递公司名称
        titleLabel = UILabel()
        self.contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(logoImageView.snp.right).offset(5)
            make.top.equalTo(logoImageView.snp.top)
        }
        titleLabel.font = LCZBoldFontSize(size: 16)
        titleLabel.textColor = LCZHexadecimalColor(hexadecimal: AppContentColor)
        
        // 快递公司号码
        phoneNumber = UILabel()
        self.contentView.addSubview(phoneNumber)
        phoneNumber.font = LCZFontSize(size: 14)
        phoneNumber.snp.makeConstraints { (make) in
            make.left.equalTo(logoImageView.snp.right).offset(5)
            make.right.equalToSuperview().offset(-15)
            make.bottom.equalTo(logoImageView.snp.bottom)
        }
        phoneNumber.textColor = LCZRgbColor(175, 173, 175, 1)
        
        // 右图标
        rightImageView = UIImageView()
        self.contentView.addSubview(rightImageView)
        rightImageView.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-15)
            make.centerY.equalToSuperview()
        }
        rightImageView.image = UIImage(named: "dianhua")
        rightImageView.contentMode = .scaleAspectFit
    }
}
