//
//  DiaryNetworkServices.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/2/13.
//  Copyright © 2019 lcz. All rights reserved.
//

import Foundation

/// 定义分类
public enum NewsNetworkServices {
    
    // MARK: - 获取新闻数据
    case getNewsList(appKey: String, category: String, page: Int)
    
    // MARK: - 获取所有新闻类型数据
    case getNewsTypeList(appKey: String)
    
    // MARK: - 获取新闻详情
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
            
        case .getNewsList:
            return "api/news/list"
        case .getNewsTypeList:
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
            
        case .getNewsList(let appKey, let category, let page):
            parameterDict["appKey"] = appKey
            parameterDict["category"] = category
            parameterDict["page"] = page
            break
        case .getNewsTypeList(let appKey):
            parameterDict["appKey"] = appKey
        case .getNewsDetails(let appKey, let newsId):
            parameterDict["appKey"] = appKey
            parameterDict["newsId"] = newsId
        }
        
        return  .requestParameters(parameters: parameterDict, encoding: URLEncoding.default)
    }
    
    
    //请求头
    public var headers: [String : String]? {
        return nil
    }
    
    
}



