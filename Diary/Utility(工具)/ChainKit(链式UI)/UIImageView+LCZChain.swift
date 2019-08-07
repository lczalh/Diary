//
//  UIImageView+LCZChain.swift
//  Diary
//
//  Created by glgl on 2019/8/7.
//  Copyright © 2019 lcz. All rights reserved.
//

public extension LCZChain where Base: UIImageView {
    
    @discardableResult
    func snpMakeConstraints(_ constraintMaker: (ConstraintMaker) -> Void) -> LCZChain {
        base.snp.makeConstraints { (make) in
            constraintMaker(make)
        }
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
    func image(_ image: UIImage) -> LCZChain {
        base.image = image
        return self
    }
    
    @discardableResult
    func isUserInteractionEnabled(_ enabled: Bool) -> LCZChain {
        base.isUserInteractionEnabled = enabled
        return self
    }
    
    @discardableResult
    func frame(_ frame: CGRect) -> LCZChain {
        base.frame = frame
        return self
    }
    
    @discardableResult
    func contentMode(_ mode: UIView.ContentMode) -> LCZChain {
        base.contentMode = mode
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
}
