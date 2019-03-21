//
//  MovieHomeViewModel.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/3/20.
//  Copyright © 2019 lcz. All rights reserved.
//

import Foundation

class MovieHomeViewModel {
    
    var modelAry: Observable<Array<MovieHomeModel>> = Observable.just(
        [
            MovieHomeModel.init(title: "腾讯视频", url: "https://m.v.qq.com/index.html", image: ""),
            MovieHomeModel.init(title: "爱奇艺", url: "https://www.iqiyi.com", image: ""),
            MovieHomeModel.init(title: "优酷视频", url: "https://www.youku.com", image: ""),
            MovieHomeModel.init(title: "搜狐视频", url: "https://m.tv.sohu.com", image: "")
        ]
    
    )
    
    
    
}
