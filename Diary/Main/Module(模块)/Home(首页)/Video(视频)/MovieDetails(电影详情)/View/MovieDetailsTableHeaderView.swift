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
    
    /// 代理
    var movieDetailsTableHeaderViewDelegate: MovieDetailsTableHeaderViewCellDelegate! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = UIColor.white
        
        titleLabel = UILabel()
        self.contentView.addSubview(titleLabel!)
        titleLabel.snp.makeConstraints({ (make) in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(10);
        })
        titleLabel.font = cz_BoldFont(size: 18)
        
        synopsisButton = UIButton(type: .custom)
        self.contentView.addSubview(synopsisButton!)
        synopsisButton.snp.makeConstraints({ (make) in
            make.right.equalToSuperview().offset(-10);
            make.top.equalToSuperview().offset(10);
        })
        synopsisButton?.setTitleColor(UIColor.black, for: .normal)
        synopsisButton?.titleLabel?.font = cz_ConventionFont(size: 12)
        synopsisButton?.setTitleColor(cz_HexadecimalColor(hexadecimal: "#707070"), for: .normal)
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
        otherInformationLabel.font = cz_ConventionFont(size: 12)
        otherInformationLabel.textColor = cz_RgbColor(92, 92, 92, 1)
        
        bottonLineView = UIView()
        self.contentView.addSubview(bottonLineView)
        bottonLineView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
        bottonLineView.backgroundColor = cz_RgbColor(244, 244, 244, 1)
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (cz_ScreenWidth! - 20 - 50) / 6, height: 35 * cz_ScreenSizeScale)
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        self.contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(otherInformationLabel.snp.bottom).offset(5)
            make.bottom.equalToSuperview()
        }
        collectionView.backgroundColor = UIColor.white
        collectionView.contentInset = UIEdgeInsets(top: 5, left: 10, bottom: 0, right: 10)
        collectionView.isHidden = true
        collectionView.register(PracticalFunctionCell.self, forCellWithReuseIdentifier: "PracticalFunctionCell")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UICollectionViewDataSource
extension MovieDetailsTableHeaderView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movieDetailsTableHeaderViewDelegate.movieDetailsTableHeaderViewCollectionView(collectionView, numberOfItemsInSection: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return self.movieDetailsTableHeaderViewDelegate.movieDetailsTableHeaderViewCollectionView(collectionView, cellForItemAt: indexPath)
    }
    
    
}

// MARK: - UICollectionViewDelegate
extension MovieDetailsTableHeaderView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.movieDetailsTableHeaderViewDelegate.movieDetailsTableHeaderViewCollectionView(collectionView, didSelectItemAt: indexPath)
    }
}


/// MovieDetailsTableHeaderViewCellDelegate协议 中转 UICollectionViewDataSource & UICollectionViewDelegate 协议
protocol MovieDetailsTableHeaderViewCellDelegate {
    func movieDetailsTableHeaderViewCollectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    
    func movieDetailsTableHeaderViewCollectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    
    func movieDetailsTableHeaderViewCollectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
}
