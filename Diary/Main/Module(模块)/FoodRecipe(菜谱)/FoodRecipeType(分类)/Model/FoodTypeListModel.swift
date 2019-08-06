//
//  FoodTypeListModel.swift
//  Diary
//
//  Created by linphone on 2019/7/29.
//  Copyright © 2019 lcz. All rights reserved.
//

import Foundation

struct  FoodTypeRootModel: Mappable {
    var status: Int?
    var msg: String?
    var result:Array<FoodTypeResultModel>?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        status   <- map["status"]
        msg   <- map["msg"]
        result   <- map["result"]
    }
}
class FoodTypeResultModel:NSObject, Mappable {
    var classid: Int = 0
    var parentid: Int = 0
    var name:String?
    var list = [FoodTypeListModel]()
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        classid   <- map["classid"]
        parentid <- map["parentid"]
        list   <- map["list"]
        name   <- map["name"]
    }
}


class FoodTypeListModel: NSObject,Mappable {
    var classid: Int = 0
    var parentid: Int = 0
    var name:String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        classid   <- map["classid"]
        parentid   <- map["parentid"]
        name   <- map["name"]
    }
}
