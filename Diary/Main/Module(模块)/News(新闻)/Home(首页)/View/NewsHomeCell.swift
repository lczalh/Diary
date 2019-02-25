//
//  NewsHomeCell.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/2/25.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class NewsHomeCell: DiaryBaseViewCell {
    
    /// 标题
    var title: UILabel!
    
    /// 类别
    var category: UILabel!
    
    /// 图片
    var imageV: UIImageView!
    
    
    override func config() {
        // 图片
        self.imageV = UIImageView()
        self.contentView.addSubview(self.imageV)
        self.imageV.snp.makeConstraints { (make) in
            make.bottom.right.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(10)
            make.width.equalTo(120);
        }
        self.layoutIfNeeded()
        self.imageV.setContentHuggingPriority(.required, for: .horizontal)
        self.imageV.setContentCompressionResistancePriority(.required, for: .horizontal)
        self.imageV.backgroundColor = UIColor.red
        
        // 标题
        self.title = UILabel()
        self.contentView.addSubview(self.title);
        self.title.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(10)
            make.right.equalTo(self.imageV.snp.left).offset(10)
        }
        self.title.text = "ada  大大大";
    }
    
    override func setNeedsLayout() {
        super.setNeedsLayout()
        let path = UIBezierPath(roundedRect: self.imageV.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 5, height: 5))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.imageV.bounds
        maskLayer.path = path.cgPath
        self.imageV.layer.mask = maskLayer
    }
    

    
    override func layoutSubviews() {
        


    }
    

}
