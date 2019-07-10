//
//  PracticalFunctionCell.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/4/12.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class PracticalFunctionCell: DiaryBaseCollectionViewCell {
    
    var titleLabel: UILabel!
    
    var borderLayer: CAShapeLayer!
    
    override func config() {
        self.contentView.layer.cornerRadius = 5
        self.contentView.clipsToBounds = true
        self.contentView.layer.borderWidth = 1

        titleLabel = UILabel()
        self.contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        titleLabel.textAlignment = .center
        titleLabel.font = LCZFontSize(size: 16)
    }
}
