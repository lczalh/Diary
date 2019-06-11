//
//  HomeEntranceView.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/6/10.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class HomeEntranceView: DiaryBaseView {
    
    public var collectionView: UICollectionView!
    
    public var fsPagerView: FSPagerView!
    
    public var fsPageControl: FSPageControl!

    override func configUI() {
        createCollectionView()
        createShufflingFigure()
    }
    
    // MARK: - 轮播图
    private func createShufflingFigure() {
        
        fsPagerView = FSPagerView(frame: CGRect(x: 0, y: -180, width: LCZWidth, height: 180))
        collectionView.addSubview(fsPagerView)
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
        //设置下标指示器颜色（选中状态和普通状态）
        fsPageControl.setFillColor(LCZHexadecimalColor(hexadecimal: "#57310C"), for: .normal)
        fsPageControl.setFillColor(LCZHexadecimalColor(hexadecimal: "#FECE1D"), for: .selected)
        
    }
    
    // MARK: - collectionView
    private func createCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (LCZWidth - 15) / 4, height: 70)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 5
        layout.headerReferenceSize = CGSize(width: LCZWidth, height: 40)
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: LCZWidth, height: LCZHeight - LCZNaviBarHeight - LCZStatusBarHeight - LCZSafeAreaBottomHeight - LCZTabbarHeight), collectionViewLayout: layout)
        self.addSubview(collectionView);
        collectionView.backgroundColor = UIColor.white
        collectionView.contentInset = UIEdgeInsets(top: 180, left: 0, bottom: 0, right: 0)
        collectionView.register(HomeEntranceCollectionViewCell.self, forCellWithReuseIdentifier: "HomeEntranceCollectionViewCell")
        collectionView.register(HomeEntranceCollectionHedderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HomeEntranceCollectionHedderView")
    }
}


