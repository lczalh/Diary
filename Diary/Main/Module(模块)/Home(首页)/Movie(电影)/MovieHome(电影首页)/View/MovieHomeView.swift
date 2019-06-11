//
//  MovieHomeView.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/3/20.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class MovieHomeView: DiaryBaseView {
    
    var collectionView: UICollectionView!
    

    override func configUI() {
        self.createCollectionView()
    }
    
    /// 创建CollectionView
    private func createCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: LCZSafeAreaBottomHeight, right: 10)
        layout.itemSize = CGSize(width: (LCZWidth - 30) / 3 , height: 180 * LCZSizeScale)
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        self.addSubview(collectionView)
    
        collectionView.backgroundColor = LCZRgbColor(238, 238, 238, 1)
        collectionView.register(MovieHomeCell.self, forCellWithReuseIdentifier: "MovieHomeCell")
        collectionView.mj_header = MJRefreshNormalHeader()
        collectionView.mj_footer = MJRefreshBackNormalFooter()
        
    }
}
