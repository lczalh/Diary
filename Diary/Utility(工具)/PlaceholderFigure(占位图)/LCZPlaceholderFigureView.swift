//
//  LCZPlaceholderFigureView.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/7/11.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class LCZPlaceholderFigureView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let reloadButton = UIButton(type: .custom)
        self.addSubview(reloadButton)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
