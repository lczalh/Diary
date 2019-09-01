//
//  ShufflingFigureView.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/6/26.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class ShufflingFigureView: UIView {
    
    public var fsPagerView: FSPagerView!
    
    public var fsPageControl: FSPageControl!
    
    /// 轮播图样式
    private let shufflingFigureTransformerTypes: [FSPagerViewTransformerType] = [.crossFading,
                                                                                .zoomOut,
                                                                                .depth,
                                                                                .linear,
                                                                                .overlap,
                                                                                .ferrisWheel,
                                                                                .invertedFerrisWheel,
                                                                                .coverFlow,
                                                                                .cubic]

    override init(frame: CGRect) {
        super.init(frame: frame)
        fsPagerView = FSPagerView(frame: bounds)
        self.addSubview(fsPagerView)
        fsPagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        fsPagerView.itemSize = FSPagerView.automaticSize
        fsPagerView.automaticSlidingInterval = 3
        fsPagerView.isInfinite = !fsPagerView.isInfinite
        fsPagerView.decelerationDistance = FSPagerView.automaticDistance
        fsPageControl = FSPageControl()
        fsPagerView.addSubview(fsPageControl)
        fsPageControl.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-5)
        }
        fsPageControl.contentHorizontalAlignment = .right
        fsPagerView.contentMode = .scaleAspectFill
        //设置下标指示器颜色（选中状态和普通状态）
        fsPageControl.setFillColor(cz_HexadecimalColor(hexadecimal: AppTitleColor), for: .normal)
        fsPageControl.setFillColor(cz_HexadecimalColor(hexadecimal: AppContentColor), for: .selected)
        // 随机轮播图样式
        let i = arc4random_uniform(9 - 0) + 0
        let type = shufflingFigureTransformerTypes[Int(i)]
        fsPagerView.transformer = FSPagerViewTransformer(type:type)
        switch type {
        case .crossFading, .zoomOut, .depth:
            fsPagerView.itemSize = FSPagerView.automaticSize
            fsPagerView.decelerationDistance = 1
        case .linear, .overlap:
            let transform = CGAffineTransform(scaleX: 0.6, y: 0.75)
            fsPagerView.itemSize = fsPagerView.frame.size.applying(transform)
            fsPagerView.decelerationDistance = FSPagerView.automaticDistance
        case .ferrisWheel, .invertedFerrisWheel:
            fsPagerView.itemSize = CGSize(width: 180, height: 140)
            fsPagerView.decelerationDistance = FSPagerView.automaticDistance
        case .coverFlow:
            fsPagerView.itemSize = CGSize(width: 220, height: 170)
            fsPagerView.decelerationDistance = FSPagerView.automaticDistance
        case .cubic:
            let transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            fsPagerView.itemSize = fsPagerView.frame.size.applying(transform)
            fsPagerView.decelerationDistance = 1
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
