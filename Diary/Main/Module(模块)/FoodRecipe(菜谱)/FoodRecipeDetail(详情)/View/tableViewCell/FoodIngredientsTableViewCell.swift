//
//  FoodIngredientsTableViewCell.swift
//  Diary
//
//  Created by linphone on 2019/8/1.
//  Copyright © 2019 lcz. All rights reserved.
// 所需食材

import UIKit

class FoodIngredientsTableViewCell:DiaryBaseTableViewCell {
    var IngredientsNameLbl:UILabel! //食材名
    var IngredientsNumLbl:UILabel! //用量
    var lineLbl:UILabel! //分隔线
    static let cellIdentifier = "FoodIngredientsTableViewCellIdentifier"
    
    override func config() {
        
        IngredientsNumLbl = UILabel()
        self.contentView.addSubview(IngredientsNumLbl)
        IngredientsNumLbl.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.width.equalTo(LCZPublicHelper.shared.getScreenWidth!/2 - 13)
            make.right.equalToSuperview().offset(-13)
            make.height.equalTo(45)
        }
        IngredientsNumLbl.text = "380g"
        IngredientsNumLbl.font = LCZPublicHelper.shared.getBoldFont(size: 16)
        IngredientsNumLbl.textAlignment = .right
        IngredientsNumLbl.textColor = UIColor(valueRGB: 0x000000)
        
        IngredientsNameLbl = UILabel()
        self.contentView.addSubview(IngredientsNameLbl)
        IngredientsNameLbl.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.width.equalTo(LCZPublicHelper.shared.getScreenWidth!/2 - 13)
            make.left.equalToSuperview().offset(13)
            make.height.equalTo(45)
        }
        IngredientsNameLbl.text = "白菜(主)"
        IngredientsNameLbl.font = LCZPublicHelper.shared.getBoldFont(size: 16)
        IngredientsNameLbl.textColor = UIColor(valueRGB: 0x000000)
        
        lineLbl = UILabel()
        self.contentView.addSubview(lineLbl)
        lineLbl.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.height.equalTo(0.5)
            make.right.equalToSuperview().offset(-13)
            make.left.equalToSuperview().offset(13)
        }
        lineLbl.backgroundColor = UIColor(valueRGB: 0xdfdfdf) 
        
    }
    
}
