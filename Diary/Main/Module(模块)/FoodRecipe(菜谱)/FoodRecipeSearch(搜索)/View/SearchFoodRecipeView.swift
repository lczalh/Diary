//
//  SearchFoodRecipeView.swift
//  Diary
//
//  Created by linphone on 2019/7/31.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class SearchFoodRecipeView: DiaryBaseView {
    
    var newCollectionView:UICollectionView!

    override func configUI() {
        self.backgroundColor = UIColor(valueRGB: 0xF8F9FB)
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        newCollectionView = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        self.addSubview(newCollectionView);
        newCollectionView.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(7)
            make.right.equalToSuperview().offset(-7)
        }
        
        newCollectionView.showsVerticalScrollIndicator = false
        newCollectionView.bounces = false
        newCollectionView.backgroundColor = UIColor.clear
        newCollectionView.register(FoodRecipeListCollectionViewCell.self, forCellWithReuseIdentifier: FoodRecipeListCollectionViewCell.cellIdentifier)
    }

}
