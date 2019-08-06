//
//  NewsHomeModel.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/2/13.
//  Copyright © 2019 lcz. All rights reserved.
//

import Foundation

struct SpeedNewsRootModel<T: Mappable>: Mappable {
    var status: Int?
    var msg: String?
    var result: T?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        status   <- map["status"]
        msg   <- map["msg"]
        result   <- map["result"]
    }
}

struct SpeedNewsResultModel: Mappable {
    var num: Int = 0
    var list = [SpeedNewsListModel]()
    var channel: String?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        num   <- map["num"]
        list   <- map["list"]
        channel   <- map["channel"]
    }
}

class SpeedNewsListModel: NSObject,Mappable {
    var pic: String?
    var weburl: String?
    var time: String?
    var category: String?
    var title: String?
    var url: String?
    var src: String?
    var content: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        pic   <- map["pic"]
        weburl   <- map["weburl"]
        time   <- map["time"]
        category   <- map["category"]
        title   <- map["title"]
        url   <- map["url"]
        src   <- map["src"]
        content   <- map["content"]
    }
}

extension SpeedNewsListModel: IdentifiableType {
    var identity: SpeedNewsListModel {
        return self
    }
    
    typealias Identity = SpeedNewsListModel
}

struct SpeedNewschannelModel: Mappable {
    var status: Int = 0
    var msg: String?
    var result = Array<String>()
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        status   <- map["status"]
        msg   <- map["msg"]
        result   <- map["result"]
    }
}
