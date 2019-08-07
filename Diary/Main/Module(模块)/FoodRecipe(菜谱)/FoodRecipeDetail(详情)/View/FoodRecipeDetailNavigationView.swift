//
//  FoodRecipeDetailNavigationView.swift
//  Diary
//
//  Created by linphone on 2019/7/31.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class FoodRecipeDetailNavigationView: DiaryBaseView {
    var backBtn:UIButton!  //返回按钮
    var titleLbl:UILabel! //菜名
    
    override func configUI() {
        
        self.backgroundColor = UIColor.clear
        
        backBtn = UIButton()
        self.addSubview(backBtn)
        backBtn.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(15)
            make.width.height.equalTo(35)
        }
        backBtn.setImage(UIImage(named: "zuojiantou"), for: .normal)
        
        titleLbl = UILabel()
        self.addSubview(titleLbl)
        titleLbl.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.height.equalTo(35)
            make.width.equalTo(280)
        }
        
        titleLbl.font = LCZPublicHelper.shared.getConventionFont(size: 18)
        titleLbl.textAlignment = .center
        titleLbl.adjustsFontSizeToFitWidth = true
    }
    
}
