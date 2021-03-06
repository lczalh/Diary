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
    
    // 获取新闻列表数据
    public func getNewsListData(channel: String, start: Int, result: @escaping (_ result: Result<[SpeedNewsListModel], Error>) -> Void, disposeBag: DisposeBag)  {
        networkServicesProvider
            .rx
            .lczRequest(target: MultiTarget(HighSpeedDataNetworkServices.getNewsList(appkey: highSpeedDataAppKey,
                                                                                     channel: channel,
                                                                                     num: 20,
                                                                                     start: start)),
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
    
    // 获取新闻类型列表数据
    public func getNewsTypeListData(result: @escaping (_ result: Result<[String], Error>) -> Void, disposeBag: DisposeBag) {
        networkServicesProvider
            .rx
            .lczRequest(target: MultiTarget(HighSpeedDataNetworkServices.getNewsTypeList(appkey: highSpeedDataAppKey)),
                        model: SpeedNewschannelModel.self).debug()
            .subscribe(onNext: { (model) in
                if model.status == 0 {
                    result(.success(model.result))
                } else {
                    LCZProgressHUD.showError(title: model.msg)
                    result(.failure(DiaryRequestError.requestCodeError(message: model.msg)))
                }
            }, onError: { (error) in
                result(.failure(error))
            }).disposed(by: disposeBag)
    }
    
//    public func request(result: @escaping (_ result: Result<SpeedNewschannelModel, Error>) -> Void, disposeBag: DisposeBag, model1: SpeedNewschannelModel.Type) {
//        networkServicesProvider
//            .rx
//            .lczRequest(target: MultiTarget(HighSpeedDataNetworkServices.getNewsTypeList(appkey: highSpeedDataAppKey)),
//                        model: model1).debug()
//            .subscribe(onNext: { (model) in
//                if model.status == 0 {
//                    result(.success(model))
//                } else {
//                    LCZProgressHUD.showError(title: model.msg)
//                    result(.failure(DiaryRequestError.requestCodeError(message: model.msg)))
//                }
//            }, onError: { (error) in
//                result(.failure(error))
//            }).disposed(by: disposeBag)
//    }
    
}
