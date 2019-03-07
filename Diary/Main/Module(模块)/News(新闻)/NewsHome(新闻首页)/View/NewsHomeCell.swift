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
    
    /// 时间
    var time: UILabel!
    
    /// 图片
    var imageV: UIImageView!
    
    /// 来源
    var source: UILabel!
    
    override func config() {
        self.selectionStyle = .none
        // 图片
        self.imageV = UIImageView()
        self.contentView.addSubview(self.imageV)
        self.imageV.frame = CGRect(x: LCZWidth - 130, y: 10, width: 120, height: 90)
        // 切圆角
        let path = UIBezierPath(roundedRect: self.imageV.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 5, height: 5))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.imageV.bounds
        maskLayer.path = path.cgPath
        self.imageV.layer.mask = maskLayer
    
        // 标题
        self.title = UILabel()
        self.contentView.addSubview(self.title);
        self.title.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(10)
            make.right.equalTo(self.imageV.snp.left).offset(-10)
        }
        self.title.numberOfLines = 0
        self.title.font = LCZBoldFontSize(size: 18)
        
        // 时间
        self.time = UILabel()
        self.contentView.addSubview(self.time)
        self.time.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
        }
        self.time.font = LCZFontSize(size: 12)
        
        // 来源
        self.source = UILabel()
        self.contentView.addSubview(self.source)
        self.source.snp.makeConstraints { (make) in
            make.right.equalTo(self.imageV.snp.left).offset(-10)
            make.bottom.equalTo(self.time)
        }
        self.source.font = LCZFontSize(size: 12)
        
    }
    

}
