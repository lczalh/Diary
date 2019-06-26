//
//  NewsMovieCollectionViewCell.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/6/26.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class NewsMovieCollectionViewCell: DiaryBaseCollectionViewCell {
    
    /// 图片
    public var imageView: UIImageView!
    
    /// 标题
    public var titleLabel: UILabel!
    
    override func config() {
        imageView = UIImageView()
        self.contentView.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(120)
        }
        imageView.image = UIImage(named: "2")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        titleLabel = UILabel()
        self.contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-5)
            make.height.equalTo(30)
        }
        titleLabel.textAlignment = .center
        titleLabel.font = LCZFontSize(size: 14)
        titleLabel.text = "大佬开始"
        titleLabel.textColor = LCZHexadecimalColor(hexadecimal: "#FECE1D")
    }
}
