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
    
//    public var fsPagerView: FSPagerView!
//
//    public var fsPageControl: FSPageControl!
    
    /// 轮播图
    public var shufflingFigureView: ShufflingFigureView!

    override func configUI() {
        createCollectionView()
        createShufflingFigure()
    }
    
    // MARK: - 轮播图
    private func createShufflingFigure() {
        shufflingFigureView = ShufflingFigureView(frame: CGRect(x: 0, y: -180, width: LCZWidth, height: 180))
        collectionView.addSubview(shufflingFigureView)
        shufflingFigureView.isSkeletonable = true
    }
    
    // MARK: - collectionView
    private func createCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (LCZWidth - 15) / 4, height: 70)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 5
        layout.headerReferenceSize = CGSize(width: LCZWidth, height: 40)
        collectionView = UICollectionView(frame: CGRect(x: 0, y: -(LCZStatusBarHeight + LCZNaviBarHeight), width: LCZWidth, height: LCZHeight - LCZSafeAreaBottomHeight - LCZTabbarHeight), collectionViewLayout: layout)
        self.addSubview(collectionView);
        collectionView.backgroundColor = UIColor.white
        collectionView.contentInset = UIEdgeInsets(top: 180, left: 0, bottom: 0, right: 0)
        collectionView.register(HomeEntranceCollectionViewCell.self, forCellWithReuseIdentifier: "HomeEntranceCollectionViewCell")
        collectionView.register(HomeEntranceCollectionHedderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HomeEntranceCollectionHedderView")
    }
}


