//
//  CookingProcessTableViewCell.swift
//  Diary
//
//  Created by linphone on 2019/8/1.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class CookingProcessTableViewCell: DiaryBaseTableViewCell {
    var processDespLbl:UILabel! //流程描述
    var foodImgV:UIImageView! //图片
    var processContentLbl:UILabel! //流程内容
   
    static let cellIdentifier = "CookingProcessTableViewCellIdentifier"
    
    override func config() {
        
        processDespLbl = UILabel()
        self.contentView.addSubview(processDespLbl)
        processDespLbl.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(13)
            make.top.equalToSuperview().offset(5)
            make.height.equalTo(50)
            make.right.equalToSuperview().offset(-13)
        }
        
        processDespLbl.attributedText = LCZPublicHelper.shared.setTwoTextFontAndColorStyle(oneTextStr: "流程1", oneTextFont: LCZPublicHelper.shared.getConventionFont(size: 22), oneTextColor: UIColor(valueRGB: 0x57310C), twoTextStr: "/\(8)", twoTextFont: LCZPublicHelper.shared.getConventionFont(size: 15), twoTextColor: UIColor(valueRGB: 0xA4A5A8))
       
        foodImgV = UIImageView()
        self.contentView.addSubview(foodImgV)
        foodImgV.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(13)
            make.top.equalTo(processDespLbl.snp.bottom).offset(5)
            make.right.equalToSuperview().offset(-13)
            make.height.equalTo(200)
        }
    
        foodImgV.layer.cornerRadius  = 5
        foodImgV.layer.masksToBounds = true
        
        processContentLbl = UILabel()
        self.contentView.addSubview(processContentLbl)
        processContentLbl.snp.makeConstraints { (make) in
            make.top.equalTo(foodImgV.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(13)
            make.right.equalToSuperview().offset(-13)
            make.bottom.equalToSuperview().offset(-5)
        }
        
       
        processContentLbl.font = LCZPublicHelper.shared.getConventionFont(size: 15)
        processContentLbl.textColor = UIColor.black
        processContentLbl.numberOfLines = 0
        
        
        
    }
    
}
