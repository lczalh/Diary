//
//  JokeEntranceTabBarController.swift
//  Diary
//
//  Created by glgl on 2019/7/26.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class JokeEntranceTabBarController: DiaryBaseTabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.LCZSetTabBarItem(viewController: FunnyPicturesViewController(), navigationTitle: "趣图", tabBarTitle: "趣图", image: UIImage(named: "qutuhui")?.withRenderingMode(.alwaysOriginal), selectImage: UIImage(named: "qutu")?.withRenderingMode(.alwaysOriginal))
        self.LCZSetTabBarItem(viewController: CrossTalkViewController(), navigationTitle: "段子", tabBarTitle: "段子", image: UIImage(named: "duanzihui")?.withRenderingMode(.alwaysOriginal), selectImage: UIImage(named: "duanzi")?.withRenderingMode(.alwaysOriginal))
        self.LCZSetTabBarItem(viewController: EnshrineJokeViewController(), navigationTitle: "收藏", tabBarTitle: "收藏", image: UIImage(named: "shoucanghui")?.withRenderingMode(.alwaysOriginal), selectImage: UIImage(named: "shoucang")?.withRenderingMode(.alwaysOriginal))
    }

}
