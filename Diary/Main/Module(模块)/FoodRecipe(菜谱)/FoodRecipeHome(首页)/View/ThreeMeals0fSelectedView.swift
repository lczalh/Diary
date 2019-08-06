//
//  ThreeMeals0fSelectedView.swift
//  Diary
//
//  Created by linphone on 2019/7/30.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class ThreeMeals0fSelectedView: DiaryBaseView {
     var titleLbl:UILabel = UILabel()//三餐精选
     var newSegmentCon:UISegmentedControl!
    fileprivate var newSegmentItems:Array<String> = ["早餐","午餐","晚餐"]
    override func configUI() {
        self.addSubview(titleLbl)
        titleLbl.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(45)
        }

        titleLbl.text = "三餐精选"
        titleLbl.textColor = UIColor(valueRGB: 0x57310C)
        titleLbl.font = LCZPublicHelper.shared.getBoldFont(size: 20)
        newSegmentCon = UISegmentedControl(items: newSegmentItems)
        newSegmentCon.selectedSegmentIndex = 0
        self.addSubview(newSegmentCon)
        newSegmentCon.snp.makeConstraints { (make) in
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(180)
            make.height.equalTo(25)
        }
        newSegmentCon.tintColor = UIColor(valueRGB: 0x57310C)
    }

}
