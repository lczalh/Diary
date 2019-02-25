//
//  NewsHomeNetworkService.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/2/22.
//  Copyright © 2019 lcz. All rights reserved.
//

import Foundation


class NewsHomeNetworkService {
    // 获取新闻列表数据
    public func getNewsListData(category: String) -> Single<[NewsListModel]> {
        return Single<[NewsListModel]>.create(subscribe: { (single) -> Disposable in
            let request = networkServicesProvider.rx.requestData(target: MultiTarget(NewsNetworkServices.getNewsList(appKey: "eb7906fea2824f61a26fab22c071fe9a", category: category)), model: NewsRootModel<NewsListResultModel>.self).subscribe(onSuccess: { (result) in
                if result.ERRORCODE == "0" {
                    LCZPrint(result.RESULT!.newsList!)
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
