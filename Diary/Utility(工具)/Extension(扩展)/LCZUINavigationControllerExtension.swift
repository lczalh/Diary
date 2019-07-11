//
//  LCZUINavigationControllerExtension.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/7/11.
//  Copyright © 2019 lcz. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationController {
    
    /// 设置导航条透明 须在viewWillAppear调用
    public func LCZSetNavigationBarTransparency() {
        self.navigationBar.isTranslucent = true
        //设置导航栏背景透明
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
    }
    
    /// 将透明导航条还原 须在viewWillDisappear调用
    public func LCZRestoreTheTransparentNavigationBar() {
        //重置导航栏背景
        self.navigationBar.setBackgroundImage(nil, for: .default)
        self.navigationBar.shadowImage = nil
    }
}
