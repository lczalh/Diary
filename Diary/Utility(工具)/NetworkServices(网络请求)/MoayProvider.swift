//
//  MoayP.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/3/22.
//  Copyright © 2019 lcz. All rights reserved.
//

import Foundation

/// 请求错误
///
/// - requestTimeout: 请求超时
enum DiaryRequestError: Error {
    case requestTimeout // 请求超时
    case requestFailed // 请求失败
}

//初始化provider
let networkServicesProvider = MoyaProvider<MultiTarget>(endpointClosure: endpointMapping, requestClosure: timeoutClosure, plugins:[RequestHudPlugin])

/// 设置接口的超时时间
private let timeoutClosure = { (endpoint : Endpoint,closure : MoyaProvider<MultiTarget>.RequestResultClosure) -> Void in
    if var urlRequest = try? endpoint.urlRequest() {
        urlRequest.timeoutInterval = 5
        closure(.success(urlRequest))
    }
    else{
        closure(.failure(MoyaError.requestMapping(endpoint.url)))
    }
}


/// 管理网络状态的插件
private let RequestHudPlugin = NetworkActivityPlugin { change, target  in
    switch change {
    case .began:
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
    case .ended:
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
    }
}

/// 打印请求地址，路径，参数
///
/// - Parameter target: target description
/// - Returns: return value description
private func endpointMapping(target: MultiTarget) -> Endpoint {
    LCZPublicHelper.shared.setPrint(target.baseURL, target.path, target.task)
    return MoyaProvider.defaultEndpointMapping(for: target)
}
