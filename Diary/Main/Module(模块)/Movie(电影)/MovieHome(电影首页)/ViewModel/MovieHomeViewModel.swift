//
//  MovieHomeViewModel.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/3/20.
//  Copyright © 2019 lcz. All rights reserved.
//

import Foundation

class MovieHomeViewModel {
    
    // 影视专区数据
    let moviewHomeModel = Observable.just([
            MovieHomeModel(header: "", items: [
                    "腾讯视频",
                    "爱奇艺",
                    "搜狐视频",
                    "优酷视频"
                ])
        ])
    
}
