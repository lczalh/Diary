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
        self.setTabBarItem(viewController: NewsMovieHomeViewController(), tabBarTitle: "电影", image: UIImage(named: "shipinhui")?.withRenderingMode(.alwaysOriginal), selectImage: UIImage(named: "shipin")?.withRenderingMode(.alwaysOriginal))
        self.setTabBarItem(viewController: TelevisionViewController(), tabBarTitle: "电视", image: UIImage(named: "dianshijihui")?.withRenderingMode(.alwaysOriginal), selectImage: UIImage(named: "dianshiji")?.withRenderingMode(.alwaysOriginal))
        
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
