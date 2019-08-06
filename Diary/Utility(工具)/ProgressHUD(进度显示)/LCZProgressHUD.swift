//
//  LCZProgressHUD.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/3/20.
//  Copyright © 2019 lcz. All rights reserved.
//

import Foundation

class LCZProgressHUD {
    
    /// 只有循环的小圆圈提示框
    class func show() -> () {
        SVProgressHUD.show()
        SVProgressHUD.setBackgroundColor(UIColor.black)
        SVProgressHUD.setForegroundColor(UIColor.white)
    }

    /// 循环小圈圈 + 文字
    ///
    /// - Parameter title: 提示标题
    class func show(title : String?) -> Void {
        SVProgressHUD.show(withStatus: title)
        SVProgressHUD.setBackgroundColor(UIColor.black)
        SVProgressHUD.setForegroundColor(UIColor.white)
    }
    
    /// 成功的提示框 两秒消失
    ///
    /// - Parameter title: 提示标题
    class func showSuccess(title: String?) -> Void {
        SVProgressHUD.showSuccess(withStatus: title)
        SVProgressHUD.setBackgroundColor(UIColor.black)
        SVProgressHUD.setForegroundColor(UIColor.white)
        dismiss(withDelay: 2)
    }
    
    /// 错误的提示框 两秒消失
    ///
    /// - Parameter title: 提示标题
    class func showError(title: String?) -> Void {
        SVProgressHUD.showError(withStatus: title)
        SVProgressHUD.setBackgroundColor(UIColor.black)
        SVProgressHUD.setForegroundColor(UIColor.white)
        dismiss(withDelay: 2)
    }
    
    /// 立即隐藏
    class func dismiss() -> Void {
        SVProgressHUD.dismiss()
    }
    
    /// 延时隐藏
    ///
    /// - Parameter withDelay: 几秒后隐藏
    class func dismiss(withDelay : TimeInterval) -> () {
        SVProgressHUD.dismiss(withDelay: withDelay)
    }
}
