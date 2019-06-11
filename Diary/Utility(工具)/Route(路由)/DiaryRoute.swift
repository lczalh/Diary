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
        // 新闻首页
        navigator.register("diary://newsHome") { url, values, context in
            let newsHomeVC = NewsHomeViewController()
            newsHomeVC.hidesBottomBarWhenPushed = true
            return newsHomeVC
            
        }
        
        // 新闻详情
        navigator.register("diary://newsHome/newsDetails") { url, values, context in
            let newsDetailsVC = NewsDetailsViewController()
            newsDetailsVC.model = context as? SpeedNewsListModel
            newsDetailsVC.hidesBottomBarWhenPushed = true
            return newsDetailsVC
        }
        
        // 电影首页
        navigator.register("diary://movieHome") { url, values, context in
            let movieHomeVC = MovieHomeViewController()
            movieHomeVC.hidesBottomBarWhenPushed = true
            return movieHomeVC
        }
        
        // 电影详情
        navigator.register("diary://movieHome/movieDetails") { url, values, context in
            let movieDetailsVC = MovieDetailsViewController()
            let model = context as! MovieHomeModel
            movieDetailsVC.movieHomeModel = model
            movieDetailsVC.hidesBottomBarWhenPushed = true
            return movieDetailsVC
        }
        
        // 搜索电影
        navigator.register("diary://movieHome/searchMovie") { url, values, context in
            let searchMovie = SearchMovieViewController()
            
            searchMovie.hidesBottomBarWhenPushed = true
            return searchMovie
        }
    }
    
}
