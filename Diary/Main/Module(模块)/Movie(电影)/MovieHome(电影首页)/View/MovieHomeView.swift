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
        layout.itemSize = CGSize(width: (LCZWidth - 33) / 4 , height: 100)
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView.contentInset = UIEdgeInsets(top: 15, left: 15, bottom: 0, right: 15)
        self.addSubview(collectionView)
        collectionView.backgroundColor = LCZRgbColor(238, 238, 238, 1)
        collectionView.register(MovieHomeCell.self, forCellWithReuseIdentifier: "MovieHomeCell")
        
    }
}
