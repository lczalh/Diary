//
//  NewsHomeNetworkService.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/2/22.
//  Copyright © 2019 lcz. All rights reserved.
//

import Foundation


class NewsHomeNetworkService {
    
    // 获取新闻类型列表数据
    public func getNewsTypeListData() -> Single<[String]> {
        return Single<[String]>.create(subscribe: { (single) -> Disposable in
            let request = networkServicesProvider.rx.requestData(target: MultiTarget(NewsNetworkServices.getNewsTypeList(appKey: "eb7906fea2824f61a26fab22c071fe9a")), model: NewsTypeListModel.self).subscribe(onSuccess: { (result) in
                if result.ERRORCODE == "0" {
                    single(.success(result.RESULT))
                } else {
                    LCZPrint("错误")
                }
            }, onError: { (error) in
                single(.error(error))
            })
            return Disposables.create([request])
        })
    }
    
    // 获取新闻列表数据
    public func getNewsListData(category: String, page: Int) -> Single<[NewsListModel]> {
        return Single<[NewsListModel]>.create(subscribe: { (single) -> Disposable in
            let request = networkServicesProvider.rx.requestData(target: MultiTarget(NewsNetworkServices.getNewsList(appKey: "eb7906fea2824f61a26fab22c071fe9a", category: category, page: page)), model: NewsRootModel<NewsListResultModel>.self).subscribe(onSuccess: { (result) in
                if result.ERRORCODE == "0" {
                    single(.success(result.RESULT!.newsList! as [NewsListModel]))
                } else {
                    LCZPrint("错误")
                }
            }) { (error) in
                single(.error(error))
            }
            return Disposables.create([request])
        })
    }
}
