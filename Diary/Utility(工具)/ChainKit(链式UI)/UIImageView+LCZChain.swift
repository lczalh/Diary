//
//  UIImageView+LCZChain.swift
//  Diary
//
//  Created by glgl on 2019/8/7.
//  Copyright © 2019 lcz. All rights reserved.
//

public extension LCZChain where Base: UIImageView {
    
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
    func contentMode(_ mode: UIView.ContentMode) -> LCZChain {
        base.contentMode = mode
        return self
    }
    
    
}
