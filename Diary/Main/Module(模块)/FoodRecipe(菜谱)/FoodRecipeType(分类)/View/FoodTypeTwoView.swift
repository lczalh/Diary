//
//  FoodTypeTwoView.swift
//  Diary
//
//  Created by linphone on 2019/7/30.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class FoodTypeTwoView: DiaryBaseView {
    
    public var newCollectionView:UICollectionView!
    
    override func configUI() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width:(LCZPublicHelper.shared.getScreenWidth!-100)/3 - 15, height:30)
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        newCollectionView = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        self.addSubview(newCollectionView);
        newCollectionView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.right.bottom.equalToSuperview().offset(-10)
            make.top.equalToSuperview()
        }
        newCollectionView.showsVerticalScrollIndicator = false
        newCollectionView.bounces = false
        newCollectionView.backgroundColor = UIColor(valueRGB: 0xFFFFFF)
        
        newCollectionView.register(FoodTypeTwoCollectionViewCell.self, forCellWithReuseIdentifier: FoodTypeTwoCollectionViewCell.cellIdentifier)
    }
    
}
