//
//  MovieEntranceTabBarController.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/6/26.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class MovieEntranceTabBarController: DiaryBaseTabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.LCZSetTabBarItem(viewController: NewsMovieHomeViewController(), navigationTitle: "电影", tabBarTitle: "电影", image: UIImage(named: "shipinhui")?.withRenderingMode(.alwaysOriginal), selectImage: UIImage(named: "shipin")?.withRenderingMode(.alwaysOriginal))
        self.LCZSetTabBarItem(viewController: TelevisionViewController(), navigationTitle: "电视", tabBarTitle: "电视", image: UIImage(named: "dianshijihui")?.withRenderingMode(.alwaysOriginal), selectImage: UIImage(named: "dianshiji")?.withRenderingMode(.alwaysOriginal))
        
    }
    
}
