//
//  MovieEntranceTabBarController.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/6/26.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class MovieEntranceTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTabBarItem(viewController: NewsMovieHomeViewController(), navigationTitle: "电影", tabBarTitle: "电影", image: UIImage(named: "shipinhui")?.withRenderingMode(.alwaysOriginal), selectImage: UIImage(named: "shipin")?.withRenderingMode(.alwaysOriginal))
        self.setTabBarItem(viewController: TelevisionViewController(), navigationTitle: "电视", tabBarTitle: "电视", image: UIImage(named: "dianshijihui")?.withRenderingMode(.alwaysOriginal), selectImage: UIImage(named: "dianshiji")?.withRenderingMode(.alwaysOriginal))
        
    }
    
    
    private func setTabBarItem(viewController: UIViewController?, navigationTitle: String?, tabBarTitle: String?, image: UIImage?, selectImage: UIImage?) {
        viewController?.navigationItem.title = navigationTitle
        viewController?.tabBarItem.title = tabBarTitle
        viewController?.tabBarItem.image = image
        viewController?.tabBarItem.selectedImage = selectImage
        let navigationController = UINavigationController(rootViewController: viewController!)
        // 修改导航颜色
        navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: LCZHexadecimalColor(hexadecimal: "#57310C")]
        self.addChild(navigationController)
        
    }
}
