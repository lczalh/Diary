//
//  AboutUsView.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/6/24.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class AboutUsView: DiaryBaseView {

    override func configUI() {
        let logoImageView = UIImageView()
        self.addSubview(logoImageView)
        logoImageView.image = UIImage(named: "logo")
        logoImageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(80)
        }
        
        let appNameLabel = UILabel()
        self.addSubview(appNameLabel)
        appNameLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(logoImageView.snp.bottom).offset(5)
        }
        appNameLabel.font = LCZBoldFontSize(size: 18)
        appNameLabel.text = LCZAppName
        appNameLabel.textColor = LCZHexadecimalColor(hexadecimal: AppContentColor)
        
        let explainLabel = UILabel()
        self.addSubview(explainLabel)
        explainLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(appNameLabel.snp.bottom).offset(5)
        }
        explainLabel.font = LCZFontSize(size: 14)
        explainLabel.textColor = LCZHexadecimalColor(hexadecimal: "#bfbfbf")
        explainLabel.text = "\(LCZAppName)，精彩不容错过"
        
        let versionLabel = UILabel()
        self.addSubview(versionLabel)
        versionLabel.font = LCZFontSize(size: 14)
        versionLabel.text = "当前版本 \(LCZVersion!)"
        versionLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(explainLabel.snp.bottom).offset(5)
        }
        versionLabel.textColor = LCZHexadecimalColor(hexadecimal: "#bfbfbf")
    }
}
