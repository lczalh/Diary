//
//  NewsMovieHomeContentView.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/6/26.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class NewsMovieHomeContentView: DiaryBaseView {
    
    public var collectionView: UICollectionView!

    override func configUI() {
        self.isSkeletonable = true
        createCollectionView()
    }
    
    /// 创建CollectionView
    private func createCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (cz_ScreenWidth! - 2) / 2 , height: 150 * cz_ScreenSizeScale)
        layout.minimumInteritemSpacing = 2
        layout.minimumLineSpacing = 0
        collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        self.addSubview(collectionView)
        collectionView.register(NewsMovieHomeCollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "NewsMovieHomeCollectionHeaderView")
        collectionView.register(NewsMovieHomeShufflingFigureCollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "NewsMovieHomeShufflingFigureCollectionHeaderView")
        collectionView.register(NewsMovieCollectionViewCell.self, forCellWithReuseIdentifier: "NewsMovieCollectionViewCell")
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: cz_TabbarHeight! + cz_SafeAreaBottomHeight + cz_StatusBarHeight! + cz_NavigationHeight!, right: 0)
        collectionView.backgroundColor = UIColor.clear
        collectionView.isSkeletonable = true
        collectionView.lcz_isUseComponent = true
        
    }

}
