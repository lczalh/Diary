//
//  HotDishesTypeCollectionViewCell.swift
//  Diary
//
//  Created by linphone on 2019/7/31.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class HotDishesTypeCollectionViewCell: DiaryBaseCollectionViewCell {
    var typeIconImgV:UIImageView! //图标
    var typeTitleLbl:UILabel! //标题
    static let cellIdentifier = "HotDishesTypeCollectionViewCellIdentifier"
    
    
    override func config() {
        typeIconImgV = UIImageView()
        self.contentView.addSubview(typeIconImgV)
        typeIconImgV.snp.makeConstraints { (make) in
            make.centerX.top.equalToSuperview()
            make.width.height.equalTo(35 * LCZPublicHelper.shared.getScreenSizeScale)
        }
        typeIconImgV.layer.cornerRadius = 17.5 * LCZPublicHelper.shared.getScreenSizeScale
        typeIconImgV.layer.masksToBounds = true
        
        typeTitleLbl = UILabel()
        self.contentView.addSubview(typeTitleLbl)
        typeTitleLbl.snp.makeConstraints { (make) in
            make.top.equalTo(typeIconImgV.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(25)
        }
        typeTitleLbl.text = "家常菜"
        typeTitleLbl.textAlignment = .center
        typeTitleLbl.font = LCZPublicHelper.shared.getConventionFont(size: 14)
    }
    
}
