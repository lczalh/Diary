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
    public func getCommonExpressCompaniesData(result: @escaping (_ result: Result<[CourierEntranceModel], Error>) -> Void, disposeBag: DisposeBag) {
        networkServicesProvider
            .rx
            .lczRequest(target: MultiTarget(HighSpeedDataNetworkServices.getCourierCompany(appkey: highSpeedDataAppKey)),
                        model: CourierEntranceRootModel.self)
            .subscribe(onNext: { (model) in
                if model.status == 0 {
                    result(.success(model.result!))
                } else {
                    LCZProgressHUD.showError(title: model.msg)
                    result(.failure(DiaryRequestError.requestTimeout))
                }
            }, onError: { (error) in
                result(.failure(error))
            }).disposed(by: disposeBag)
    }
}
