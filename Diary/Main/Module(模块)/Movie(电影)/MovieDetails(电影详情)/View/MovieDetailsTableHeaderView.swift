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
    var titleLabel: UILabel?
    
    /// 简介
    var synopsisButton: UIButton?
    

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = UIColor.white
        
        titleLabel = UILabel()
        self.contentView.addSubview(titleLabel!)
        titleLabel?.snp.makeConstraints({ (make) in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(10);
        })
        titleLabel?.font = LCZBoldFontSize(size: 18)
        
        synopsisButton = UIButton(type: .custom)
        self.contentView.addSubview(synopsisButton!)
        synopsisButton?.snp.makeConstraints({ (make) in
            make.right.equalToSuperview().offset(-10);
            make.top.equalToSuperview().offset(10);
        })
        synopsisButton?.setTitleColor(UIColor.black, for: .normal)
        synopsisButton?.titleLabel?.font = LCZFontSize(size: 12)
        synopsisButton?.setTitleColor(LCZHexadecimalColor(hexadecimal: "#707070"), for: .normal)
        synopsisButton?.set(image: UIImage(named: "synopsisBottonImage"), title: "简介", titlePosition: .left, additionalSpacing: 5, state: .selected)
        synopsisButton?.set(image: UIImage(named: "synopsisTopImage"), title: "简介", titlePosition: .left, additionalSpacing: 5, state: .normal)
     //   synopsisButton?.imageView?.tintColor = LCZHexadecimalColor(hexadecimal: "#707070")
        synopsisButton?.isHidden = true
       // synopsisButton?.imageView?.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
