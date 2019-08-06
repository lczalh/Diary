//
//  TelevisionView.swift
//  Diary
//
//  Created by glgl on 2019/7/16.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class TelevisionView: DiaryBaseView {
    
//    public var collectionView: UICollectionView!
    
    public var categoryView: JXCategoryTitleView?
    
    override func configUI() {
        self.isSkeletonable = true
        
        // 标题UI
        categoryView = JXCategoryTitleView()
        categoryView!.frame = CGRect(x: 0, y: 0, width: LCZPublicHelper.shared.getScreenWidth!, height: 44)
        categoryView!.defaultSelectedIndex = 0
        categoryView!.titleSelectedFont = LCZPublicHelper.shared.getConventionFont(size: 15)
        categoryView!.isTitleColorGradientEnabled = true
        categoryView!.isTitleLabelZoomEnabled = true
        categoryView!.titleLabelZoomScale = 1.2
        categoryView!.isTitleLabelZoomScrollGradientEnabled = true
        categoryView!.isCellWidthZoomEnabled = true
        categoryView!.cellWidthZoomScale = 1.2
        categoryView!.isAverageCellSpacingEnabled = true
        // 标题下标
        let lineView = JXCategoryIndicatorLineView()
        categoryView!.indicators = [lineView]
        lineView.lineStyle = .IQIYI;
        self.addSubview(categoryView!)
    }
    
    

}
