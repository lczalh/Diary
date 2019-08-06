//
//  CourierEntranceViewModel.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/6/14.
//  Copyright © 2019 lcz. All rights reserved.
//

import Foundation

class CourierEntranceViewModel {
    
    // 常用公司数据路径
    public let commonExpressCompaniesPlist = LCZPublicHelper.shared.getDocumentPath + "/commonExpressCompanies.plist"
    
    /// 获取常用快递公司数据
    ///
    /// - Returns: 常用快递公司
    public func getCommonExpressCompaniesData() -> Single<[CourierEntranceModel]> {
        return Single<[CourierEntranceModel]>.create(subscribe: { (single) -> Disposable in
            let requset = networkServicesProvider.rx.requestData(target: MultiTarget(HighSpeedDataNetworkServices.getCourierCompany(appkey: highSpeedDataAppKey)), model: CourierEntranceRootModel.self).subscribe(onSuccess: { (result) in
                if result.status == 0 {
                    single(.success(result.result!))
                } else {
                    LCZProgressHUD.showError(title: result.msg)
                    single(.error(DiaryRequestError.requestTimeout))
                }
            }, onError: { (error) in
                single(.error(error))
                LCZProgressHUD.showError(title: "似乎已断开与互联网的连接")
            })
            return Disposables.create([requset])
        })
    }
}
