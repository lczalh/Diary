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
    func isSelected(_ isSelected: Bool) -> LCZChain {
        base.isSelected = isSelected
        return self
    }
    
    @discardableResult
    func isEnabled(_ isEnabled: Bool) -> LCZChain {
        base.isEnabled = isEnabled
        return self
    }
}
