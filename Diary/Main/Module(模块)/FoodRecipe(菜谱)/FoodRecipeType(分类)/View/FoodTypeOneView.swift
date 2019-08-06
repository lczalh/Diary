//
//  FoodTypeOneView.swift
//  Diary
//
//  Created by linphone on 2019/7/29.
//  Copyright © 2019 lcz. All rights reserved.
// 分类一级标签

import UIKit

class FoodTypeOneView: DiaryBaseView {
    
    public var newCollectionView:UICollectionView!
    

    override func configUI() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width:100, height: 55)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        newCollectionView = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        self.addSubview(newCollectionView);
        newCollectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
       
        newCollectionView.showsVerticalScrollIndicator = false
        newCollectionView.bounces = false
        newCollectionView.backgroundColor = UIColor(valueRGB: 0xF6F6F6)
        
        newCollectionView.register(FoodTypeOneCollectionViewCell.self, forCellWithReuseIdentifier: FoodTypeOneCollectionViewCell.cellIdentifier)
    }
        
}
