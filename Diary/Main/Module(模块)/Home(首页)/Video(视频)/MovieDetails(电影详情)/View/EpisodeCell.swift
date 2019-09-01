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
    
    /// 协议
    var episodeDelegate: EpisodeCellDelegate! {
        didSet {
            collectionView.dataSource = self;
            collectionView.delegate = self;
        }
    }

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
        layout.itemSize = CGSize(width: 50 * cz_ScreenSizeScale, height: 50 * cz_ScreenSizeScale)
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        self.contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
            make.left.right.equalToSuperview()
            make.height.equalTo(70 * cz_ScreenSizeScale)
        }
        
        collectionView.backgroundColor = UIColor.white
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        collectionView.register(SelectorEpisodeCell.self, forCellWithReuseIdentifier: "SelectorEpisodeCell")
    
    }

}

// MARK: - UICollectionViewDataSource
extension EpisodeCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.episodeDelegate.episodeCollectionView(collectionView, numberOfItemsInSection: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return self.episodeDelegate.episodeCollectionView(collectionView, cellForItemAt: indexPath)
    }
}

// MARK: - UICollectionViewDelegate
extension EpisodeCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.episodeDelegate.episodeCollectionView(collectionView, didSelectItemAt: indexPath)
    }
}

/// EpisodeCellDelegatex协议 中转 UICollectionViewDataSource & UICollectionViewDelegate 协议
protocol EpisodeCellDelegate {
    func episodeCollectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    
    func episodeCollectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    
    func episodeCollectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
}
