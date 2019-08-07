//
//  DiaryNetworkServices.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/2/13.
//  Copyright © 2019 lcz. All rights reserved.
//  极速数据接口

import Foundation

/// 定义分类
public enum HighSpeedDataNetworkServices {
    
    // MARK: - 获取新闻数据
    case getNewsList(appkey: String, channel: String, num: Int, start: Int)
    
    // MARK: - 获取所有新闻类型数据
    case getNewsTypeList(appkey: String)
    
    // MARK: - 查询快递物流信息
    case getExpressLogisticsInfo(appkey: String, type: String, number: String)
    
    // MARK: - 查询快递公司
    case getCourierCompany(appkey: String)
    
    case searchNews(appkey: String, keyword: String)
    
    // MARK: - 根据分类搜索
    case getFoodPrcipeList(appkey: String, classid: String, num: Int, start: Int)
    
    // MARK: - 获取所有菜谱类型（分类）数据
    case getFoodPrcipeTypeList(appkey: String)
    
    // MARK: - 根据菜品id获取菜品详情
    case getIdToFoodDetailInfo(appkey: String, id: String)
    
    // MARK: - 根据关键字搜索菜谱
    case searchFoodPrcipe(appkey: String, keyword: String , num: Int)
}

//设置请求配置
extension HighSpeedDataNetworkServices : TargetType {
    
    //服务器地址
    public var baseURL: URL {
        
        return URL(string:"https://api.jisuapi.com")!
    }
    
    //各个请求的具体路径
    public var path: String {
        
        switch self {
            
        case .getNewsList:
            return "/news/get"
        case .getNewsTypeList:
            return "/news/channel"
        case .getExpressLogisticsInfo:
            return "/express/query"
        case .getCourierCompany:
            return "/express/type"
        case .searchNews:
            return "/news/search"
        case .getFoodPrcipeList:
            return "recipe/byclass"
        case .getFoodPrcipeTypeList:
            return "/recipe/class"
        case .getIdToFoodDetailInfo:
            return "/recipe/detail"
        case .searchFoodPrcipe:
            return "/recipe/search"
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
        
        case .getNewsTypeList(let appkey):
            parameterDict["appkey"] = appkey
        
        case .getNewsList(let appkey, let channel, let num, let start):
            parameterDict["appkey"] = appkey
            parameterDict["channel"] = channel
            parameterDict["num"] = num
            parameterDict["start"] = start
        case .getExpressLogisticsInfo(let appkey, let type, let number):
            parameterDict["appkey"] = appkey
            parameterDict["type"] = type
            parameterDict["number"] = number
        case .getCourierCompany(let appkey):
            parameterDict["appkey"] = appkey
        case .searchNews(let appkey, let keyword):
            parameterDict["appkey"] = appkey
            parameterDict["keyword"] = keyword
            
        case .getFoodPrcipeTypeList(let appkey):
            parameterDict["appkey"] = appkey
            
        case .getFoodPrcipeList(let appkey, let classid, let num, let start):
            parameterDict["appkey"] = appkey
            parameterDict["classid"] = classid
            parameterDict["num"] = num
            parameterDict["start"] = start
            
        case .getIdToFoodDetailInfo(let appkey, let id):
            parameterDict["appkey"] = appkey
            parameterDict["id"] = id
            
        case .searchFoodPrcipe(let appkey, let keyword , let num):
            parameterDict["appkey"] = appkey
            parameterDict["keyword"] = keyword
            parameterDict["num"] = num
        }
        
        return  .requestParameters(parameters: parameterDict, encoding: URLEncoding.default)
    }
    
    
    //请求头
    public var headers: [String : String]? {
        return nil
    }
    
    
}



