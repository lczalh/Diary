//
//  FoodDetailBasicInfoTableViewCell.swift
//  Diary
//
//  Created by linphone on 2019/8/1.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class FoodDetailBasicInfoTableViewCell:DiaryBaseTableViewCell {
    var foodNameLbl:UILabel! //食物名称
    var foodIntroduceLbl:UILabel! //介绍
    var cookingtimeLbl:UILabel! //烹饪时间
    var peoplenumLbl:UILabel! //用餐人数
    var foodFlag:UILabel! //标签
    static let cellIdentifier = "FoodDetailBasicInfoTableViewCellIdentifier"
    
    override func config() {
        foodNameLbl = UILabel()
        self.contentView.addSubview(foodNameLbl)
        foodNameLbl.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(5)
            make.height.equalTo(25)
            make.left.equalToSuperview().offset(13)
            make.right.equalToSuperview().offset(-13)
        }
   
        foodNameLbl.font = LCZPublicHelper.shared.getConventionFont(size: 14)
        foodNameLbl.textColor = UIColor(valueRGB: 0x454748)
        foodNameLbl.lineBreakMode = NSLineBreakMode.byTruncatingTail
        
        foodFlag = UILabel()
        self.contentView.addSubview(foodFlag)
        foodFlag.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(13)
            make.right.equalToSuperview().offset(-13)
        }
        
        foodFlag.font = LCZPublicHelper.shared.getConventionFont(size: 14)
        foodFlag.textColor = UIColor(valueRGB: 0x57310C)  
        foodFlag.lineBreakMode = NSLineBreakMode.byTruncatingTail
        
        peoplenumLbl = UILabel()
        self.contentView.addSubview(peoplenumLbl)
        peoplenumLbl.snp.makeConstraints { (make) in
            make.bottom.equalTo(foodFlag.snp.top)
            make.height.equalTo(25)
            make.left.equalToSuperview().offset(13)
            make.right.equalToSuperview().offset(-13)
        }
        peoplenumLbl.font = LCZPublicHelper.shared.getConventionFont(size: 14)
        peoplenumLbl.textColor = UIColor(valueRGB: 0x454748)
        peoplenumLbl.lineBreakMode = NSLineBreakMode.byTruncatingTail
        
        cookingtimeLbl = UILabel()
        self.contentView.addSubview(cookingtimeLbl)
        cookingtimeLbl.snp.makeConstraints { (make) in
            make.bottom.equalTo(peoplenumLbl.snp.top)
            make.height.equalTo(25)
            make.left.equalToSuperview().offset(13)
            make.right.equalToSuperview().offset(-13)
        }
        cookingtimeLbl.font = LCZPublicHelper.shared.getConventionFont(size: 14)
        cookingtimeLbl.textColor = UIColor(valueRGB: 0x454748)
        cookingtimeLbl.lineBreakMode = NSLineBreakMode.byTruncatingTail

        
        foodIntroduceLbl = UILabel()
        self.contentView.addSubview(foodIntroduceLbl)
        foodIntroduceLbl.snp.makeConstraints { (make) in
            make.top.equalTo(foodNameLbl.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(13)
            make.right.equalToSuperview().offset(-13)
            make.bottom.equalTo(cookingtimeLbl.snp.top).offset(-5)
        }
        
        foodIntroduceLbl.font = LCZPublicHelper.shared.getConventionFont(size: 14)
        foodIntroduceLbl.textColor = UIColor(valueRGB: 0x454748) 
//        foodIntroduceLbl.lineBreakMode = NSLineBreakMode.byTruncatingTail
        foodIntroduceLbl.numberOfLines = 0
        
        
        
       
    }
    
}
