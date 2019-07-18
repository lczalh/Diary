//
//  ResourceDownloader.swift
//  Diary
//
//  Created by glgl on 2019/7/18.
//  Copyright © 2019 lcz. All rights reserved.
//

import Foundation

//默认下载保存地址（用户文档目录）
public let resourcePath: URL = {
    let directoryURLs = FileManager.default.urls(for: .documentDirectory,
                                                 in: .userDomainMask)
    return directoryURLs.first ?? URL(fileURLWithPath: NSTemporaryDirectory())
}()

//资源分类
public enum Resource {
    case televisionJson  //电视JSON文件
}

//资源配置
extension Resource: TargetType {
    
    //根据枚举值获取对应的资源文件名
    var assetName: String {
        switch self {
        case .televisionJson: return "television.json"
        }
    }
    
    //获取对应的资源文件本地存放路径
    var localLocation: URL {
        return resourcePath.appendingPathComponent(assetName)
    }
    
    //服务器地址
    public var baseURL: URL {
        return URL(string: "https://www.letaoshijie.com/")!
    }
    
    //各个请求的具体路径
    public var path: String {
        return assetName
    }
    
    //请求类型
    public var method: Moya.Method {
        return .get
    }
    
    //定义一个DownloadDestination
    var downloadDestination: DownloadDestination {
        return { _, _ in return (self.localLocation, .removePreviousFile) }
    }
    
    //请求任务事件
    public var task: Task {
        return .downloadDestination(downloadDestination)
    }
    
    //是否执行Alamofire验证
    public var validate: Bool {
        return false
    }
    
    //这个就是做单元测试模拟的数据，只会在单元测试文件中有作用
    public var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8)!
    }
    
    //请求头
    public var headers: [String: String]? {
        return nil
    }
}
