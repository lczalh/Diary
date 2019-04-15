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
    public func dataHeavy(items: Array<MovieHomeModel>, page: Int) -> Array<MovieHomeModel> {
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
        
        // 判断是否有新数据且够20条 不够20条则查本地数据追加
        if modelAry.count == 20 { // 有新数据 直接返回
            return modelAry
        } else { // 没有 返回本地当页数据
            let realmModel = diaryRealm.objects(MovieHomeModel.self).sorted { LCZTimeToTimeStamp(time: $0.vod_time!).int > LCZTimeToTimeStamp(time: $1.vod_time!).int }
            // 本地已没有数据，返回空
            if ((page - 1) * 20) > realmModel.count {
                return modelAry
            }
            // 每次返回20条数据
            for i in ((page - 1) * 20)..<((page * 20) >= realmModel.count ? realmModel.count : (page * 20)) {
                modelAry.append(realmModel[i])
            }
            return modelAry;
        }
    }
}
