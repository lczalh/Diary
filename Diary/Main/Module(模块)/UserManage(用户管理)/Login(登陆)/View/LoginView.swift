//
//  LoginView.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/6/18.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class LoginView: DiaryBaseView {

    override func configUI() {
        // appIcon图标
        let iconImageView = UIImageView()
        self.addSubview(iconImageView)
        iconImageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview().offset(-40)
            make.top.equalToSuperview().offset(50)
         //   make.size.equalTo(80)
        }
        iconImageView.image = UIImage(named: "logo")
        iconImageView.contentMode = .scaleAspectFill
        
        // 应用名称
        let appNameLabel = UILabel()
        self.addSubview(appNameLabel)
        appNameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(iconImageView.snp.right).offset(5)
            make.centerY.equalTo(iconImageView)
        }
        appNameLabel.text = "乐淘世界"
        appNameLabel.font = LCZBoldFontSize(size: 20)
        
    }

}
