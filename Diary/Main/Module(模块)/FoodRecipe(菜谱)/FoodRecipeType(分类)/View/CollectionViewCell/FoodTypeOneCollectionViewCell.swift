//
//  FoodTypeOneCollectionViewCell.swift
//  Diary
//
//  Created by linphone on 2019/7/29.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class FoodTypeOneCollectionViewCell: DiaryBaseCollectionViewCell {
    var leftLineLbl:UILabel! //选中标识线
    var typeLbl:UILabel! //选中种类
    static let cellIdentifier = "FoodTypeOneCollectionViewCellIdentifier"
    
    
    override func config() {
        self.contentView.backgroundColor = UIColor(valueRGB: 0xf6f6f6)
        leftLineLbl = UILabel()
        self.contentView.addSubview(leftLineLbl)
        leftLineLbl.snp.makeConstraints { (make) in
            make.left.top.bottom.equalToSuperview()
            make.width.equalTo(2)
        }
        leftLineLbl.backgroundColor = UIColor(valueRGB: 0x57310C)
        leftLineLbl.isHidden = true
        
        typeLbl = UILabel()
        self.contentView.addSubview(typeLbl)
        typeLbl.snp.makeConstraints { (make) in
            make.top.bottom.right.equalToSuperview()
            make.left.equalTo(leftLineLbl.snp.right)
        }
        typeLbl.textAlignment = .center
        typeLbl.font = LCZPublicHelper.shared.getConventionFont(size: 16)
    }
    
}
