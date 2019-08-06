//
//  PrivacyPolicyView.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/6/24.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class PrivacyPolicyView: DiaryBaseView {

    /// 内容
    public var contentLabel: UILabel!
    
    /// 滚动视图
    public var scrollView: UIScrollView!
    
    override func configUI() {
        
        // 滚动视图
        scrollView = UIScrollView(frame: self.bounds)
        self.addSubview(scrollView)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        contentLabel = UILabel()
        scrollView.addSubview(contentLabel)
        contentLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.scrollView).offset(10)
            make.left.equalTo(self).offset(15)
            make.right.equalTo(self).offset(-15)
        }
        contentLabel.font = LCZPublicHelper.shared.getConventionFont(size: 14)
        contentLabel.numberOfLines = 0
        contentLabel.lineBreakMode = .byCharWrapping
        
        
    }
}
