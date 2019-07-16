//
//  TelevisionView.swift
//  Diary
//
//  Created by glgl on 2019/7/16.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class TelevisionView: DiaryBaseView {
    
    public lazy var collectionView: UICollectionView! = {
        let layout = TelevisionLayout()
        let view = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        view.register(TelevisionCollectionViewCell.self, forCellWithReuseIdentifier: "TelevisionCollectionViewCell")
        view.register(NewsMovieHomeCollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "NewsMovieHomeCollectionHeaderView")
        return view
    }()

    override func configUI() {
        self.addSubview(collectionView)
    }

}
