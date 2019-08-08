//
//  UIScrollView+LCZChain.swift
//  Diary
//
//  Created by glgl on 2019/8/8.
//  Copyright © 2019 lcz. All rights reserved.
//

public extension LCZChain where Base: UIScrollView {
    
    /// 设置滚动的范围
    @discardableResult
    func contentSize(_ contentSize: CGSize) -> LCZChain {
        base.contentSize = contentSize
        return self
    }
    
    /// 设置偏移量
    @discardableResult
    func contentOffset(_ contentOffset: CGPoint) -> LCZChain {
        base.contentOffset = contentOffset
        return self
    }
    
    @discardableResult
    func contentInset(_ contentInset: UIEdgeInsets) -> LCZChain {
        base.contentInset = contentInset
        return self
    }
    
    /// 边缘回弹动画
    @discardableResult
    func bounces(_ bounces: Bool) -> LCZChain {
        base.bounces = bounces
        return self
    }
    
    /// 垂直方向遇到边框是否显示回弹动画
    @discardableResult
    func alwaysBounceVertical(_ alwaysBounceVertical: Bool) -> LCZChain {
        base.alwaysBounceVertical = alwaysBounceVertical
        return self
    }
    
    /// 水平方向遇到边框是否显示回弹动画
    @discardableResult
    func alwaysBounceHorizontal(_ alwaysBounceHorizontal: Bool) -> LCZChain {
        base.alwaysBounceHorizontal = alwaysBounceHorizontal
        return self
    }
    
    /// 是否开启分页
    @discardableResult
    func isPagingEnabled(_ isPagingEnabled: Bool) -> LCZChain {
        base.isPagingEnabled = isPagingEnabled
        return self
    }
    
    /// 滚动视图能否滚动
    @discardableResult
    func isScrollEnabled(_ isScrollEnabled: Bool) -> LCZChain {
        base.isScrollEnabled = isScrollEnabled
        return self
    }
    
    /// 是否显示水平滚动指示器
    @discardableResult
    func showsHorizontalScrollIndicator(_ showsHorizontalScrollIndicator: Bool) -> LCZChain {
        base.showsHorizontalScrollIndicator = showsHorizontalScrollIndicator
        return self
    }
    
    /// 是否显示垂直滚动的指示器
    @discardableResult
    func showsVerticalScrollIndicator(_ showsVerticalScrollIndicator: Bool) -> LCZChain {
        base.showsVerticalScrollIndicator = showsVerticalScrollIndicator
        return self
    }
    
    /// 滚动指示器的边距
    @discardableResult
    func scrollIndicatorInsets(_ scrollIndicatorInsets: UIEdgeInsets) -> LCZChain {
        base.scrollIndicatorInsets = scrollIndicatorInsets
        return self
    }
    
    /// 滚动指示器的颜色
    @discardableResult
    func indicatorStyle(_ indicatorStyle: UIScrollView.IndicatorStyle) -> LCZChain {
        base.indicatorStyle = indicatorStyle
        return self
    }
    
    @discardableResult
    func scrollsToTop(_ scrollsToTop: Bool) -> LCZChain {
        base.scrollsToTop = scrollsToTop
        return self
    }
    
    @discardableResult
    func delegate(_ delegate: UIScrollViewDelegate?) -> LCZChain {
        base.delegate = delegate
        return self
    }
    
    /// 键盘消失模式
    @discardableResult
    func keyboardDismissMode(_ keyboardDismissMode: UIScrollView.KeyboardDismissMode) -> LCZChain {
        base.keyboardDismissMode = keyboardDismissMode
        return self
    }
    
    /// 视图最小缩放
    @discardableResult
    func minimumZoomScale(_ minimumZoomScale: CGFloat) -> LCZChain {
        base.minimumZoomScale = minimumZoomScale
        return self
    }
    
    /// 视图最小缩放
    @discardableResult
    func maximumZoomScale(_ maximumZoomScale: CGFloat) -> LCZChain {
        base.maximumZoomScale = maximumZoomScale
        return self
    }
    

}
