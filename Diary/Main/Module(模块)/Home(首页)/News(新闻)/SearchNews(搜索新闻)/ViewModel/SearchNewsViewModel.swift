//
//  SearchNewsViewModel.swift
//  Diary
//
//  Created by glgl on 2019/7/24.
//  Copyright © 2019 lcz. All rights reserved.
//

import Foundation

class SearchNewsViewModel {
    
    // 获取新闻列表数据
    public func getSearchNewsData(keyword: String) -> Single<[SpeedNewsListModel]> {
        return Single<[SpeedNewsListModel]>.create(subscribe: { (single) -> Disposable in
            let request = networkServicesProvider.rx.requestData(target: MultiTarget(HighSpeedDataNetworkServices.searchNews(appkey: highSpeedDataAppKey, keyword: keyword)), model: SpeedNewsRootModel<SpeedNewsResultModel>.self).subscribe(onSuccess: { (result) in
                
                if result.status == 0 {
                    single(.success(result.result!.list as [SpeedNewsListModel]))
                } else {
                    LCZProgressHUD.showError(title: result.msg)
                    single(.error(DiaryRequestError.requestTimeout))
                }
            }) { (error) in
                single(.error(error))
            }
            return Disposables.create([request])
        })
    }
}
