//
//  LoginModel.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/6/19.
//  Copyright © 2019 lcz. All rights reserved.
//

import Foundation

struct LoginModel: Mappable {
    var code: Int?
    var msg: String?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        code   <- map["code"]
        msg   <- map["msg"]
    }
}
