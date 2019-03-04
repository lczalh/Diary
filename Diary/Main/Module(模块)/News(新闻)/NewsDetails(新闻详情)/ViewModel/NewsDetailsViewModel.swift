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
    
    init(input: (newsId: String,
                newsTitle: String),
         dependency: (
            disposeBag: DisposeBag,
            networkService: NewsDetailsNetworkService)
        ) {
        
        let realm = try! Realm()
        // 查询数据
        let model = realm.objects(NewsDetailsModel.self).filter{ $0.title == input.newsTitle }.first
        // 查询数据是否存在
        if model == nil {
            newsDetailsData = dependency.networkService.getNewsDetailsData(newsId: input.newsId).asDriver(onErrorJustReturn: NewsDetailsModel(map: Map(mappingType: .fromJSON, JSON: ["a":"1"]))!).map({ (model) -> NewsDetailsModel in
                DispatchQueue.main.async(execute: {
                    try! realm.write {
                        realm.add(model)
                    }
                })
                return model
            })
        } else {
          newsDetailsData = Observable.just(model!).asDriver(onErrorJustReturn: NewsDetailsModel(map: Map(mappingType: .fromJSON, JSON: ["a":"1"]))!)
        }
        
        
        
        
        
    }
}
