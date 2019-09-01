//
//  HistoryQueryTableViewCell.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/6/14.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class HistoryQueryTableViewCell: DiaryBaseTableViewCell {
    
    /// 左图标
    public var leftImageView: UIImageView!
    
    /// 记录
    public var titleLabel: UILabel!
    
    /// 删除按钮
    public var deleButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func config() {
        
        // 左图标
        leftImageView = UIImageView()
        self.contentView.addSubview(leftImageView)
        leftImageView.snp.makeConstraints { (make) in
            make.left.centerY.equalToSuperview()
        }
        leftImageView.image = UIImage(named: "shijian")
        
        // 标题
        titleLabel = UILabel()
        self.contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(leftImageView)
            make.left.equalTo(leftImageView.snp.right).offset(10)
        }
        titleLabel.font = cz_ConventionFont(size: 12)
       // titleLabel.text = "撒大方哇"
        titleLabel.textColor = cz_HexadecimalColor(hexadecimal: AppContentColor)
        // 删除按钮
        deleButton = UIButton(type: .custom)
        self.contentView.addSubview(deleButton)
        deleButton.snp.makeConstraints { (make) in
            make.right.centerY.equalToSuperview()
        }
        deleButton.setImage(UIImage(named: "shanchu"), for: .normal)
        
    }

}
