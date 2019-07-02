//
//  LCZMarquee.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/7/2.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class LCZMarquee: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        let positionAnimation = CABasicAnimation(keyPath: "position.x")
        positionAnimation.duration = 10.0;
        positionAnimation.fromValue = (-10);
        positionAnimation.toValue = (LCZWidth / 2.0);
        self.layer.add(positionAnimation, forKey: "position.x")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
