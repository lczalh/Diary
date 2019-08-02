//
//  DiaryBaseViewController.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/2/13.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class DiaryBaseViewController: UIViewController {
    
    // 是否支持屏幕旋转
    override var shouldAutorotate: Bool {
        return false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        // 禁止导航栏半透明
        self.navigationController?.navigationBar.isTranslucent = false
        // 禁止tabbar半透明
        self.tabBarController?.tabBar.isTranslucent = false
        // 统一设置返回按钮
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        backBarButtonItem.tintColor = LCZPublicHelper.shared.getHexadecimalColor(hexadecimal: AppContentColor)
        self.navigationItem.backBarButtonItem = backBarButtonItem
        
    }
    
    deinit {
        LCZPublicHelper.shared.setPrint("控制器销毁了！！！！")
    }
    
}
