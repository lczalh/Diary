//
//  ExpressQueryViewModel.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/6/12.
//  Copyright © 2019 lcz. All rights reserved.
//

import Foundation

class ExpressQueryViewModel {
    // 文件管理器
    private let fileManger = FileManager.default
    
    // 历史查询记录路径
    public let historyQueryPlist = LCZPublicHelper.shared.getDocumentPath + "/historyQuery.plist"
    
    /// 查询快递物流信息
    ///
    /// - Parameter number: 快递单号
    /// - Returns: 物流信息
    public func inquireExpressLogisticsInfo(number: String) -> Single<ExpressQueryResultModel> {
        LCZProgressHUD.show(title: "查询中")
        return Single<ExpressQueryResultModel>.create(subscribe: { (single) -> Disposable in
            let request = networkServicesProvider.rx.requestData(target: MultiTarget(HighSpeedDataNetworkServices.getExpressLogisticsInfo(appkey: highSpeedDataAppKey, type: "auto", number: number)), model: SpeedNewsRootModel<ExpressQueryResultModel>.self).subscribe(onSuccess: { (result) in
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
    
    /// 存储历史查询
    ///
    /// - Parameter text: 存储内容
    public func storeHistoryQuery(text: String) {
        // 判断文件是否存在
        if fileManger.fileExists(atPath: historyQueryPlist) == true {//存在
            let historyQueryMutableArray = NSArray(contentsOfFile: historyQueryPlist)?.mutableCopy() as! NSMutableArray
            historyQueryMutableArray.insert(text, at: 0)
            historyQueryMutableArray.write(toFile: historyQueryPlist, atomically: true)
        } else { // 不存在
            let historyQueryArray: NSArray = [text]
            historyQueryArray.write(toFile: historyQueryPlist, atomically: true)
        }
    }
    
    /// 获取存储的历史记录
    ///
    /// - Returns: 历史记录
    public func getHistoryQuery() -> NSArray {
        // 判断文件是否存在
        if fileManger.fileExists(atPath: historyQueryPlist) == true {//存在
            return NSArray(contentsOfFile: historyQueryPlist)!
        } else {
            return []
        }
        
    }
    
    
}
