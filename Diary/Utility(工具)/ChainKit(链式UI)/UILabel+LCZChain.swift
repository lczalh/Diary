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
    func snpMakeConstraints(_ constraintMaker: (ConstraintMaker) -> Void) -> LCZChain {
        base.snp.makeConstraints { (make) in
            constraintMaker(make)
        }
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
    func addSubview(_ view: UIView) -> LCZChain {
        view.addSubview(base)
        return self
    }
    
    @discardableResult
    func addGestureRecognizer(_ gestureRecognizer: UIGestureRecognizer) -> LCZChain {
        base.addGestureRecognizer(gestureRecognizer)
        return self
    }
    
    @discardableResult
    func numberOfLines(_ number: Int) -> LCZChain {
        base.numberOfLines = number
        return self
    }
    
    @discardableResult
    func isHidden(_ hidden: Bool) -> LCZChain {
        base.isHidden = hidden
        return self
    }
    
    @discardableResult
    func roundedCorners(_ byRoundingCorners: UIRectCorner, _ cornerRadii: CGSize) -> LCZChain {
        base.layoutIfNeeded()
        let bezierPath = UIBezierPath(roundedRect: base.bounds, byRoundingCorners: byRoundingCorners, cornerRadii: cornerRadii)
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = base.bounds
        shapeLayer.path = bezierPath.cgPath
        base.layer.mask = shapeLayer
        return self
    }
    
    @discardableResult
    func lineBreakMode(_ mode: NSLineBreakMode) -> LCZChain {
        base.lineBreakMode = mode
        return self
    }
    
    @discardableResult
    func frame(_ frame: CGRect) -> LCZChain {
        base.frame = frame
        return self
    }
    
    @discardableResult
    func center(_ center: CGPoint) -> LCZChain {
        base.center = center
        return self
    }
    
    @discardableResult
    func backgroundColor(_ color: UIColor) -> LCZChain {
        base.backgroundColor = color
        return self
    }
    
    @discardableResult
    func borderColor(_ color: UIColor?) -> LCZChain {
        base.borderColor = color
        return self
    }
    
    @discardableResult
    func borderWidth(_ width: CGFloat) -> LCZChain {
        base.borderWidth = width
        return self
    }
    
    @discardableResult
    func shadowColor(_ shadowColor: UIColor?) -> LCZChain {
        base.shadowColor = shadowColor
        return self
    }
    
    @discardableResult
    func shadowOffset(_ shadowOffset: CGSize) -> LCZChain {
        base.shadowOffset = shadowOffset
        return self
    }
    
    @discardableResult
    func adjustsFontSizeToFitWidth(_ adjustsFontSizeToFitWidth: Bool) -> LCZChain {
        base.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth
        return self
    }
}
