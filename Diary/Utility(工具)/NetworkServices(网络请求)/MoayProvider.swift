//
//  MoayP.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/3/22.
//  Copyright © 2019 lcz. All rights reserved.
//

import Foundation

/// DiaryRequestError
enum DiaryRequestError: Error {
    case requestTimeout // 请求超时
    case requestCodeError(message: String?) // 请求失败
}

//初始化provider
let networkServicesProvider = MoyaProvider<MultiTarget>(endpointClosure: endpointMapping, requestClosure: timeoutClosure, plugins:[RequestHudPlugin,RequestAlertPlugin()])

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


final class RequestAlertPlugin: PluginType {
    
    init() {
    }
    
    //开始发起请求
    func willSend(_ request: RequestType, target: TargetType) {
        print(11111)
    }
    
//    func didReceive(_ result: Result.Result<Response, MoyaError>, target: TargetType) {
//        print(333)
//    }
    
    /// 准备发起请求。我们可以在这里对请求进行修改，比如再增加一些额外的参数。
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        print(3333)
       // String(data: request.httpBody!, encoding: .utf8)
        return request
    }
}

