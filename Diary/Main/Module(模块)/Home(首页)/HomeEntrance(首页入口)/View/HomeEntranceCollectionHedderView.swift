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
            .lcz
            .addSubview(self)
            .snpMakeConstraints({ (make) in
                make.centerY.equalToSuperview()
                make.left.equalToSuperview().offset(15)
            })
            .contentMode(.scaleAspectFit)
            .build
        
        self.titleLabel = UILabel()
            .lcz
            .addSubview(self)
            .snpMakeConstraints({ (make) in
                make.centerY.equalTo(self.logoImageView)
                make.left.equalTo(self.logoImageView.snp.right).offset(5)
            })
            .font(LCZPublicHelper.shared.getBoldFont(size: 16))
            .textColor(LCZPublicHelper.shared.getHexadecimalColor(hexadecimal: AppTitleColor))
            .build

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
