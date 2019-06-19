//
//  RegisterModel.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/6/19.
//  Copyright © 2019 lcz. All rights reserved.
//

import Foundation

struct RegisterMobApiModel: Mappable {
    var retCode: String?
    var result: String?
    var msg: String?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        retCode   <- map["retCode"]
        result   <- map["result"]
        msg   <- map["msg"]
    }
}
