//
//  NewsDetailsViewModel.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/2/27.
//  Copyright © 2019 lcz. All rights reserved.
//

import Foundation

class NewsDetailsViewModel {
    
    var newsDetailsData: Driver<NewsDetailsModel>
    
    
    init(newsId: String,
         dependency: (
            disposeBag: DisposeBag,
            networkService: NewsDetailsNetworkService)) {
        
        //数据库
        let realm = try! Realm()
        newsDetailsData = dependency.networkService.getNewsDetailsData(newsId: newsId).asDriver(onErrorJustReturn: NewsDetailsModel(map: Map(mappingType: .fromJSON, JSON: ["a":"1"]))!).map({ (model) -> NewsDetailsModel in
            // 数据持久化操作（类型记录也会自动添加的）
            try! realm.write {
                realm.add(model)
            }
            //打印出数据库地址
       //     print(realm.configuration.fileURL ?? "")
            print(realm.objects(NewsDetailsModel.self))
            return model
        })
        
        
    }
}
