//
//  CZModuleMacro.swift
//  Diary
//
//  Created by 刘超正 on 2019/9/1.
//  Copyright © 2019 lcz. All rights reserved.
//

import Foundation

/// 设置导航条透明 须在viewWillAppear调用
public func cz_NavigationBarTransparency(navigationController: UINavigationController) {
    navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
    navigationController.navigationBar.shadowImage = UIImage()
}

/// 将透明导航条还原 须在viewWillDisappear调用
public func cz_RestoreTheTransparentNavigationBar(navigationController: UINavigationController) {
    navigationController.navigationBar.setBackgroundImage(nil, for: .default)
    navigationController.navigationBar.shadowImage = nil
}

/// 通过视图获取指定父控制器
///
/// - Parameter currentView: 当前视图
/// - Parameter seekViewController: 查找的父控制器类型
/// - Returns: 父控制器
public func cz_SuperViewController<T: UIViewController>(currentView: UIView, seekViewController: T.Type) -> T? {
    var view: UIView = currentView.superview!
    while view.next!.isKind(of: T.self) != true {
        guard view.superview != nil else {
            return nil
        }
        view = view.superview!
    }
    return view.next as? T
}

/// 通过视图获取指定父视图
///
/// - Parameter currentView: 当前视图
/// - Parameter seekSuperView: 查找的父视图类型
/// - Returns: 父视图
public func cz_SuperView<T: UIView>(currentView: UIView, seekSuperView: T.Type) -> T? {
    var view: UIView = currentView.superview!
    while view.isKind(of: T.self) != true {
        guard view.superview != nil else {
            return nil
        }
        view = view.superview!
    }
    return view as? T
}

/// 通过当前视图获取指定子视图
///
/// - Parameter subView: 查找的子视图类型
/// - Returns: 子视图
public func cz_SubView<T: UIView>(currentView: UIView, seekSubView: T.Type) -> T? {
    return cz_View(currenView: currentView, superView: T.self)
}
private func cz_View<T: UIView>(currenView: UIView, superView: T.Type) -> T? {
    // 遍历子视图
    for view in currenView.subviews {
        if view.isKind(of: T.self) == true {
            return view as? T
        } else {
            // 递归查询
            let v = cz_View(currenView: view, superView: T.self)
            if v != nil {
                return v
            }
        }
    }
    return nil
}

/// push方式 返回指定控制器
///
/// - Parameters:
///   - currentViewController: 当前所在控制器
///   - specifiedViewController: 待返回到的控制器类型
/// - Returns: 待返回到的控制器对象
public func cz_PushBackToTheSpecifiedController<T: UIViewController>(currentViewController: UIViewController, specifiedViewController: T.Type) -> T? {
    for vc in (currentViewController.navigationController?.viewControllers.reversed())! {
        if vc.isKind(of: T.self) {
            currentViewController.navigationController?.popToViewController(vc, animated: true)
            return (vc as! T)
        }
    }
    return nil
}

/// present方式 返回指定控制权
///
/// - Parameters:
///   - currentViewController: 当前所在控制器
///   - specifiedViewController: 待返回到的控制器类型
/// - Returns: 待返回到的控制器对象
public func cz_PresentBackToTheSpecifiedController<T: UIViewController>(currentViewController: UIViewController, specifiedViewController: T.Type) -> T? {
    var vc = currentViewController.presentingViewController
    repeat {
        vc = vc?.presentingViewController
    } while(vc?.presentingViewController != nil)
    
    if (vc != nil) {
        return (vc as! T)
    } else {
        return nil
    }
}

/// 调用系统拨号
///
/// - Parameter phoneNumber: 电话号码
public func cz_CallSystemDial(phoneNumber: String) {
    UIApplication.shared.open(URL(string: "tel://\(phoneNumber)")!, options: [:], completionHandler: nil)
}

/// 获取最上层window
public func cz_LastWindow() -> UIWindow? {
    for window in UIApplication.shared.windows.reversed() {
        if window.isKind(of: UIWindow.self) && window.bounds == UIScreen.main.bounds {
            return window
        }
    }
    return nil
}

/// 通过当前控制器获取最上层的控制器
///
/// - Parameter viewController: 控制器 默认是根控制器
/// - Returns: 最上层控制器
public func cz_TopsideController(viewController: UIViewController = (UIApplication.shared.delegate?.window?!.rootViewController)!) -> UIViewController? {
    if viewController.isKind(of: UINavigationController.self) {
        let navigationController = viewController as! UINavigationController
        return cz_TopsideController(viewController: navigationController.visibleViewController!)
    } else if (viewController.isKind(of: UITabBarController.self)) {
        let tabBarController = viewController as! UITabBarController
        return cz_TopsideController(viewController: tabBarController.selectedViewController!)
    } else if viewController.presentedViewController != nil {
        return cz_TopsideController(viewController: viewController.presentedViewController!)
    } else {
        return viewController
    }
}
