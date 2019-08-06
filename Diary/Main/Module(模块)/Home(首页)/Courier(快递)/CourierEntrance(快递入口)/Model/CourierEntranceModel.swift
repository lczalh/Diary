//
//  CourierEntranceModel.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/6/14.
//  Copyright © 2019 lcz. All rights reserved.
//

import Foundation

struct CourierEntranceRootModel: Mappable {
    var status: Int = 0
    var msg: String?
    var result: [CourierEntranceModel]?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        status   <- map["status"]
        msg   <- map["msg"]
        result   <- map["result"]
    }
}

// 快递公司model
struct CourierEntranceModel: Mappable {
    /// 快递公司名称
    var name: String?
    /// 快递代号
    var type: String?
    /// 测试单号
    var number: String?
    /// 首字母
    var letter: String?
    /// 电话
    var tel: String?
    /// logo
    var logo: String?
    
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        name   <- map["name"]
        type   <- map["type"]
        number   <- map["number"]
        letter   <- map["letter"]
        tel   <- map["tel"]
        logo <- map["logo"]
    }
}
