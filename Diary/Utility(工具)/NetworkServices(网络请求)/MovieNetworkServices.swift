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
    case getMovieList(ac: String,pg: Int)
    // MARK: - 获取搜索的电影列表数据
    case getSearchMovieList(ac: String,pg: Int, wd: String)
    // MARK: - 用户登陆
    case userLogin(user_name: String, user_pwd: String)
    
    case userRegister(user_name: String, user_pwd: String, user_pwd2: String)
    //https://www.letaoshijie.com/reut.html
}

//设置请求配置
extension MovieNetworkServices : TargetType {
    
    //服务器地址
    public var baseURL: URL {
        
        return URL(string:"https://www.letaoshijie.com/")!
    }
    
    //各个请求的具体路径
    public var path: String {
        
        switch self {
            
        case .getMovieList:
            return "api.php/provide/vod/"
            
        case .getSearchMovieList:
            return "api.php/provide/vod/"
        case .userLogin:
            return "index.php/user/login"
        case .userRegister:
            return "index.php/user/reg"
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
            
        case .getMovieList(let ac,let pg):
            parameterDict["ac"] = ac
            parameterDict["pg"] = pg
            break
        case .getSearchMovieList(let ac, let pg, let wd):
            parameterDict["ac"] = ac
            parameterDict["pg"] = pg
            parameterDict["wd"] = wd
            break
        case .userLogin(let user_name, let user_pwd):
            parameterDict["user_name"] = user_name
            parameterDict["user_pwd"] = user_pwd
        case .userRegister(let user_name, let user_pwd, let user_pwd2):
            parameterDict["user_name"] = user_name
            parameterDict["user_pwd"] = user_pwd
            parameterDict["user_pwd2"] = user_pwd2
        }
        
        return  .requestParameters(parameters: parameterDict, encoding: URLEncoding.default)
    }
    
    
    //请求头
    public var headers: [String : String]? {
        return nil
    }
    
    
}
