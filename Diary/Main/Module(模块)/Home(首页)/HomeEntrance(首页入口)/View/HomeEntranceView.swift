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
        shufflingFigureView = ShufflingFigureView(frame: CGRect(x: 0, y: -180 * LCZPublicHelper.shared.getScreenSizeScale, width: LCZPublicHelper.shared.getScreenWidth!, height: 180 * LCZPublicHelper.shared.getScreenSizeScale))
        collectionView.addSubview(shufflingFigureView)
        shufflingFigureView.isSkeletonable = true
    }
    
    // MARK: - collectionView
    private func createCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (LCZPublicHelper.shared.getScreenWidth! - 15) / 4, height: 70 * LCZPublicHelper.shared.getScreenSizeScale)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 5
        layout.headerReferenceSize = CGSize(width: LCZPublicHelper.shared.getScreenWidth!, height: 40 * LCZPublicHelper.shared.getScreenSizeScale)
        collectionView = UICollectionView(frame: CGRect(x: 0, y: -(LCZPublicHelper.shared.getstatusBarHeight! + LCZPublicHelper.shared.getNavigationHeight!), width: LCZPublicHelper.shared.getScreenWidth!, height: LCZPublicHelper.shared.getScreenHeight! - LCZPublicHelper.shared.getSafeAreaBottomHeight - LCZPublicHelper.shared.getTabbarHeight!), collectionViewLayout: layout)
        self.addSubview(collectionView);
        collectionView.backgroundColor = UIColor.white
        collectionView.contentInset = UIEdgeInsets(top: 180 * LCZPublicHelper.shared.getScreenSizeScale, left: 0, bottom: 0, right: 0)
        collectionView.register(HomeEntranceCollectionViewCell.self, forCellWithReuseIdentifier: "HomeEntranceCollectionViewCell")
        collectionView.register(HomeEntranceCollectionHedderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HomeEntranceCollectionHedderView")
    }
}


