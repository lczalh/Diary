//
//  NewsMovieHomeShufflingFigureCollectionHeaderView.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/6/26.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class NewsMovieHomeShufflingFigureCollectionHeaderView: UICollectionReusableView {
    
    /// 标题
    public var titleLabel: UILabel!
    
    /// 图标
    public var imageView: UIImageView!
    
    /// 轮播图
    public var shufflingFigureView: ShufflingFigureView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isSkeletonable = true
        
        shufflingFigureView = ShufflingFigureView(frame: CGRect(x: 0, y: 0, width: LCZWidth, height: 180 * LCZSizeScale))
        self.addSubview(shufflingFigureView)
        shufflingFigureView.isSkeletonable = true
        
        // 图标
        imageView = UIImageView()
        self.addSubview(imageView)
        imageView.isSkeletonable = true
        imageView.contentMode = .scaleAspectFill
        imageView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.top.equalTo(shufflingFigureView.snp.bottom).offset(10)
            make.size.equalTo(20 * LCZSizeScale)
        }
        
        titleLabel = UILabel()
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(imageView.snp.right).offset(5)
            make.width.equalTo(150)
            make.height.equalTo(30)
            make.centerY.equalTo(imageView)
        }
        titleLabel.font = LCZBoldFontSize(size: 16)
        titleLabel.textColor = LCZHexadecimalColor(hexadecimal: "#57310C")
        titleLabel.isSkeletonable = true

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
