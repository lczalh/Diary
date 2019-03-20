//
//  MovieHomeCell.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/3/20.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class MovieHomeCell: DiaryBaseCollectionViewCell {
    
    /// logo图标
    var logoImageView = UIImageView()
    
    /// 标题
    var titleLabel = UILabel()
    
    
    override func config() {
       // self.backgroundColor = UIColor.white
        self.contentView.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints({ (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10)
        })
        
        
    }
}
