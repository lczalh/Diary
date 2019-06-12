//
//  ExpressQueryModel.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/6/12.
//  Copyright © 2019 lcz. All rights reserved.
//

import Foundation

class ExpressQueryResultModel: Mappable {
    /// 快递单号
    var number: String?
    /// 快递公司
    var type: String?
    /// 已弃用，请使用deliverystatus
    var issign: Int = 0
    /// 物流状态 1在途中 2派件中 3已签收 4派送失败(拒签等)
    var deliverystatus: Int = 0
    var list = [ExpressQueryListModel]()
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        number   <- map["number"]
        type   <- map["type"]
        issign   <- map["issign"]
        deliverystatus   <- map["deliverystatus"]
        list   <- map["list"]
    }
}

class ExpressQueryListModel: Mappable {
    
    /// 时间
    var time: String?
    /// 状态
    var status: String?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        time   <- map["time"]
        status   <- map["status"]
    }
}
