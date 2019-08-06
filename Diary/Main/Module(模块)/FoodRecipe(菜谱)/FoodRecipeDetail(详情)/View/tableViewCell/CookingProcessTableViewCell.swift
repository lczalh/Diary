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
        
        processContentLbl.text = "准备食材。 将白菜斜刀片成薄片 ,片切好的白菜帮与菜叶分别入好.盐、糖、生抽、醋淀粉加少许水调匀备用。锅中油烧热，先入花椒炒香后捞出。再加入干红椒段略炒。,加入葱姜蒜煸炒香，然后入白菜帮翻炒。炒至菜帮变软时，加入白菜叶。快速翻炒至菜软，勾入碗汁,使汤汁均匀的包裹在菜帮上即可"
        processContentLbl.font = LCZPublicHelper.shared.getConventionFont(size: 15)
        processContentLbl.textColor = UIColor.black
        processContentLbl.numberOfLines = 0
        
        
        
    }
    
}
