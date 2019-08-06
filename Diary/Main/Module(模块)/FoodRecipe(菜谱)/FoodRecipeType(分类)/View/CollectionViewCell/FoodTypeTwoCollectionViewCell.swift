//
//  FoodTypeTwoCollectionViewCell.swift
//  Diary
//
//  Created by linphone on 2019/7/30.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class FoodTypeTwoCollectionViewCell: DiaryBaseCollectionViewCell {
    var typeLbl:UILabel! //选中种类
    static let cellIdentifier = "FoodTypeTwoCollectionViewCellIdentifier"
    
    
    override func config() {
        self.contentView.layer.cornerRadius = 15
        self.contentView.layer.masksToBounds = true
        self.contentView.layer.borderWidth  = 1
        self.contentView.layer.borderColor = UIColor(valueRGB: 0xF6F6F6).cgColor
        
        typeLbl = UILabel()
        self.contentView.addSubview(typeLbl)
        typeLbl.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        typeLbl.textColor = UIColor(valueRGB: 0x000000)
        typeLbl.textAlignment = .center
        typeLbl.font = LCZPublicHelper.shared.getConventionFont(size: 14)
    }
    
}
