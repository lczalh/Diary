//
//  LCZUIViewExtension.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/7/2.
//  Copyright © 2019 lcz. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    /// 获取指定父控制器
    ///
    /// - Parameter viewController: 查找的父控制器类型
    /// - Returns: 父控制器
    public func LCZGetSuperViewController<T: UIViewController>(viewController: T.Type) -> T? {
        var view: UIView = self.superview!
        while view.next!.isKind(of: T.self) != true {
            guard view.superview != nil else {
                return nil
            }
            view = view.superview!
        }
        return view.next as? T
    }
    
    /// 获取指定父视图
    ///
    /// - Parameter superView: 查找的父视图类型
    /// - Returns: 父视图
    public func LCZGetSuperView<T: UIView>(superView: T.Type) -> T? {
        var view: UIView = self.superview!
        while view.isKind(of: T.self) != true {
            guard view.superview != nil else {
                return nil
            }
            view = view.superview!
        }
        return view as? T
    }
    
    /// 获取指定子视图
    ///
    /// - Parameter subView: 查找的子视图类型
    /// - Returns: 子视图
    public func LCZGetSubViews<T: UIView>(subView: T.Type) -> T? {
        return LCZGetView(currenView: self, superView: T.self)
    }
    private func LCZGetView<T: UIView>(currenView: UIView, superView: T.Type) -> T? {
        // 遍历子视图
        for view in currenView.subviews {
            if view.isKind(of: T.self) == true {
                return view as? T
            } else {
                // 递归查询
                let v = LCZGetView(currenView: view, superView: T.self)
                if v != nil {
                    return v
                }
            }
        }
        return nil
    }
   
}
