
//
//  FoodRecipeInfoDataModel.swift
//  Diary
//
//  Created by linphone on 2019/8/2.
//  Copyright © 2019 lcz. All rights reserved.
// 菜肴的基本信息及食材做法信息数据

import Foundation

struct FoodRecipeInfoRootModel<T: Mappable>:Mappable {
    var status: Int?
    var msg: String?
    var result:T?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        status   <- map["status"]
        msg   <- map["msg"]
        result   <- map["result"]
    }
}

struct  FoodRecipeInfoResultModel: Mappable {
    var num: Int = 0
    var list = [FoodRecipeInfoListModel]()
    
    init?(map:Map) {
    }
    
    mutating func mapping(map: Map) {
        num   <- map["num"]
        list   <- map["list"]
    }
}

//菜谱详细信息
class FoodRecipeInfoListModel: NSObject,Mappable {
    var id: Int = 0  //菜id
    var classid: Int = 0 //菜类id
    var name:String? //菜名
    var peoplenum: String? //用餐人数
    var preparetime:String? //烹饪时间
    var cookingtime: String? //烹饪时间
    var content: String? //说明
    var pic:String? //图片
    var tag:String? //标签
    var material = [FoodMaterialListModel]() //食材
    var process = [FoodProcessListModel]() //制作流程
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id   <- map["id"]
        classid   <- map["classid"]
        name   <- map["name"]
        classid   <- map["classid"]
        peoplenum   <- map["peoplenum"]
        preparetime   <- map["preparetime"]
        cookingtime   <- map["cookingtime"]
        content   <- map["content"]
        pic   <- map["pic"]
        tag   <- map["tag"]
        material   <- map["material"]
        process   <- map["process"]
    }
}

// 食材模型
class FoodMaterialListModel: NSObject,Mappable {
    var mname: String? //食材名
    var type: Int = 0 //0 表示辅 1 表示主
    var amount:String? //用量
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        mname   <- map["mname"]
        type   <- map["type"]
        amount   <- map["amount"]
    }
}

// 制作流程模型
class FoodProcessListModel: NSObject,Mappable {
    var pcontent: String?
    var pic:String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        pcontent   <- map["pcontent"]
        pic   <- map["pic"]
    }
}
