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
    /// - Parameter viewController: 指定父控制器类型
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
    /// - Parameter superView: 指定父视图类型
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
    
//    public func LCZGetSubViews<T: UIView>(subView: T.Type) -> T? {
//        let views = self.subviews
//        if views.count == 0 {
//            return nil
//        }
//        for view in views {
//            LCZPrint(view)
//            if view.isKind(of: T.self) == true {
//                return view as? T
//            }
//        }
//        return nil
//    }
}
