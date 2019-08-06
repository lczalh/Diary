//
//  FoodRecipeListTableViewCell.swift
//  Diary
//
//  Created by linphone on 2019/7/31.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class FoodRecipeListTableViewCell: DiaryBaseTableViewCell {
    private var normalView:UIView!//全局视图
    var foodImgV:UIImageView! //图片
    var foodNameLbl:UILabel! //名字
    var foodIntroduceLbl:UILabel! //介绍
    var foodFlag:UILabel! //标签
    static let cellIdentifier = "FoodRecipeListTableViewCellIdentifier"
    
    override func config() {
        normalView = UIView()
        self.addSubview(normalView)
        normalView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.height.equalTo(120)
        }
        
        foodImgV = UIImageView()
        self.normalView.addSubview(foodImgV)
        foodImgV.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalTo(10)
            make.width.equalTo(150)
            make.height.equalTo(100)
        }
    
        foodImgV.layer.cornerRadius  = 5
        foodImgV.layer.masksToBounds = true
        
        foodNameLbl = UILabel()
        self.normalView.addSubview(foodNameLbl)
        foodNameLbl.snp.makeConstraints { (make) in
            make.left.equalTo(foodImgV.snp.right).offset(10)
            make.top.equalToSuperview().offset(10)
            make.height.equalTo(25)
            make.right.equalToSuperview()
        }
        
        foodNameLbl.text = "醋溜白菜"
        foodNameLbl.font = LCZPublicHelper.shared.getConventionFont(size: 15)
        foodNameLbl.textColor = UIColor.black
        
        foodIntroduceLbl = UILabel()
        self.normalView.addSubview(foodIntroduceLbl)
        foodIntroduceLbl.snp.makeConstraints { (make) in
            make.left.equalTo(foodImgV.snp.right).offset(10)
            make.top.equalTo(foodNameLbl.snp.bottom)
            make.height.equalTo(50)
            make.right.equalToSuperview()
        }
        
        foodIntroduceLbl.text = "醋溜白菜，是北方人经常吃的一道菜，尤其是在多年前的冬天。那时，没有大棚菜，冬天，家家每天佐餐的基本上都是冬储大白菜，聪明的家庭主妇总是想方设法将这单调的菜变成多种菜式，于是，醋溜白菜被频繁的端上餐桌。<br>美食不分贵贱，用最平凡的原料、最简单的调料和最普通的手法做出美味的菜肴来才是美食的真谛。 <br>这次，我做的醋溜白菜，近似鲁菜的做法，使个这道菜酸甜浓郁、开胃下饭、老少咸宜。"
        foodIntroduceLbl.font = LCZPublicHelper.shared.getConventionFont(size: 13)
        foodIntroduceLbl.textColor = UIColor.black
        foodIntroduceLbl.lineBreakMode = NSLineBreakMode.byTruncatingTail
        foodIntroduceLbl.numberOfLines = 3
        
        foodFlag = UILabel()
        self.normalView.addSubview(foodFlag)
        foodFlag.snp.makeConstraints { (make) in
            make.left.equalTo(foodImgV.snp.right).offset(10)
            make.top.equalTo(foodIntroduceLbl.snp.bottom)
            make.height.equalTo(25)
            make.right.equalToSuperview()
        }
        foodFlag.text = "减肥,家常菜,排毒,补钙"
        foodFlag.font = LCZPublicHelper.shared.getConventionFont(size: 13)
        foodFlag.textColor = UIColor(valueRGB: 0x57310C)
        foodFlag.lineBreakMode = NSLineBreakMode.byTruncatingTail
    }
    
}
