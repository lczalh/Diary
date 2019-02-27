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
        
        newsDetailsData = dependency.networkService.getNewsDetailsData(newsId: newsId).asDriver(onErrorJustReturn: NewsDetailsModel(map: Map(mappingType: .fromJSON, JSON: ["a":"1"]))!).map({ (model) -> NewsDetailsModel in
            return model
        })
        
        
    }
}
