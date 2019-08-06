//
//  LCZUIAlertControllerExtension.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/6/14.
//  Copyright © 2019 lcz. All rights reserved.
//

import Foundation
import UIKit

extension UIAlertController {
    /// 在指定视图控制器上弹出普通消息提示框
    ///
    /// - Parameters:
    ///   - message: 消息内容
    ///   - viewController: 指定视图控制器
    static func showAlert(message: String, in viewController: UIViewController) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确定", style: .cancel))
        viewController.present(alert, animated: true)
    }
    
    
    /// 在根视图控制器上弹出普通消息提示框
    ///
    /// - Parameter message: 消息内容
    static func showAlert(message: String) {
        if let vc = UIApplication.shared.keyWindow?.rootViewController {
            showAlert(message: message, in: vc)
        }
    }
    
    /// 在指定视图控制器上弹出确认框
    ///
    /// - Parameters:
    ///   - message: 消息内容
    ///   - viewController: 指定视图控制器
    ///   - confirm: 确定回调
    static func showConfirm(message: String, in viewController: UIViewController,
                            confirm: ((UIAlertAction)->Void)?) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "取消", style: .cancel))
        alert.addAction(UIAlertAction(title: "确定", style: .default, handler: confirm))
        viewController.present(alert, animated: true)
    }
    
    
    /// 在根视图控制器上弹出确认框
    ///
    /// - Parameters:
    ///   - message: 消息内容
    ///   - confirm: 确定回调
    static func showConfirm(message: String, confirm: ((UIAlertAction)->Void)?) {
        if let vc = UIApplication.shared.keyWindow?.rootViewController {
            showConfirm(message: message, in: vc, confirm: confirm)
        }
    }
}
