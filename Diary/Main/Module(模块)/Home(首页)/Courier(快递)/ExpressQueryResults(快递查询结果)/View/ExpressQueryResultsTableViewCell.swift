//
//  ExpressQueryResultsTableViewCell.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/6/13.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class ExpressQueryResultsTableViewCell: DiaryBaseTableViewCell {
    
    /// 物流详情
    public var logisticsDetailsLabel: UILabel!
    
    /// 时间
    public var timeLabel: UILabel!
    
    /// 状态图标
    public var stateImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override var frame: CGRect {
        get {
            return super.frame
        }
        set {
            var frame = newValue
            frame.origin.x += 15
            frame.size.width -= 2 * 15
            super.frame = frame
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func config() {
        stateImageView = UIImageView()
        self.contentView.addSubview(stateImageView)
        stateImageView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.centerY.equalToSuperview()
        }
        stateImageView.contentMode = .scaleAspectFit
        self.stateImageView.setContentHuggingPriority(.required, for: .horizontal)
        self.stateImageView.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        logisticsDetailsLabel = UILabel()
        self.contentView.addSubview(logisticsDetailsLabel)
        logisticsDetailsLabel.snp.makeConstraints { (make) in
            make.left.equalTo(stateImageView.snp.right).offset(10)
            make.top.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
        }
        logisticsDetailsLabel.numberOfLines = 0
        logisticsDetailsLabel.lineBreakMode = .byCharWrapping
        logisticsDetailsLabel.textAlignment = .left
        logisticsDetailsLabel.font = LCZFontSize(size: 14)
        
        timeLabel = UILabel()
        self.contentView.addSubview(timeLabel)
        timeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(logisticsDetailsLabel)
            make.top.equalTo(logisticsDetailsLabel.snp.bottom).offset(5)
            make.bottom.equalToSuperview().offset(-15)
        }
        timeLabel.font = LCZFontSize(size: 12)
        timeLabel.textColor = LCZRgbColor(175, 173, 175, 1)
        self.timeLabel.setContentHuggingPriority(.required, for: .vertical)
        self.timeLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        
    }

}
