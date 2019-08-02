//
//  MovieHomeCell.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/3/20.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class MovieHomeCell: DiaryBaseCollectionViewCell {
    
    /// 图片
    var imageView = UIImageView()
    
    /// 标题
    var titleLabel = UILabel()
    
    
    override func config() {
        self.isSkeletonable = true
        self.contentView.layer.cornerRadius = 10
        self.layer.cornerRadius = 10
        self.contentView.clipsToBounds = true
        
        self.contentView.addSubview(self.titleLabel)
        self.titleLabel.font = LCZPublicHelper.shared.getBoldFont(size: 16)
        self.titleLabel.snp.makeConstraints({ (make) in
            make.bottom.equalToSuperview().offset(-10)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        })
        self.titleLabel.textAlignment = .center
        self.titleLabel.font = LCZPublicHelper.shared.getConventionFont(size: 14)
        self.titleLabel.textColor = LCZPublicHelper.shared.getHexadecimalColor(hexadecimal: AppContentColor)
        self.titleLabel.isSkeletonable = true
        self.titleLabel.text = "乐淘视界"
        
        self.contentView.addSubview(self.imageView)
        self.imageView.contentMode = .scaleAspectFill
        self.imageView.clipsToBounds = true
        self.imageView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.bottom.equalTo(self.titleLabel.snp.top).offset(-10)
        }
        self.imageView.isSkeletonable = true
    }
    
  
}
