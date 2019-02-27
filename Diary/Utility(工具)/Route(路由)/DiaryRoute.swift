//
//  DiaryRoute.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/2/13.
//  Copyright © 2019 lcz. All rights reserved.
//

import Foundation

enum DiaryRoute {
    
    static func initialize(navigator: NavigatorType) {
        navigator.register("diary://newsHome/newsDetails/<newsId>") { url, values, context in
            let newsDetailsVC = NewsDetailsViewController()
            newsDetailsVC.newsId = (values["newsId"] as! String)
            newsDetailsVC.hidesBottomBarWhenPushed = true
            return newsDetailsVC
        }
    }
    
}
