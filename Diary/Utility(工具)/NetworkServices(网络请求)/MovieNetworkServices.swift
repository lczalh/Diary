//
//  MovieNetworkServices.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/3/22.
//  Copyright © 2019 lcz. All rights reserved.
//

import Foundation

/// 定义分类
public enum MovieNetworkServices {
    
    // MARK: - 获取电影列表数据
    case getMovieList(ac: String)
}

//设置请求配置
extension MovieNetworkServices : TargetType {
    
    //服务器地址
    public var baseURL: URL {
        
        return URL(string:"https://nsxiu.com/")!
    }
    
    //各个请求的具体路径
    public var path: String {
        
        switch self {
            
        case .getMovieList:
            return "api.php/provide/vod/"
        }
        
    }
    
    //请求类型
    public var method: Moya.Method {
        
        return .get
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
            
        case .getMovieList(let ac):
            parameterDict["ac"] = ac
            break
        }
        
        return  .requestParameters(parameters: parameterDict, encoding: URLEncoding.default)
    }
    
    
    //请求头
    public var headers: [String : String]? {
        return nil
    }
    
    
}
