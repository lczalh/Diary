//
//  UILabel+LCZChain.swift
//  Diary
//
//  Created by glgl on 2019/8/7.
//  Copyright © 2019 lcz. All rights reserved.
//

public extension LCZChain where Base: UILabel {
    
    @discardableResult
    func text(_ text: String?) -> LCZChain {
        base.text = text
        return self
    }
    
    @discardableResult
    func textColor(_ color: UIColor) -> LCZChain {
        base.textColor = color
        return self
    }
    
    @discardableResult
    func textAlignment(_ alignment: NSTextAlignment) -> LCZChain {
        base.textAlignment = alignment
        return self
    }
    
    @discardableResult
    func font(_ font: UIFont) -> LCZChain {
        base.font = font
        return self
    }
    
    @discardableResult
    func attributedText(_ text: NSAttributedString?) -> LCZChain {
        base.attributedText = text
        return self
    }
    
    @discardableResult
    func numberOfLines(_ number: Int) -> LCZChain {
        base.numberOfLines = number
        return self
    }
    
    @discardableResult
    func lineBreakMode(_ mode: NSLineBreakMode) -> LCZChain {
        base.lineBreakMode = mode
        return self
    }
    
    @discardableResult
    func adjustsFontSizeToFitWidth(_ adjustsFontSizeToFitWidth: Bool) -> LCZChain {
        base.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth
        return self
    }
    
    @discardableResult
    func isEnabled(_ isEnabled: Bool) -> LCZChain {
        base.isEnabled = isEnabled
        return self
    }
}
