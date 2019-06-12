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
        navigator.register("diary://homeEntrance/newsHome") { url, values, context in
            let newsHome = NewsHomeViewController()
            newsHome.hidesBottomBarWhenPushed = true
            return newsHome
        }
        
        // 新闻详情
        navigator.register("diary://homeEntrance/newsHome/newsDetails") { url, values, context in
            let newsDetails = NewsDetailsViewController()
            newsDetails.model = context as? SpeedNewsListModel
            newsDetails.hidesBottomBarWhenPushed = true
            return newsDetails
        }
        
        // 电影首页
        navigator.register("diary://homeEntrance/movieHome") { url, values, context in
            let movieHome = MovieHomeViewController()
            movieHome.hidesBottomBarWhenPushed = true
            return movieHome
        }
        
        // 电影详情
        navigator.register("diary://homeEntrance/movieHome/movieDetails") { url, values, context in
            let movieDetails = MovieDetailsViewController()
            let model = context as! MovieHomeModel
            movieDetails.movieHomeModel = model
            movieDetails.hidesBottomBarWhenPushed = true
            return movieDetails
        }
        
        // 搜索电影
        navigator.register("diary://homeEntrance/movieHome/searchMovie") { url, values, context in
            let searchMovie = SearchMovieViewController()
            searchMovie.hidesBottomBarWhenPushed = true
            return searchMovie
        }
        
        // 快递
        navigator.register("diary://homeEntrance/courierEntrance") { url, values, context in
            let courierEntrance = CourierEntranceTabBarController()
            courierEntrance.hidesBottomBarWhenPushed = true
            return courierEntrance
        }
        
        // 快递查询结果
        navigator.register("diary://homeEntrance/courierEntrance/expressQueryResults") { url, values, context in
            let expressQueryResults = ExpressQueryResultsViewController()
            expressQueryResults.model = context as? ExpressQueryResultModel
            expressQueryResults.hidesBottomBarWhenPushed = true
            return expressQueryResults
        }
    }
    
}
