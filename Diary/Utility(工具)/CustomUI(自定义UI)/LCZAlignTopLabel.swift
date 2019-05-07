//
//  LCZAlignTopLabel.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/5/7.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class LCZAlignTopLabel: UILabel {

    override func drawText(in rect: CGRect) {
        var textRect = super.textRect(forBounds: bounds, limitedToNumberOfLines: numberOfLines)
        textRect.origin.y = bounds.origin.y
        super.drawText(in: textRect)
    }

}
