//
//  DiaryNetworkServices.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/2/13.
//  Copyright © 2019 lcz. All rights reserved.
//

import Foundation

//初始化provider
let networkServicesProvider = MoyaProvider<MultiTarget>(requestClosure : timeoutClosure,plugins:[RequestHudPlugin])

/// 定义分类
public enum NewsNetworkServices {
    
    // MARK: - 获取新闻数据
    case getNewsList(appKey: String, category: String)
    
    // MARK: - 获取所有新闻类型数据
    case getNewsTypeList(appKey: String)
    
    case getNewsDetails(appKey: String, newsId: String)
}

//设置请求配置
extension NewsNetworkServices : TargetType {
    
    //服务器地址
    public var baseURL: URL {
        
        return URL(string:"http://api.shujuzhihui.cn/")!
    }
    
    //各个请求的具体路径
    public var path: String {
        
        switch self {
            
        case .getNewsList(_,_):
            return "api/news/list"
        case .getNewsTypeList(_):
            return "api/news/categories"
        case .getNewsDetails:
            return "api/news/detail"
        }
        
    }
    
    //请求类型
    public var method: Moya.Method {
        
        return .post
    }
    
    //这个就是做单元测试模拟的数据，只会在单元测试文件中有作用
    public var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    //请求任务事件
    public var task: Task {
        // 请求通用参数
        var parameterDict: [String : Any] = Dictionary()
        switch self {
            
        case .getNewsList(let appKey, let category):
            
            parameterDict["appKey"] = appKey
            parameterDict["category"] = category
            break
        case .getNewsTypeList(let appKey):
            parameterDict["appKey"] = appKey
        case .getNewsDetails(let appKey, let newsId):
            parameterDict["appKey"] = appKey
            parameterDict["newsId"] = newsId
        }
        
        
        //print(pa)
        return  .requestParameters(parameters: parameterDict, encoding: URLEncoding.default)
    }
    
    
    //请求头
    public var headers: [String : String]? {
        return nil
    }
    
    
}

/// 设置接口的超时时间
let timeoutClosure = { (endpoint : Endpoint,closure : MoyaProvider<NewsNetworkServices>.RequestResultClosure) -> Void in
    
    if var urlRequest = try? endpoint.urlRequest() {
        urlRequest.timeoutInterval = 10
        closure(.success(urlRequest))
    }
    else{
        closure(.failure(MoyaError.requestMapping(endpoint.url)))
    }
}


/// 管理网络状态的插件
let RequestHudPlugin = NetworkActivityPlugin { change, target  in
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
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
    case .ended:
        // LCZHUDTool.dismiss()
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}


public extension Reactive where Base: MoyaProviderType {
    
    public func requestData<T: Mappable>(target: Base.Target, model: T.Type, callbackQueue: DispatchQueue? = nil) -> Single<T> {
        let response: Single<Response> = Single.create { [weak base] single in
            let cancellableToken = base?.request(target, callbackQueue: callbackQueue, progress: nil) { result in
                switch result {
                case let .success(response):
                    single(.success(response))
                case let .failure(error):
                    single(.error(error))
                }
            }
            return Disposables.create {
                cancellableToken?.cancel()
            }
        }
        return Single<T>.create(subscribe: { (single) -> Disposable in
            let request = response.mapObject(T.self).subscribe(onSuccess: { (result) in
                single(.success(result))
            }, onError: { (error) in
                single(.error(error))
            })
            return Disposables.create([request])
        })
    }
}
