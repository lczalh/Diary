//
//  NewsHomeDataValidation.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/3/22.
//  Copyright © 2019 lcz. All rights reserved.
//

import Foundation

class NewsHomeDataValidation {
    
    /// 数据去重并移除空图片数据
    ///
    /// - Parameters:
    ///   - items: 模型数组
    ///   - realm: 数据库对象
    /// - Returns: 新数据数组
    public func dataHeavy(items: Array<NewsListModel>) -> Array<NewsListModel> {
        var modelAry: Array<NewsListModel> = Array()
        for m in items {
            let model = diaryRealm.objects(NewsListModel.self).filter{ $0.title == m.title }.first
            if model == nil, m.newsImg?.isEmpty == false {
                try! diaryRealm.write {
                    diaryRealm.add(m)
                    modelAry.append(m)
                }
            }
        }
        return modelAry
    }
}
