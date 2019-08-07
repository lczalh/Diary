//
//  CookingProcessInfoShowView.swift
//  Diary
//
//  Created by linphone on 2019/8/2.
//  Copyright © 2019 lcz. All rights reserved.
// 具体流程步骤显示视图

import UIKit

class CookingProcessInfoShowView: DiaryBaseView {
    var processPicImgV:UIImageView! //流程图片
    var processContentLbl:UILabel! //流程内容
    
    override func configUI() {
        processPicImgV = UIImageView()
        self.addSubview(processPicImgV)
        processPicImgV.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(160)
        }
        
        processContentLbl = UILabel()
        self.addSubview(processContentLbl)
        processContentLbl.snp.makeConstraints { (make) in
            make.top.equalTo(processPicImgV.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(10)
            make.right.bottom.equalToSuperview().offset(-10)
            
        }
       
        processContentLbl.font = LCZPublicHelper.shared.getConventionFont(size: 16)
        processContentLbl.textColor = UIColor.black
        processContentLbl.numberOfLines = 0
        
    }

}
