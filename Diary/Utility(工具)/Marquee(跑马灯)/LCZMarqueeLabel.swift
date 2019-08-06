//
//  LCZMarquee.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/7/2.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class LCZMarqueeLabel: UILabel {
    
    /// 初始化MarqueeLabel
    ///
    /// - Parameters:
    ///   - location: 需要在哪个位置显示
    ///   - text: 显示的内容
    ///   - font: font
    ///   - duration: 动画时长
    ///   - rollingWidth: 控件的活动范围
    init(location: CGPoint,
         text: String,
         font: UIFont = UIFont.systemFont(ofSize: UIScreen.main.bounds.width / 375.0 * 16),
         duration: CFTimeInterval = 20,
         rollingWidth: CGFloat = UIScreen.main.bounds.size.width) {
        // 计算文本大小
        let size = LCZMarqueeLabel.textSizeWithFont(text: (text as NSString),font: font, constrainedToSize: CGSize(width: 100000, height: 100000))
        super.init(frame: CGRect(origin: location, size: size))
        self.text = text
        self.font = font
        let positionAnimation = CABasicAnimation(keyPath: "position.x")
        // 动画时长
        positionAnimation.duration = duration
        // 初始位置
        positionAnimation.fromValue = (rollingWidth + (size.width / 2))
        // 结束位置
        positionAnimation.toValue = (-(size.width / 2))
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
    
    /**
     //根据文字多少大小计算UILabel的宽高度
     
     - parameter font: UILabel大小
     - parameter size: UILabel的最大宽高
     
     - returns: 当前文本所占的宽高
     */
    private class func textSizeWithFont(text: NSString, font: UIFont, constrainedToSize size:CGSize) -> CGSize {
        var textSize:CGSize
        if __CGSizeEqualToSize(size,CGSize.zero){
            let attributes = NSDictionary(object: font, forKey: NSAttributedString.Key.font as NSCopying)
            textSize = text.size(withAttributes:attributes as? [NSAttributedString.Key : Any])
        }else{
            let attributes = NSDictionary(object: font, forKey: NSAttributedString.Key.font as NSCopying)
            let stringRect = text.boundingRect(with:size, options:NSStringDrawingOptions.usesLineFragmentOrigin, attributes:attributes as? [NSAttributedString.Key : Any], context: nil)
            textSize = stringRect.size
        }
        return textSize
    }
    
}
