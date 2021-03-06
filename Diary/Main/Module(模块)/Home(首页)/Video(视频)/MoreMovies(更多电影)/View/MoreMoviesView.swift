//
//  MoreMoviesView.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/7/1.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class MoreMoviesView: DiaryBaseView {
    
    public var collectionView: UICollectionView!
    
    override func configUI() {
        self.isSkeletonable = true
        self.createCollectionView()
    }
    
    /// 创建CollectionView
    private func createCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
        layout.itemSize = CGSize(width: (cz_ScreenWidth! - 30) / 3 , height: 180 * cz_ScreenSizeScale)
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        self.addSubview(collectionView)
        collectionView.isSkeletonable = true
        collectionView.backgroundColor = cz_RgbColor(238, 238, 238, 1)
        collectionView.register(MovieHomeCell.self, forCellWithReuseIdentifier: "MovieHomeCell")
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: cz_SafeAreaBottomHeight, right: 0)
        collectionView.lcz_isUseComponent = true
    }
}
