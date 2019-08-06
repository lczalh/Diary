//
//  ClearCacheTableViewCell.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/6/21.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class ClearCacheTableViewCell: DiaryBaseTableViewCell {
    
    /// 标题
    public var titleLabel: UILabel!
    
    /// 缓存大小
    public var cacheSizeLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func config() {
        titleLabel = UILabel()
        self.contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.centerY.equalToSuperview()
        }
        titleLabel.font = LCZPublicHelper.shared.getConventionFont(size: 14)
        titleLabel.textColor = LCZPublicHelper.shared.getHexadecimalColor(hexadecimal: AppContentColor)
        
        cacheSizeLabel = UILabel()
        self.contentView.addSubview(cacheSizeLabel)
        cacheSizeLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-15)
            make.centerY.equalToSuperview()
        }
        cacheSizeLabel.font = LCZPublicHelper.shared.getConventionFont(size: 16)
    }
}
