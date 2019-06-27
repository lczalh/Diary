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
    
    /// 轮播图
    public var shufflingFigureView: ShufflingFigureView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isSkeletonable = true
        
        shufflingFigureView = ShufflingFigureView(frame: CGRect(x: 0, y: 0, width: LCZWidth, height: 180))
        self.addSubview(shufflingFigureView)
        shufflingFigureView.isSkeletonable = true
        
        titleLabel = UILabel()
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.top.equalTo(shufflingFigureView.snp.bottom).offset(15)
        }
        titleLabel.font = LCZBoldFontSize(size: 16)
        titleLabel.textColor = LCZHexadecimalColor(hexadecimal: "#57310C")
        titleLabel.isSkeletonable = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
