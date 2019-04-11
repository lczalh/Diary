//
//  MovieDetailsTableHeaderView.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/4/10.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class MovieDetailsTableHeaderView: UITableViewHeaderFooterView {
    
    /// 标题
    var titleLabel: UILabel!
    
    /// 简介
    var synopsisButton: UIButton!
    
    /// 其它信息
    var otherInformationLabel: UILabel!
    
    /// 底部分割线
    var bottonLineView: UIView!
    
    var collectionView: UICollectionView!
    
    

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = UIColor.white
        
        titleLabel = UILabel()
        self.contentView.addSubview(titleLabel!)
        titleLabel.snp.makeConstraints({ (make) in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(10);
        })
        titleLabel.font = LCZBoldFontSize(size: 18)
        
        synopsisButton = UIButton(type: .custom)
        self.contentView.addSubview(synopsisButton!)
        synopsisButton.snp.makeConstraints({ (make) in
            make.right.equalToSuperview().offset(-10);
            make.top.equalToSuperview().offset(10);
        })
        synopsisButton?.setTitleColor(UIColor.black, for: .normal)
        synopsisButton?.titleLabel?.font = LCZFontSize(size: 12)
        synopsisButton?.setTitleColor(LCZHexadecimalColor(hexadecimal: "#707070"), for: .normal)
        synopsisButton?.set(image: UIImage(named: "synopsisBottonImage"), title: "简介", titlePosition: .left, additionalSpacing: 5, state: .selected)
        synopsisButton?.set(image: UIImage(named: "synopsisTopImage"), title: "简介", titlePosition: .left, additionalSpacing: 5, state: .normal)
        synopsisButton?.isHidden = true
        
        otherInformationLabel = UILabel()
        self.contentView.addSubview(otherInformationLabel)
        otherInformationLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.right.equalToSuperview().offset(-10)
        }
        otherInformationLabel.textAlignment = .left
        otherInformationLabel.font = LCZFontSize(size: 12)
        otherInformationLabel.textColor = LCZRgbColor(92, 92, 92, 1)
        
        bottonLineView = UIView()
        self.contentView.addSubview(bottonLineView)
        bottonLineView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
        bottonLineView.backgroundColor = LCZRgbColor(244, 244, 244, 1)
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 50, height: 30)
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 50, width: LCZWidth, height: 40), collectionViewLayout: layout)
        self.contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(otherInformationLabel.snp.bottom).offset(5)
            make.bottom.equalTo(bottonLineView.snp.top).offset(-5)
        }
        collectionView.backgroundColor = UIColor.red
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        collectionView.isHidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
