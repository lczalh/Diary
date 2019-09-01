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
    cz_Print(target.baseURL, target.path, target.task)
    return MoyaProvider.defaultEndpointMapping(for: target)
}


/// 自定义插件
final class RequestAlertPlugin: PluginType {
    
    /// 开始发起请求。我们可以在这里显示网络状态指示器。
    func willSend(_ request: RequestType, target: TargetType) {
        cz_Print("开始发起网络请求")
    }
    
    /// 收到请求响应。我们可以在这里根据结果自动进行一些处理，比如请求失败时将失败信息告诉用户，或者记录到日志中。
    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        cz_Print("收到网络请求响应")
        switch result {
        case .success(_):
        
            break
        case .failure(let error):
            LCZProgressHUD.showError(title: "\(error.errorDescription!)")
            break
        }
    }
    
    /// 处理请求结果。我们可以在 completion 前对结果进行进一步处理。
    func process(_ result: Result<Response, MoyaError>, target: TargetType) -> Result<Response, MoyaError> {
        cz_Print("处理网络请求结果")
//        let a = networkServicesProvider.request(MultiTarget(HighSpeedDataNetworkServices.getNewsTypeList(appkey: highSpeedDataAppKey)), completion: { (rs) in
//            return rs
//        })
//        switch result {
//        case .success(let value):
//            print(value)
//            break
//        case .failure(let error):
//            print(error)
//            break
//        }
        return result
    }
    
    /// 准备发起请求。我们可以在这里对请求进行修改，比如再增加一些额外的参数。
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
      //  networkServicesProvider.rx.lcz
        cz_Print("准备发起网络请求")
       // String(data: request.httpBody!, encoding: .utf8)
        return request
    }
}

