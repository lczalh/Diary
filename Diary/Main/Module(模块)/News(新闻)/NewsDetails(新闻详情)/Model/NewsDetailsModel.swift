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

class NewsDetailsModel: Object, Mappable {
    
    @objc dynamic var category: String?
    @objc dynamic var source: String?
    @objc dynamic var publishTime: String?
    @objc dynamic var content: String?
    @objc dynamic var editor: String?
    @objc dynamic var title: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        category   <- map["category"]
        source   <- map["source"]
        publishTime   <- map["publishTime"]
        content   <- map["content"]
        editor   <- map["editor"]
        title   <- map["title"]
    }
}

