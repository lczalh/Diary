//
//  SelectorEpisodeCell.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/4/10.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class SelectorEpisodeCell: DiaryBaseCollectionViewCell {
    
    /// 集数
    var episodeLabel: UILabel!

    override func config() {
        self.contentView.backgroundColor = LCZPublicHelper.shared.getRgbColor(243, 242, 243, 1)
        
        episodeLabel = UILabel()
        self.contentView.addSubview(episodeLabel)
        episodeLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        episodeLabel.textAlignment = .center
        episodeLabel.font = LCZPublicHelper.shared.getConventionFont(size: 16)
    }
}
