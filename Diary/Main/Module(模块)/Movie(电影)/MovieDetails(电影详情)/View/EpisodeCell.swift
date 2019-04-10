//
//  EpisodeCell.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/4/10.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class EpisodeCell: DiaryBaseTableViewCell {
    
    var collectionView: UICollectionView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func config() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 60, height: 60)
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: LCZWidth, height: 80), collectionViewLayout: layout)
        self.contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalToSuperview()
            make.height.equalTo(80)
        }
        collectionView.contentSize = CGSize(width: LCZWidth*3, height: 80)
        collectionView.register(SelectorEpisodeCell.self, forCellWithReuseIdentifier: "SelectorEpisodeCell")
    
    }

}
