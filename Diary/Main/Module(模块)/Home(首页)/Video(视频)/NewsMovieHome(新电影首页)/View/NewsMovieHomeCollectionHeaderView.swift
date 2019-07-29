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
    
    /// 图标
    public var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isSkeletonable = true
        
        // 图标
        imageView = UIImageView()
        self.addSubview(imageView)
        imageView.isSkeletonable = true
        imageView.contentMode = .scaleAspectFill
        imageView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.top.equalToSuperview()
            make.size.equalTo(20)
        }
        
        // 标题
        titleLabel = UILabel()
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(imageView.snp.right).offset(5)
            make.centerY.equalTo(imageView)
        }
        titleLabel.font = LCZBoldFontSize(size: 16)
        titleLabel.textColor = LCZHexadecimalColor(hexadecimal: AppTitleColor)
        //titleLabel.text = "乐淘世界"
        titleLabel.isSkeletonable = true
     
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
