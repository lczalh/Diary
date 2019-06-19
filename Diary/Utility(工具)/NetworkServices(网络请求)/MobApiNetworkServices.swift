//
//  DiaryNetworkServices.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/6/17.
//  Copyright © 2019 lcz. All rights reserved.
//  MobApi接口

import Foundation

/// 定义分类
public enum MobApiNetworkServices {
    
    // MARK: - 用户登陆
    case userLogin(key: String, username: String, password: String)
    
    // MARK: - 用户注册
    case userRegister(key: String, username: String, password: String)
}

//设置请求配置
extension MobApiNetworkServices : TargetType {
    
    //服务器地址
    public var baseURL: URL {
        
        return URL(string:"http://apicloud.mob.com/")!
    }
    
    //各个请求的具体路径
    public var path: String {
        
        switch self {
            
        case .userLogin:
            return "user/login"
            
        case .userRegister:
            return "user/rigister"
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
            
        case .userLogin(let key, let username, let password):
            parameterDict["key"] = key
            parameterDict["username"] = username
            parameterDict["password"] = password
        case .userRegister(let key, let username, let password):
            parameterDict["key"] = key
            parameterDict["username"] = username
            parameterDict["password"] = password
        }
        
        return  .requestParameters(parameters: parameterDict, encoding: URLEncoding.default)
    }
    
    
    //请求头
    public var headers: [String : String]? {
        return nil
    }
    
    
}
