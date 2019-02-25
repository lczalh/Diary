//
//  NewsHomeView.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/2/13.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class NewsHomeView: DiaryBaseView {
    
    var categoryView: JXCategoryTitleView?
    
    override func configUI() {
        // 标题UI
        categoryView = JXCategoryTitleView()
        categoryView!.frame = CGRect(x: 0, y: LCZNaviBarHeight + LCZStatusBarHeight, width: LCZWidth, height: 44)
        categoryView!.defaultSelectedIndex = 0
        categoryView!.titleSelectedFont = LCZFontSize(size: 15)
        categoryView!.titleColorGradientEnabled = true
        categoryView!.titleLabelZoomEnabled = true
        categoryView!.titleLabelZoomScale = 1.2
        categoryView!.titleLabelZoomScrollGradientEnabled = true
        categoryView!.cellWidthZoomEnabled = true
        categoryView!.cellWidthZoomScale = 1.2
        categoryView!.averageCellSpacingEnabled = false
        // 标题下标
        let lineView = JXCategoryIndicatorLineView()
        categoryView!.indicators = [lineView]
        lineView.lineStyle = .IQIYI;
        self.addSubview(categoryView!)
    }

}
