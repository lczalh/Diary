//
//  SearchMovieCell.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/5/7.
//  Copyright © 2019 lcz. All rights reserved.
//

import Foundation

class SearchMovieCell: DiaryBaseTableViewCell {
    
    /// 图片
    var movieImageView: UIImageView!
    
    /// 标题
    var titleLabel: UILabel!
    
    /// 详情
    var detailsLabel: LCZAlignTopLabel!
    
    
    override func config() {
        self.isSkeletonable = true
        movieImageView = UIImageView()
        self.contentView.addSubview(movieImageView)
        movieImageView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.centerY.equalToSuperview()
            make.height.equalTo(100)
            make.width.equalTo(80)
        }
        movieImageView.layer.cornerRadius = 5
        movieImageView.clipsToBounds = true
        movieImageView.contentMode = .scaleAspectFill
        movieImageView.setContentHuggingPriority(.required, for: .horizontal)
        movieImageView.setContentCompressionResistancePriority(.required, for: .horizontal)
        movieImageView.isSkeletonable = true
        
        titleLabel = UILabel()
        self.contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(movieImageView.snp.right).offset(5)
            make.top.equalTo(movieImageView.snp.top)
            make.right.equalToSuperview().offset(-15)
        }
        titleLabel.font = cz_BoldFont(size: 16)
        titleLabel.setContentHuggingPriority(.required, for: .vertical)
        titleLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        titleLabel.text = "xxxxxxxxx"
        titleLabel.isSkeletonable = true
        titleLabel.textAlignment = .left
        
        detailsLabel = LCZAlignTopLabel()
        self.contentView.addSubview(detailsLabel)
        detailsLabel.snp.makeConstraints { (make) in
            make.left.equalTo(movieImageView.snp.right).offset(5)
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.right.equalToSuperview().offset(-15)
            make.bottom.equalTo(movieImageView.snp.bottom)
        }
        detailsLabel.font = cz_ConventionFont(size: 14)
        detailsLabel.numberOfLines = 0;
        detailsLabel.textColor = cz_RgbColor(160, 160, 160, 1)
        detailsLabel.isSkeletonable = true
        detailsLabel.textAlignment = .left
    }
    
}
