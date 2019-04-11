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
    var episodeDelegate: EpisodeCellDelegate!
    
    
    /// 所有剧集地址
    public var movieUrls: Array<URL> = Array()

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
        layout.itemSize = CGSize(width: 50, height: 50)
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        self.contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
            make.left.right.equalToSuperview()
            make.height.equalTo(70)
        }
        
        collectionView.backgroundColor = UIColor.white
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        collectionView.register(SelectorEpisodeCell.self, forCellWithReuseIdentifier: "SelectorEpisodeCell")
        collectionView.dataSource = self;
        collectionView.delegate = self;
        
        //创建数据源
//        let dataSource = RxCollectionViewSectionedReloadDataSource<SectionModel<String, URL>>(
//            configureCell: { (dataSource, collectionView, indexPath, element) in
//                let selectorCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectorEpisodeCell",
//                                                                      for: indexPath) as! SelectorEpisodeCell
//                selectorCell.episodeLabel.text = "\(indexPath.row + 1)"
////                if self.playerIndexs[indexPath.row] == "0" { // 未播放
////                    selectorCell.episodeLabel.textColor = UIColor.black
////                } else { // 播放中
////                    selectorCell.episodeLabel.textColor = LCZRgbColor(34, 123, 255, 1)
////                }
//                return selectorCell
//
//        }
//        )
        
        //绑定单元格数据
//        movieUrlSections!
//            .bind(to: collectionView.rx.items(dataSource: dataSource))
//            .disposed(by: rx.disposeBag)
//
//        // 同时获取索引和模型
//        Observable.zip(collectionView.rx.itemSelected, collectionView.rx.modelSelected(URL.self))
//            .bind { indexPath, item in
                // 设置播放状态
//                for (index, _) in self.playerIndexs.enumerated() {
//                    if index == indexPath.row {
//                        self.playerIndexs[index] = "1"
//                    } else {
//                        self.playerIndexs[index] = "0"
//                    }
//                }
//
//                // 获取集数cell
//                let cell = self.movieDetailsView.tableView.cellForRow(at: IndexPath(row: 0, section: 1)) as! EpisodeCell
//                cell.collectionView.reloadData()
//
//                // 播放当前选中的集数
//                self.movieDetailsView.playerController.playTheIndex(indexPath.row)
//                self.movieDetailsView.controlView.showTitle(self.movieHomeModel.vod_name, coverURLString: self.movieHomeModel.vod_pic, fullScreenMode: .landscape)
//            }.disposed(by: rx.disposeBag)
    
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
