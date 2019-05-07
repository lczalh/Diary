//
//  NewsHomeCell.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/2/25.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class NewsHomeCell: DiaryBaseTableViewCell {
    
    /// 标题
    var titleLabel: UILabel!
    
    /// 时间
    var timeLabel: UILabel!
    
    /// 图片
    var newsImageView: UIImageView!
    
    /// 来源
    var sourceLabel: UILabel!
    
    override func config() {
        self.selectionStyle = .none
        // 图片
        self.newsImageView = UIImageView()
        self.contentView.addSubview(self.newsImageView)
        self.newsImageView.frame = CGRect(x: LCZWidth - 130, y: 10, width: 120, height: 90)
        // 切圆角
        let path = UIBezierPath(roundedRect: self.newsImageView.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 5, height: 5))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.newsImageView.bounds
        maskLayer.path = path.cgPath
        self.newsImageView.layer.mask = maskLayer
    
        // 标题
        self.titleLabel = UILabel()
        self.contentView.addSubview(self.titleLabel);
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(10)
            make.right.equalTo(self.newsImageView.snp.left).offset(-10)
        }
        self.titleLabel.numberOfLines = 0
        self.titleLabel.font = LCZBoldFontSize(size: 16)
        
        // 时间
        self.timeLabel = UILabel()
        self.contentView.addSubview(self.timeLabel)
        self.timeLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
        }
        self.timeLabel.font = LCZFontSize(size: 12)
        
        // 来源
        self.sourceLabel = UILabel()
        self.contentView.addSubview(self.sourceLabel)
        self.sourceLabel.snp.makeConstraints { (make) in
            make.right.equalTo(self.newsImageView.snp.left).offset(-10)
            make.bottom.equalTo(self.timeLabel)
        }
        self.sourceLabel.font = LCZFontSize(size: 12)
        
    }
    

}
