//
//  MainTabBarController.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/6/11.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class MainTabBarController: DiaryBaseTabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let v1 = HomeEntranceViewController()
        let v2 = MineEntranceViewController()
        
        self.LCZSetTabBarItem(viewController: v1, navigationTitle:"", tabBarTitle: "首页", image: UIImage(named: "zhuyehui")?.withRenderingMode(.alwaysOriginal), selectImage: UIImage(named: "zhuye")?.withRenderingMode(.alwaysOriginal))
        self.LCZSetTabBarItem( viewController: v2, navigationTitle:"", tabBarTitle: "我的", image: UIImage(named: "wodehui")?.withRenderingMode(.alwaysOriginal), selectImage: UIImage(named: "wode")?.withRenderingMode(.alwaysOriginal))
    }
    
//
//    private func setTabBarItem(viewController: UIViewController?, tabBarTitle: String?, navigationTitle: String?, image: UIImage?, selectImage: UIImage?) {
//        viewController?.navigationItem.title = navigationTitle
//        viewController?.tabBarItem.title = tabBarTitle
//        viewController?.tabBarItem.image = image
//        viewController?.tabBarItem.selectedImage = selectImage
//        //改变文字颜色
//        let navi = MainNavigationController(rootViewController: viewController!)
//        self.addChild(navi)
//        
//    }

}
