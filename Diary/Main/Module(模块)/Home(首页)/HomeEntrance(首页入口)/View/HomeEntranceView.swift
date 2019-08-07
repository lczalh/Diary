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
            .lcz
            .itemSize(CGSize(width: (LCZPublicHelper.shared.getScreenWidth! - 15) / 4,
                             height: 70 * LCZPublicHelper.shared.getScreenSizeScale))
            .minimumLineSpacing(10)
            .minimumInteritemSpacing(5)
            .headerReferenceSize(CGSize(width: LCZPublicHelper.shared.getScreenWidth!,
                                        height: 40 * LCZPublicHelper.shared.getScreenSizeScale))
            .build

        collectionView = UICollectionView(frame: CGRect(x: 0,
                                                        y: -(LCZPublicHelper.shared.getstatusBarHeight! + LCZPublicHelper.shared.getNavigationHeight!),
                                                        width: LCZPublicHelper.shared.getScreenWidth!,
                                                        height: LCZPublicHelper.shared.getScreenHeight! - LCZPublicHelper.shared.getSafeAreaBottomHeight - LCZPublicHelper.shared.getTabbarHeight!),
                                          collectionViewLayout: layout)
            .lcz
            .addSubview(self)
            .backgroundColor(UIColor.white)
            .contentInset(UIEdgeInsets(top: 180 * LCZPublicHelper.shared.getScreenSizeScale, left: 0, bottom: 0, right: 0))
            .register(HomeEntranceCollectionViewCell.self, forCellWithReuseIdentifier: "HomeEntranceCollectionViewCell")
            .register(HomeEntranceCollectionHedderView.self, forSectionHeaderWithReuseIdentifier: "HomeEntranceCollectionHedderView")
            .build

    }
}


