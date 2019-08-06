//
//  TelevisionBaseModel.swift
//  Diary
//
//  Created by glgl on 2019/7/17.
//  Copyright © 2019 lcz. All rights reserved.
//

import Foundation

struct TelevisionBaseModel: Mappable {
    var title: String?
    var list = [TelevisionSectionModel]()
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        title   <- map["title"]
        list   <- map["list"]
    }
}

struct TelevisionSectionModel: Mappable {
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        sectionTitle <- map["sectionTitle"]
        cellList <- map["cellList"]
    }
    
    /// 分组标题
    var sectionTitle: String?
    var cellList = [TelevisionCellModel]()
    
}

struct TelevisionCellModel: Mappable {
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        image <- map["image"]
        title <- map["title"]
        playUrl <- map["playUrl"]
    }
    
    /// 图片
    var image: String?
    /// 标题
    var title: String?
    /// 播放地址
    var playUrl: String?
    
}
