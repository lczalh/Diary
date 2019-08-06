//
//  FoodCookingProcessView.swift
//  Diary
//
//  Created by linphone on 2019/8/1.
//  Copyright © 2019 lcz. All rights reserved.
// 流程

import UIKit
import FSPagerView

class FoodCookingProcessView: DiaryBaseView {
     private let shufflingFigureTransformerTypes: [FSPagerViewTransformerType] = [.depth,.zoomOut,.crossFading]
    var processNum:UILabel! //流程
    fileprivate var despLbl:UILabel!//提示
//    var leftBtn:UIButton! //左按钮
//    var rightBtn:UIButton! //右按钮
    
    lazy var newPagerView:FSPagerView = {
        let newView = FSPagerView()
        
        newView.itemSize = FSPagerView.automaticSize
        newView.automaticSlidingInterval = 0
        newView.isInfinite = true
        newView.decelerationDistance = FSPagerView.automaticDistance
        newView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "FoodCookingProcessViewCellIdentifier")
//        // 随机轮播图样式
        let i = arc4random_uniform(3 - 0) + 0
        let type = shufflingFigureTransformerTypes[Int(i)]
        newView.transformer = FSPagerViewTransformer(type:type)
//        newView.itemSize = FSPagerView.automaticSize
        newView.decelerationDistance = 1
        newView.layer.cornerRadius = 5
        newView.layer.masksToBounds = true
        return newView
    }()//流程滚动视图

    override func configUI() {
        self.backgroundColor = UIColor.clear
        processNum = UILabel()
        self.addSubview(processNum)
        processNum.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(45)
        }
        
         processNum.attributedText = LCZPublicHelper.shared.setTwoTextFontAndColorStyle(oneTextStr: "1", oneTextFont: LCZPublicHelper.shared.getConventionFont(size: 24), oneTextColor: UIColor(valueRGB: 0x57310C), twoTextStr: "/\(6)", twoTextFont: LCZPublicHelper.shared.getConventionFont(size: 16), twoTextColor: UIColor(valueRGB: 0xA4A5A8) )
        
    
        self.addSubview(newPagerView)
        newPagerView.snp.makeConstraints { (make) in
            make.top.equalTo(processNum.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-40)
        }
        
        despLbl = UILabel()
        self.addSubview(despLbl)
        despLbl.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-7.5)
            make.height.equalTo(25)
        }
        despLbl.text = "左右滑动切换流程"
        despLbl.textColor = UIColor(valueRGB: 0x57310C)
        despLbl.textAlignment = .center
        despLbl.font = LCZPublicHelper.shared.getConventionFont(size: 15)
    }

}
