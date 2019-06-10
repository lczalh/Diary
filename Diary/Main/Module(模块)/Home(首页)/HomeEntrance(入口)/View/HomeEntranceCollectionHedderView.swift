//
//  HomeEntranceCollectionHedderView.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/6/10.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class HomeEntranceCollectionHedderView: UICollectionReusableView {
    
    public var titleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.titleLabel = UILabel()
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview()
        }
        self.titleLabel.font = LCZBoldFontSize(size: 16)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
