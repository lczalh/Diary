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
    
    /// 分割线
    var lineView: UIView!
    
    override func config() {
        self.selectionStyle = .none
        self.isSkeletonable = true
        // 图片
        self.newsImageView = UIImageView()
        self.contentView.addSubview(self.newsImageView)
        self.newsImageView.frame = CGRect(x: cz_ScreenWidth! - 125, y: 10, width: 120, height: 90 * cz_ScreenSizeScale)
        // 切圆角
        let path = UIBezierPath(roundedRect: self.newsImageView.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 5, height: 5))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.newsImageView.bounds
        maskLayer.path = path.cgPath
        self.newsImageView.layer.mask = maskLayer
        self.newsImageView.isSkeletonable = true
    
        // 标题
        self.titleLabel = UILabel()
        self.contentView.addSubview(self.titleLabel);
        self.titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(15)
            make.right.equalTo(self.newsImageView.snp.left).offset(-10)
        }
        self.titleLabel.numberOfLines = 0
        self.titleLabel.font = cz_BoldFont(size: 16)
        self.titleLabel.isSkeletonable = true
        self.titleLabel.text = "letao"
        
        // 时间
        self.timeLabel = UILabel()
        self.contentView.addSubview(self.timeLabel)
        self.timeLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.bottom.equalTo(self.newsImageView.snp.bottom)
        }
        self.timeLabel.font = cz_ConventionFont(size: 12)
        self.timeLabel.isSkeletonable = true
        self.timeLabel.text = "2020"
        
        // 来源
        self.sourceLabel = UILabel()
        self.contentView.addSubview(self.sourceLabel)
        self.sourceLabel.snp.makeConstraints { (make) in
            make.right.equalTo(self.newsImageView.snp.left).offset(-10)
            make.centerY.equalTo(self.timeLabel)
            make.width.equalTo(60)
            make.height.equalTo(25)
        }
        self.sourceLabel.font = cz_ConventionFont(size: 12)
        self.sourceLabel.isSkeletonable = true
        self.sourceLabel.textAlignment = .right
        
        // 分割线
        self.lineView = UIView()
        self.contentView.addSubview(self.lineView)
        self.lineView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
        self.lineView.backgroundColor = cz_RgbColor(238, 238, 238, 1)
        self.lineView.isSkeletonable = true
    }
    

}
