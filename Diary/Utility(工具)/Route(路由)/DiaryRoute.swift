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
        // 新闻详情
        navigator.register("diary://newsHome/newsDetails") { url, values, context in
            let newsDetailsVC = NewsDetailsViewController()
            let model = context as! NewsListModel
            newsDetailsVC.newsId = model.newsId
            newsDetailsVC.newsTitle = model.title
            newsDetailsVC.hidesBottomBarWhenPushed = true
            return newsDetailsVC
        }
        
        // 电影详情
        navigator.register("diary://movieHome/movieDetails") { url, values, context in
            let movieDetailsVC = MovieDetailsViewController()
            let model = context as! MovieHomeModel
            movieDetailsVC.movieHomeModel = model
            movieDetailsVC.hidesBottomBarWhenPushed = true
            return movieDetailsVC
        }
    }
    
}
