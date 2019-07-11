//
//  NewsEntranceTabBarController.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/7/11.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class NewsEntranceTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setTabBarItem(viewController: NewsHomeViewController(), navigationTitle: "新闻", tabBarTitle: "新闻", image: UIImage(named: "bangzhuhui")?.withRenderingMode(.alwaysOriginal), selectImage: UIImage(named: "bangzhu")?.withRenderingMode(.alwaysOriginal))
    }
    

    private func setTabBarItem(viewController: UIViewController?, navigationTitle: String?, tabBarTitle: String?, image: UIImage?, selectImage: UIImage?) {
        viewController?.navigationItem.title = navigationTitle
        viewController?.tabBarItem.title = tabBarTitle
        viewController?.tabBarItem.image = image
        viewController?.tabBarItem.selectedImage = selectImage
        //改变文字颜色
        UITabBarItem.appearance().setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor: LCZHexadecimalColor(hexadecimal: "#FECE1D")], for: .selected)
        let navigationController = UINavigationController(rootViewController: viewController!)
        // 修改导航颜色
        navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: LCZHexadecimalColor(hexadecimal: "#57310C")]
        self.addChild(navigationController)
        
    }

}
