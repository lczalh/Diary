//
//  MineEntranceTableViewCell.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/6/11.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class MineEntranceTableViewCell: DiaryBaseTableViewCell {
    
    /// 标题
    public var titleLabel: UILabel!
    
    /// 图标
    public var logoImageView: UIImageView!
    
    /// 右箭头
    private var rightImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func config() {
        logoImageView = UIImageView()
        self.contentView.addSubview(logoImageView)
        logoImageView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.centerY.equalToSuperview()
        }
        logoImageView.contentMode = .scaleAspectFit
        
        titleLabel = UILabel()
        self.contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(logoImageView.snp.right).offset(10)
            make.centerY.equalTo(logoImageView)
        }
        titleLabel.font = LCZFontSize(size: 14)
        titleLabel.textColor = LCZHexadecimalColor(hexadecimal: AppContentColor)
        
        rightImageView = UIImageView()
        self.contentView.addSubview(rightImageView)
        rightImageView.image = UIImage(named: "rightArrow")
        rightImageView.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-15)
            make.centerY.equalTo(titleLabel)
        }
    }

}
