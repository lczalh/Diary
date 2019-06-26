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
        createCollectionView()
    }
    
    /// 创建CollectionView
    private func createCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (LCZWidth - 2) / 2 , height: 150 * LCZSizeScale)
        layout.minimumInteritemSpacing = 2
        layout.minimumLineSpacing = 0
      //  layout.headerReferenceSize = CGSize(width: LCZWidth, height: 30)
        collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        self.addSubview(collectionView)
        collectionView.register(NewsMovieHomeCollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "NewsMovieHomeCollectionHeaderView")
        collectionView.register(NewsMovieHomeShufflingFigureCollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "NewsMovieHomeShufflingFigureCollectionHeaderView")
        collectionView.backgroundColor = UIColor.white
        collectionView.register(NewsMovieCollectionViewCell.self, forCellWithReuseIdentifier: "NewsMovieCollectionViewCell")
        collectionView.mj_header = MJRefreshNormalHeader()
        collectionView.mj_footer = MJRefreshBackNormalFooter()
       // collectionView.contentInset = UIEdgeInsets(top: 180, left: 0, bottom: 0, right: 0)
        
    }

}
