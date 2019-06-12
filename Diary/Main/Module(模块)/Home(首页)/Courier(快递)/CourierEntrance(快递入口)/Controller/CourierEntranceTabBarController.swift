//
//  LogisticsTabBarController.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/6/12.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class CourierEntranceTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let v1 = ExpressQueryViewController()
        let v2 = CommonlyExpressViewController()
        
        self.setTabBarItem(viewController: v1, tabBarTitle: "快递查询", image: UIImage(named: "huabanfubenhui")?.withRenderingMode(.alwaysOriginal), selectImage: UIImage(named: "huabanfuben")?.withRenderingMode(.alwaysOriginal))
        self.setTabBarItem( viewController: v2, tabBarTitle: "常用快递", image: UIImage(named: "commonlyExpressAsh")?.withRenderingMode(.alwaysOriginal), selectImage: UIImage(named: "commonlyExpress")?.withRenderingMode(.alwaysOriginal))
    }
    
    
    private func setTabBarItem(viewController: UIViewController?, tabBarTitle: String?, image: UIImage?, selectImage: UIImage?) {
        viewController?.tabBarItem.title = tabBarTitle
        viewController?.tabBarItem.image = image
        viewController?.tabBarItem.selectedImage = selectImage
        //改变文字颜色
        UITabBarItem.appearance().setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor: LCZHexadecimalColor(hexadecimal: "#FECE1D")], for: .selected)
        self.addChild(viewController!)
        
    }
}
