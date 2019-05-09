//
//  NewsDetailsNetworkService.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/2/27.
//  Copyright © 2019 lcz. All rights reserved.
//

import Foundation

class NewsDetailsNetworkService {
    // 获取新闻详情数据
//    public func getNewsDetailsData(newsId: String) -> Single<NewsDetailsModel> {
//        return Single<NewsDetailsModel>.create(subscribe: { (single) -> Disposable in
//            let request = networkServicesProvider.rx.requestData(target: MultiTarget(NewsNetworkServices.getNewsDetails(appKey: "eb7906fea2824f61a26fab22c071fe9a", newsId: newsId)), model: NewsDetailsRootModel.self).subscribe(onSuccess: { (result) in
//                if result.ERRORCODE == "0" {
//                  //  LCZPrint(result.RESULT.count)
//                    single(.success(result.RESULT!))
//                } else {
//                    LCZPrint("错误")
//                }
//            }, onError: { (error) in
//                single(.error(error))
//            })
//            return Disposables.create([request])
//        })
//    }
}
