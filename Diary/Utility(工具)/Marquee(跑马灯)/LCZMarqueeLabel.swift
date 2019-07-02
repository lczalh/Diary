//
//  LCZMarquee.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/7/2.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class LCZMarqueeLabel: UILabel {
    
    init(location: CGPoint, text: String, duration: CFTimeInterval, rollingWidth: CGFloat = UIScreen.main.bounds.size.width) {
        let size = (text as NSString).textSizeWithFont(font: LCZFontSize(size: 16), constrainedToSize: CGSize(width: 100000, height: 100000))
        super.init(frame: CGRect(origin: location, size: size))
        self.text = text
        let positionAnimation = CABasicAnimation(keyPath: "position.x")
        positionAnimation.duration = duration
        positionAnimation.fromValue = (-(size.width / 2))
        positionAnimation.toValue = (rollingWidth + (size.width / 2))
        // 不停重复
        positionAnimation.repeatCount = .greatestFiniteMagnitude
        // 防止动画结束后回到初始状态
        positionAnimation.isRemovedOnCompletion = false
        positionAnimation.fillMode = CAMediaTimingFillMode.forwards;
        self.layer.add(positionAnimation, forKey: "position.x")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
