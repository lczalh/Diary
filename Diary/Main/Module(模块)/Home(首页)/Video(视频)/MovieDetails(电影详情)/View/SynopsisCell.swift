//
//  SynopsisCell.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/4/10.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class SynopsisCell: DiaryBaseTableViewCell {
    
    /// 导演
    var directorLabel: UILabel!
    
    /// 主演
    var actorLabel: UILabel!
    
    /// 简介
    var synopsisLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func config() {
        directorLabel = UILabel()
        self.contentView.addSubview(directorLabel)
        directorLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(10)
        }
        directorLabel.font = LCZPublicHelper.shared.getConventionFont(size: 14)
        directorLabel.textColor = LCZPublicHelper.shared.getRgbColor(160, 160, 160, 1)
        directorLabel.setContentHuggingPriority(.required, for: .horizontal)
        directorLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        actorLabel = UILabel()
        self.contentView.addSubview(actorLabel)
        actorLabel.snp.makeConstraints { (make) in
            make.left.equalTo(directorLabel.snp.right).offset(50)
            make.top.equalTo(directorLabel)
            make.right.equalToSuperview().offset(-10)
        }
        actorLabel.textColor = LCZPublicHelper.shared.getRgbColor(160, 160, 160, 1)
        actorLabel.font = LCZPublicHelper.shared.getConventionFont(size: 14)
        actorLabel.textAlignment = .left
        
        synopsisLabel = UILabel()
        self.contentView.addSubview(synopsisLabel)
        synopsisLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.top.equalTo(directorLabel.snp.bottom).offset(10);
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-10)
        }
        synopsisLabel.textColor = LCZPublicHelper.shared.getRgbColor(160, 160, 160, 1)
        synopsisLabel.font = LCZPublicHelper.shared.getConventionFont(size: 14)
        synopsisLabel.textAlignment = .left
        synopsisLabel.numberOfLines = 0
    }

}
