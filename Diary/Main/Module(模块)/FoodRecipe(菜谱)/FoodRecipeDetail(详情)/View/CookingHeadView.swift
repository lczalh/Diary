//
//  CookingHeadView.swift
//  Diary
//
//  Created by linphone on 2019/8/1.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class CookingHeadView: DiaryBaseView {
    var titleLbl:UILabel = UILabel()//烹饪流程
    var cookingBtn:UIButton! //烹饪模式按钮
    private var cookingButtonAnimation:POPBasicAnimation!
    override func configUI() {
        self.addSubview(titleLbl)
        titleLbl.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(13)
            make.centerY.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(45)
        }
        
        titleLbl.text = "烹饪流程"
        titleLbl.textColor = UIColor(valueRGB: 0x57310C)
        titleLbl.font = LCZPublicHelper.shared.getBoldFont(size: 18)
        cookingBtn = UIButton()
        self.addSubview(cookingBtn)
        cookingBtn.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-13)
            make.centerY.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(25)
        }
        cookingBtn.titleLabel?.font = LCZPublicHelper.shared.getConventionFont(size: 16)
        cookingBtn.setTitleColor(UIColor(valueRGB: 0xffffff), for: .normal)
        cookingBtn.setTitle("烹饪模式", for: .normal)
        cookingBtn.backgroundColor = UIColor(valueRGB: 0x57310C)
        cookingBtn.layer.cornerRadius = 5
        cookingBtn.layer.masksToBounds = true
        
        //动画效果
        cookingButtonAnimation = POPBasicAnimation(propertyNamed: kPOPLayerScaleXY)
        cookingButtonAnimation.duration = 1
        cookingButtonAnimation.repeatForever = true
        cookingButtonAnimation.autoreverses = true
        cookingButtonAnimation.timingFunction = CAMediaTimingFunction.init(name: .easeInEaseOut)
        cookingButtonAnimation.toValue = NSValue(cgSize: CGSize(width: 0.75, height: 0.75))
        cookingButtonAnimation.fromValue = NSValue(cgSize: CGSize(width: 1.0, height: 1.0))
        
        cookingBtn.layer.pop_add(cookingButtonAnimation, forKey: "cookingButtonAnimation")
  }

}
