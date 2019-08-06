//
//  TelevisionListView.swift
//  Diary
//
//  Created by glgl on 2019/7/17.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class TelevisionListView: DiaryBaseView {
    
    public var collectionView: UICollectionView!

    override func configUI() {
        createCollectionView()
    }
    
    /// 创建CollectionView
    private func createCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (LCZPublicHelper.shared.getScreenWidth! - 2) / 2 , height: 150 * LCZPublicHelper.shared.getScreenSizeScale)
        layout.minimumInteritemSpacing = 2
        layout.minimumLineSpacing = 0
        collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        self.addSubview(collectionView)
        collectionView.register(NewsMovieCollectionViewCell.self, forCellWithReuseIdentifier: "NewsMovieCollectionViewCell")
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: LCZPublicHelper.shared.getTabbarHeight! + LCZPublicHelper.shared.getSafeAreaBottomHeight, right: 0)
        collectionView.backgroundColor = UIColor.clear
        collectionView.isSkeletonable = true
        collectionView.lcz_isUseComponent = true
    }
}

// MARK: - JXCategoryListContentViewDelegate
extension TelevisionListView: JXCategoryListContentViewDelegate{
    
    func listView() -> UIView! {
        return self;
    }
}
