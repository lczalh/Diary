//
//  NewsHomeModel.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/2/13.
//  Copyright © 2019 lcz. All rights reserved.
//

import Foundation

// MARK: - 新闻列表模型
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

class NewsListModel: Object,Mappable {
    @objc dynamic var publishTime: String? // 发布时间
    @objc dynamic var category: String? // 类型
    @objc dynamic var source: String? // 来源
    @objc dynamic var newsId: String? // 新闻ID
    @objc dynamic var title: String? // 标题
    @objc dynamic var newsImg: String? //新闻小图片url
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        publishTime   <- map["publishTime"]
        category   <- map["category"]
        source   <- map["source"]
        newsId   <- map["newsId"]
        title   <- map["title"]
        newsImg   <- map["newsImg"]
    }
}


// MARK: - 新闻类型列表模型
struct NewsTypeListModel: Mappable {
    var RESULT = [String]()
    var ERRORCODE: String?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        RESULT   <- map["RESULT"]
        ERRORCODE   <- map["ERRORCODE"]
    }
}
