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

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isSkeletonable = true
        fsPagerView = FSPagerView(frame: frame)
        self.addSubview(fsPagerView)
        fsPagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        fsPagerView.itemSize = FSPagerView.automaticSize
        fsPagerView.automaticSlidingInterval = 3
        fsPagerView.isInfinite = !fsPagerView.isInfinite
        fsPagerView.decelerationDistance = FSPagerView.automaticDistance
        fsPagerView.isSkeletonable = true
        fsPageControl = FSPageControl()
        fsPagerView.addSubview(fsPageControl)
        fsPageControl.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-5)
        }
        fsPageControl.contentHorizontalAlignment = .right
        //设置下标指示器颜色（选中状态和普通状态）
        fsPageControl.setFillColor(LCZHexadecimalColor(hexadecimal: "#57310C"), for: .normal)
        fsPageControl.setFillColor(LCZHexadecimalColor(hexadecimal: "#FECE1D"), for: .selected)
        fsPageControl.isSkeletonable = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
