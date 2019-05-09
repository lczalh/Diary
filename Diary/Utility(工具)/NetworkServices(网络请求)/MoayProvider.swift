//
//  MoayP.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/3/22.
//  Copyright © 2019 lcz. All rights reserved.
//

import Foundation

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
        //根据不同的请求，是否显示加载框
        //        switch target as! Intelligent {
        
        //        case .shufflingFigure(let version):
        //            break
        //        case .verifyAccount(let loginName, let passwd):
        //            LCZHUDTool.show()
        //            break
        //        case .replacePicture(let photo, let version, let uid, let token):
        //            break
        //        case .functionModule(let version, let uid, let token, let id):
        //            break
        //
        //        }
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
        
        
    case .ended:
        // LCZHUDTool.dismiss()
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
    LCZPrint(target.baseURL, target.path, target.task)
    return MoyaProvider.defaultEndpointMapping(for: target)
}
