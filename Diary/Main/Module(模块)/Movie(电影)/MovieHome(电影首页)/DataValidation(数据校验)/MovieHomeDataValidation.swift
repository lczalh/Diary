//
//  MovieHomeDataValidation.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/3/22.
//  Copyright © 2019 lcz. All rights reserved.
//

import Foundation

class MovieHomeDataValidation {
    
    /// 数据去重并移除空图片数据
    ///
    /// - Parameters:
    ///   - items: 模型数组
    ///   - realm: 数据库对象
    /// - Returns: 新数据数组
    public func dataHeavy(items: Array<MovieHomeModel>) -> Array<MovieHomeModel> {
        var modelAry: Array<MovieHomeModel> = Array()
        for m in items {
            let model = diaryRealm.objects(MovieHomeModel.self).filter{ $0.vod_name == m.vod_name }.first
            if model == nil, m.vod_pic?.isEmpty == false {
                try! diaryRealm.write {
                    diaryRealm.add(m)
                    modelAry.append(m)
                }
            }
        }
        return modelAry
    }
}
