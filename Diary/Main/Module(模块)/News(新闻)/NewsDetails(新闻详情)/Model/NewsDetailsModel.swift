//
//  NewsDetailsModel.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/2/26.
//  Copyright © 2019 lcz. All rights reserved.
//

import Foundation

struct NewsDetailsRootModel: Mappable {
    var ERRORCODE: String?
    var RESULT: NewsDetailsModel?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        ERRORCODE   <- map["ERRORCODE"]
        RESULT   <- map["RESULT"]
    }
}

struct NewsDetailsModel: Mappable {
    var category: String?
    var source: String?
    var publishTime: String?
    var content: String?
    var editor: String?
    var title: String?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        category   <- map["category"]
        source   <- map["source"]
        publishTime   <- map["publishTime"]
        content   <- map["content"]
        editor   <- map["editor"]
        title   <- map["title"]
    }
}

