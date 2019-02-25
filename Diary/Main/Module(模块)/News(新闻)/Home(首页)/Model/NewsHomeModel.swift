//
//  NewsHomeModel.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/2/13.
//  Copyright © 2019 lcz. All rights reserved.
//

import Foundation

struct NewsRootModel<T: Mappable>: Mappable {
    var ERRORCODE: String?
    var RESULT: T?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        ERRORCODE   <- map["ERRORCODE"]
        RESULT   <- map["RESULT"]
    }
}

struct NewsListResultModel: Mappable {
    var newsList: Array<NewsListModel>? // 列表数据
    var page: Int = 0 // 当前页
    var allPage: Int = 0 // 总页数
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        newsList   <- map["newsList"]
        page   <- map["page"]
    }
}

struct NewsListModel: Mappable {
    var publishTime: String? // 发布时间
    var category: String? // 类型
    var source: String? // 来源
    var newsId: String? // 新闻ID
    var title: String? // 标题
    var newsImg: String? //新闻小图片url
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        publishTime   <- map["publishTime"]
        category   <- map["category"]
        source   <- map["source"]
        newsId   <- map["newsId"]
        title   <- map["title"]
        newsImg   <- map["newsImg"]
    }
}
