//
//  HomeEntranceCollectionViewCell.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/6/10.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class HomeEntranceCollectionViewCell: DiaryBaseCollectionViewCell {
    
    /// 图标
    public var logoImageView: UIImageView!
    
    /// 标题
    public var titleLabel: UILabel!
    
    override func config() {
        logoImageView = UIImageView()
        self.contentView.addSubview(logoImageView)
        self.logoImageView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.height.width.equalTo(40 * cz_ScreenSizeScale)
        }
        self.logoImageView.contentMode = .scaleAspectFit
        
        titleLabel = UILabel()
        self.contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.bottom.equalToSuperview()
            make.height.equalTo(30)
        }
        titleLabel.font = cz_ConventionFont(size: 14)
        titleLabel.textColor = cz_HexadecimalColor(hexadecimal: AppContentColor)
    }
}
