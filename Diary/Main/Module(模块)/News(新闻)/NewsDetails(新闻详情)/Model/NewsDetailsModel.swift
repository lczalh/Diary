//
//  NewsDetailsModel.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/2/26.
//  Copyright © 2019 lcz. All rights reserved.
//

import Foundation

struct NewsDetailsModel: Mappable {
    var RESULT = [String]()
    var ERRORCODE: String?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        RESULT   <- map["RESULT"]
        ERRORCODE   <- map["ERRORCODE"]
    }
}
