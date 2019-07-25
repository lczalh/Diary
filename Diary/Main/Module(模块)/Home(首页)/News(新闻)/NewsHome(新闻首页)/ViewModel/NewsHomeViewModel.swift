//
//  NewsHomeViewModel.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/3/27.
//  Copyright © 2019 lcz. All rights reserved.
//

import Foundation

class NewsHomeViewModel {
    
    /// 新闻类型数据
    let newsItems: Array<String> = [
        "头条",
        "新闻",
        "财经",
        "体育",
        "娱乐",
        "军事",
        "教育",
        "科技",
        "NBA",
        "股票",
        "星座",
        "女性",
        "健康",
        "育儿"
    ]
    
    // 获取新闻类型列表数据
    public func getNewsTypeListData() -> Single<[String]> {
        return Single<[String]>.create(subscribe: { (single) -> Disposable in
            let request = networkServicesProvider.rx.requestData(target: MultiTarget(HighSpeedDataNetworkServices.getNewsTypeList(appkey: highSpeedDataAppKey)), model: SpeedNewschannelModel.self).subscribe(onSuccess: { (result) in
                if result.status == 0 {
                    single(.success(result.result))
                } else {
                    LCZProgressHUD.showError(title: "暂无相关数据!")
                    single(.error(DiaryRequestError.requestTimeout))
                }
            }, onError: { (error) in
                single(.error(error))
            })
            return Disposables.create([request])
        })
    }
    
    // 获取新闻列表数据
    public func getNewsListData(channel: String, start: Int) -> Single<[SpeedNewsListModel]> {
        return Single<[SpeedNewsListModel]>.create(subscribe: { (single) -> Disposable in
            let request = networkServicesProvider.rx.requestData(target: MultiTarget(HighSpeedDataNetworkServices.getNewsList(appkey: highSpeedDataAppKey, channel: channel, num: 20, start: start)), model: SpeedNewsRootModel<SpeedNewsResultModel>.self).subscribe(onSuccess: { (result) in
                
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
