//
//  NewsMovieHomeCollectionHeaderView.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/6/26.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class NewsMovieHomeCollectionHeaderView: UICollectionReusableView {

    /// 标题
    public var titleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isSkeletonable = true
        titleLabel = UILabel()
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.centerY.equalToSuperview()
        }
        titleLabel.font = LCZBoldFontSize(size: 16)
        titleLabel.textColor = LCZHexadecimalColor(hexadecimal: "#57310C")
        titleLabel.text = "乐淘世界"
        titleLabel.isSkeletonable = true
     
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
