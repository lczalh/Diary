//
//  HomeEntranceCollectionHedderView.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/6/10.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class HomeEntranceCollectionHedderView: UICollectionReusableView {
    
    public var logoImageView: UIImageView!
    
    public var titleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        self.logoImageView = UIImageView()
        self.addSubview(self.logoImageView)
        self.logoImageView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(15)
        }
        self.logoImageView.contentMode = .scaleAspectFit
        
        self.titleLabel = UILabel()
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.logoImageView)
            make.left.equalTo(self.logoImageView.snp.right).offset(5)
        }
        self.titleLabel.font = LCZPublicHelper.shared.getBoldFont(size: 16)
        self.titleLabel.textColor = LCZPublicHelper.shared.getHexadecimalColor(hexadecimal: AppTitleColor)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
