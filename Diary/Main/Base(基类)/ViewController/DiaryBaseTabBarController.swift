//
//  DiaryBaseTabBarController.swift
//  Diary
//
//  Created by glgl on 2019/7/26.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class DiaryBaseTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    /// 设置控制器
    ///
    /// - Parameters:
    ///   - viewController: 视图控制器
    ///   - navigationTitle: 导航标题
    ///   - tabBarTitle: 标签标题
    ///   - image: 默认图片
    ///   - selectImage: 选择图片
    public func LCZSetTabBarItem(viewController: UIViewController?, navigationTitle: String?, tabBarTitle: String?, image: UIImage?, selectImage: UIImage?) {
        viewController?.navigationItem.title = navigationTitle
        viewController?.tabBarItem.title = tabBarTitle
        viewController?.tabBarItem.image = image
        viewController?.tabBarItem.selectedImage = selectImage
        let navigationController = DiaryBaseNavigationController(rootViewController: viewController!)
        self.addChild(navigationController)
    }

}
