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
        
        // 找回密码
        navigator.register("diary://login/retrievepassword") { url, values, context in
            let retrievePassword = RetrievePasswordViewController()
            retrievePassword.hidesBottomBarWhenPushed = true
            return retrievePassword
        }
        
        // 注册
        navigator.register("diary://login/register") { url, values, context in
            let register = RegisterViewController()
            register.hidesBottomBarWhenPushed = true
            return register
        }
        
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
        
        // 电影入口
        navigator.register("diary://homeEntrance/movieEntrance") { url, values, context in
            let movieEntranceTabBarController = MovieEntranceTabBarController()
            movieEntranceTabBarController.hidesBottomBarWhenPushed = true
            return movieEntranceTabBarController
        }
        
        // 新电影首页
        navigator.register("diary://homeEntrance/newsMovieHome") { url, values, context in
            let movieHome = NewsMovieHomeViewController()
            movieHome.hidesBottomBarWhenPushed = true
            return movieHome
        }
        
        // 更多电影
        navigator.register("diary://homeEntrance/newsMovieHome/MoreMovies") { url, values, context in
            let moreMovies = MoreMoviesViewController()
            moreMovies.hidesBottomBarWhenPushed = true
            return moreMovies
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
        
        // 快递入口
        navigator.register("diary://homeEntrance/courierEntrance") { url, values, context in
            let courierEntrance = CourierEntranceTabBarController()
            courierEntrance.hidesBottomBarWhenPushed = true
            return courierEntrance
        }
        
        // 快递查询结果
        navigator.register("diary://homeEntrance/courierEntrance/expressQueryResults") { url, values, context in
            let expressQueryResults = ExpressQueryResultsViewController()
            let contexts = context as! Array<Any>
            expressQueryResults.expressQueryResultModel = contexts[0] as? ExpressQueryResultModel
            expressQueryResults.commonExpressCompaniesModel = contexts[1] as! [CourierEntranceModel]
            expressQueryResults.hidesBottomBarWhenPushed = true
            return expressQueryResults
        }
        
        // 设置
        navigator.register("diary://mine/setting") { url, values, context in
            let setting = SettingViewController()
            setting.hidesBottomBarWhenPushed = true
            return setting
        }
        
        // 问题反馈
        navigator.register("diary://mine/problemfeedback") { url, values, context in
            let problemFeedback = ProblemFeedbackViewController()
            problemFeedback.hidesBottomBarWhenPushed = true
            return problemFeedback
        }
        
        // 版权声明
        navigator.register("diary://mine/copyrightStatement") { url, values, context in
            let copyrightStatement = CopyrightStatementViewController()
            copyrightStatement.hidesBottomBarWhenPushed = true
            return copyrightStatement
        }
        
        // 隐私政策
        navigator.register("diary://mine/privacyPolicy") { url, values, context in
            let privacyPolicy = PrivacyPolicyViewController()
            privacyPolicy.hidesBottomBarWhenPushed = true
            return privacyPolicy
        }
        
        // 关于我们
        navigator.register("diary://mine/aboutUs") { url, values, context in
            let aboutUs = AboutUsViewController()
            aboutUs.hidesBottomBarWhenPushed = true
            return aboutUs
        }
    }
    
}
