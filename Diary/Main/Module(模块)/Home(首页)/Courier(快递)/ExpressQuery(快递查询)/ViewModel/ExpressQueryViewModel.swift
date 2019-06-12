//
//  ExpressQueryViewModel.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/6/12.
//  Copyright © 2019 lcz. All rights reserved.
//

import Foundation

class ExpressQueryViewModel {
    
    /// 查询快递物流信息
    ///
    /// - Parameter number: 快递单号
    /// - Returns: 物流信息
    public func inquireExpressLogisticsInfo(number: String) -> Single<ExpressQueryResultModel> {
        LCZProgressHUD.show(title: "查询中。。。")
        return Single<ExpressQueryResultModel>.create(subscribe: { (single) -> Disposable in
            let request = networkServicesProvider.rx.requestData(target: MultiTarget(NewsNetworkServices.getExpressLogisticsInfo(appkey: jiSuShuJuAppKey, type: "auto", number: number)), model: SpeedNewsRootModel<ExpressQueryResultModel>.self).subscribe(onSuccess: { (result) in
                LCZProgressHUD.dismiss()
                if result.status == 0 {
                    single(.success(result.result!))
                } else {
                    LCZProgressHUD.showError(title: result.msg)
                    single(.error(DiaryRequestError.requestTimeout))
                }
            }, onError: { (error) in
                LCZProgressHUD.dismiss()
                single(.error(error))
                LCZProgressHUD.showError(title: "似乎已断开与互联网的连接")
            })
            return Disposables.create([request])
        })

    }
    
    
}
