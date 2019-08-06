//
//  FoodRecipeListCollectionViewCell.swift
//  Diary
//
//  Created by linphone on 2019/7/31.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class FoodRecipeListCollectionViewCell:  DiaryBaseCollectionViewCell {
    
    private var normalView:UIView!//全局视图
    var foodImgV:UIImageView! //图片
    var foodNameLbl:UILabel! //名字
    var foodIntroduceLbl:UILabel! //介绍
    var foodFlag:UILabel! //标签
    static let cellIdentifier = "FoodRecipeListCollectionViewCellIdentifier"
    
    override func config() {
        self.backgroundColor = UIColor.clear
        createChildView()
        oneListFoodLayout()
        settingValueStyle()
    }
    
    private func createChildView(){
        normalView = UIView()
        self.addSubview(normalView)
        
        foodImgV = UIImageView()
        self.normalView.addSubview(foodImgV)
        
        foodNameLbl = UILabel()
        self.normalView.addSubview(foodNameLbl)
        
        foodIntroduceLbl = UILabel()
        self.normalView.addSubview(foodIntroduceLbl)
        
        foodFlag = UILabel()
        self.normalView.addSubview(foodFlag)
    }
    
    private func settingValueStyle(){
        
        normalView.backgroundColor = UIColor.white
        normalView.layer.cornerRadius =  7.5
        normalView.layer.masksToBounds = true
    foodImgV.setImageWithURLString("http://api.jisuapi.com/recipe/upload/20160719/115138_46688.jpg", placeholder: nil)
        foodImgV.layer.cornerRadius  = 5
        foodImgV.layer.masksToBounds = true
        
       
        foodNameLbl.text = "醋溜白菜"
        foodNameLbl.font = LCZPublicHelper.shared.getConventionFont(size: 15)
        foodNameLbl.textColor = UIColor.black
        
        foodIntroduceLbl.text = "醋溜白菜，是北方人经常吃的一道菜，尤其是在多年前的冬天。那时，没有大棚菜，冬天，家家每天佐餐的基本上都是冬储大白菜，聪明的家庭主妇总是想方设法将这单调的菜变成多种菜式，于是，醋溜白菜被频繁的端上餐桌。<br>美食不分贵贱，用最平凡的原料、最简单的调料和最普通的手法做出美味的菜肴来才是美食的真谛。 <br>这次，我做的醋溜白菜，近似鲁菜的做法，使个这道菜酸甜浓郁、开胃下饭、老少咸宜。"
        foodIntroduceLbl.font = LCZPublicHelper.shared.getConventionFont(size: 13)
        foodIntroduceLbl.textColor = UIColor.black
        foodIntroduceLbl.lineBreakMode = NSLineBreakMode.byTruncatingTail
        foodIntroduceLbl.numberOfLines = 3
        
        
        foodFlag.text = "减肥,家常菜,排毒,补钙"
        foodFlag.font = LCZPublicHelper.shared.getConventionFont(size: 13)
        foodFlag.textColor = UIColor(valueRGB: 0x57310C)
        foodFlag.lineBreakMode = NSLineBreakMode.byTruncatingTail
    }
    
    public func oneListFoodLayout(){
        normalView.snp.remakeConstraints { (make) in
            make.left.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-5)
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview()
        }
        
        normalView.backgroundColor = UIColor.white
        normalView.layer.cornerRadius =  7.5
        normalView.layer.masksToBounds = true

        foodImgV.snp.remakeConstraints { (make) in
            make.top.left.equalToSuperview().offset(10)
            make.width.equalTo(150)
            make.height.equalTo(100)
        }
        foodNameLbl.snp.remakeConstraints { (make) in
            make.left.equalTo(foodImgV.snp.right).offset(10)
            make.top.equalToSuperview().offset(10)
            make.height.equalTo(25)
            make.right.equalToSuperview()
        }
        foodIntroduceLbl.snp.remakeConstraints { (make) in
            make.left.equalTo(foodImgV.snp.right).offset(10)
            make.top.equalTo(foodNameLbl.snp.bottom)
            make.height.equalTo(50)
            make.right.equalToSuperview()
        }
        foodFlag.snp.remakeConstraints { (make) in
            make.left.equalTo(foodImgV.snp.right).offset(10)
            make.top.equalTo(foodIntroduceLbl.snp.bottom)
            make.height.equalTo(25)
            make.right.equalToSuperview()
        }
    }
    
    public func twoListFoodLayout(){
        normalView.snp.remakeConstraints { (make) in
            make.left.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-5)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview()
        }

        foodImgV.snp.remakeConstraints { (make) in
            make.left.top.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-5)
            make.height.equalTo(100)
        }
        foodNameLbl.snp.remakeConstraints { (make) in
            make.top.equalTo(foodImgV.snp.bottom)
            make.left.equalToSuperview().offset(10)
            make.height.equalTo(25)
            make.right.equalToSuperview()
        }
        foodIntroduceLbl.snp.remakeConstraints { (make) in
            make.top.equalTo(foodNameLbl.snp.bottom)
            make.left.equalToSuperview().offset(10)
            make.height.equalTo(50)
            make.right.equalToSuperview()
        }
        foodFlag.snp.remakeConstraints { (make) in
            make.top.equalTo(foodIntroduceLbl.snp.bottom)
            make.left.equalToSuperview().offset(10)
            make.height.equalTo(25)
            make.right.equalToSuperview()
        }
    }
    
}
