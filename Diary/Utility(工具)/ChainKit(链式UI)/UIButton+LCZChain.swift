//
//  UIButton+LCZChain.swift
//  Diary
//
//  Created by glgl on 2019/8/7.
//  Copyright © 2019 lcz. All rights reserved.
//

public extension LCZChain where Base: UIButton {
    
    @discardableResult
    func title(_ title: String?, _ state: UIControl.State) -> LCZChain {
        base.setTitle(title, for: state)
        return self
    }
    
    @discardableResult
    func titleColor(_ color: UIColor?, _ state: UIControl.State) -> LCZChain {
        base.setTitleColor(color, for: state)
        return self
    }
    
    @discardableResult
    func image(_ image: UIImage?, _ state: UIControl.State) -> LCZChain {
        base.setImage(image, for: state)
        return self
    }
    
    @discardableResult
    func backgroundImage(_ image: UIImage?, _ state: UIControl.State) -> LCZChain {
        base.setBackgroundImage(image, for: state)
        return self
    }
    
    @discardableResult
    func frame(_ frame: CGRect) -> LCZChain {
        base.frame = frame
        return self
    }
    
    @discardableResult
    func addSubview(_ view: UIView) -> LCZChain {
        view.addSubview(base)
        return self
    }
    
    @discardableResult
    func attributedTitle(_ title: NSAttributedString?, _ state: UIControl.State) -> LCZChain {
        base.setAttributedTitle(title, for: state)
        return self
    }
    
    @discardableResult
    func addTarget(_ target: Any?, _ action: Selector, _ event: UIControl.Event) -> LCZChain {
        base.addTarget(target, action: action, for: event)
        return self
    }
    
    @discardableResult
    func font(_ font: UIFont) -> LCZChain {
        base.titleLabel?.font = font
        return self
    }

    @discardableResult
    func titleEdgeInsets(_ edgeInsets: UIEdgeInsets) -> LCZChain {
        base.titleEdgeInsets = edgeInsets
        return self
    }
    
    @discardableResult
    func imageEdgeInsets(_ edgeInsets: UIEdgeInsets) -> LCZChain {
        base.imageEdgeInsets = edgeInsets
        return self
    }
    
    @discardableResult
    func isHidden(_ hidden: Bool) -> LCZChain {
        base.isHidden = hidden
        return self
    }
    
    @discardableResult
    func isEnabled(_ enabled: Bool) -> LCZChain {
        base.isEnabled = enabled
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
    func backgroundColor(_ color: UIColor) -> LCZChain {
        base.backgroundColor = color
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
    func center(_ center: CGPoint) -> LCZChain {
        base.center = center
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
    func isSelected(_ isSelected: Bool) -> LCZChain {
        base.isSelected = isSelected
        return self
    }
}
