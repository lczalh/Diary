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
        shufflingFigureView = ShufflingFigureView(frame: CGRect(x: 0, y: -180 * cz_ScreenSizeScale, width: cz_ScreenWidth!, height: 180 * cz_ScreenSizeScale))
        collectionView.addSubview(shufflingFigureView)
        shufflingFigureView.isSkeletonable = true
    }
    
    // MARK: - collectionView
    private func createCollectionView() {
        let layout = UICollectionViewFlowLayout()
            .chain
            .itemSize(CGSize(width: (cz_ScreenWidth! - 15) / 4,
                             height: 70 * cz_ScreenSizeScale))
            .minimumLineSpacing(10)
            .minimumInteritemSpacing(5)
            .headerReferenceSize(CGSize(width: cz_ScreenWidth!,
                                        height: 40 * cz_ScreenSizeScale))
            .build

        collectionView = UICollectionView(frame: CGRect(x: 0,
                                                        y: -(cz_StatusBarHeight! + cz_NavigationHeight!),
                                                        width: cz_ScreenWidth!,
                                                        height: LCZPublicHelper.shared.getScreenHeight! - cz_SafeAreaBottomHeight - cz_TabbarHeight!),
                                          collectionViewLayout: layout)
            .chain
            .addSuperView(self)
            .backgroundColor(UIColor.white)
            .contentInset(UIEdgeInsets(top: 180 * cz_ScreenSizeScale, left: 0, bottom: 0, right: 0))
            .register(HomeEntranceCollectionViewCell.self, forCellWithReuseIdentifier: "HomeEntranceCollectionViewCell")
            .register(HomeEntranceCollectionHedderView.self, forSectionHeaderWithReuseIdentifier: "HomeEntranceCollectionHedderView")
            .build

    }
}


