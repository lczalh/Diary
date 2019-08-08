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
    public func getSearchNewsData(keyword: String,
                                   result: @escaping (_ result: Result<[SpeedNewsListModel], Error>) -> Void,
                                   disposeBag: DisposeBag) {
        networkServicesProvider
            .rx
            .lczRequest(target: MultiTarget(HighSpeedDataNetworkServices.searchNews(appkey: highSpeedDataAppKey,
                                                                                    keyword: keyword)),
                        model: SpeedNewsRootModel<SpeedNewsResultModel>.self)
            .subscribe(onNext: { (model) in
                if model.status == 0 {
                    result(.success(model.result!.list as [SpeedNewsListModel]))
                } else {
                    LCZProgressHUD.showError(title: model.msg)
                    result(.failure(DiaryRequestError.requestCodeError(message: model.msg)))
                }
            }, onError: { (error) in
                result(.failure(error))
            }).disposed(by: disposeBag)
    }
}
