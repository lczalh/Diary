//
//  JokeEntranceTabBarController.swift
//  Diary
//
//  Created by glgl on 2019/7/26.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit


class FoodRecipeTabBarController: DiaryBaseTabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.LCZSetTabBarItem(viewController: FoodRecipeHomeViewController(), navigationTitle: "菜谱大全", tabBarTitle: "菜谱", image: UIImage(named: "bangzhuhui")?.withRenderingMode(.alwaysOriginal), selectImage: UIImage(named: "bangzhu")?.withRenderingMode(.alwaysOriginal))
        
        self.LCZSetTabBarItem(viewController: FoodRecipeTypeViewController(), navigationTitle: "分类", tabBarTitle: "分类", image: UIImage(named: "bangzhuhui")?.withRenderingMode(.alwaysOriginal), selectImage: UIImage(named: "bangzhu")?.withRenderingMode(.alwaysOriginal))
        
        self.LCZSetTabBarItem(viewController: FoodRecipeCollectViewController(), navigationTitle: "我的记录", tabBarTitle: "记录", image: UIImage(named: "shoucanghui")?.withRenderingMode(.alwaysOriginal), selectImage: UIImage(named: "shoucang")?.withRenderingMode(.alwaysOriginal))
    }

}
