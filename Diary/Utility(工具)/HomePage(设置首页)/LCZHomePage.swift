//
//  File.swift
//  LCZGlobalToolDemo
//
//  Created by 刘超正 on 2018/7/29.
//  Copyright © 2018年 刘超正. All rights reserved.
//

import Foundation
import UIKit

class LCZHomePage {
    
    /// 单利
    static let shared = LCZHomePage()
    
    /// 当前版本号
    private var currentVersion: String?
    
    private init() {}
    
    /// 设置引导页和首页
    ///
    /// - Parameters:
    ///   - guidePage: 设置引导页
    ///   - homePage: 设置首页
    public func setHomePage(guidePage: () -> (), homePage: () -> ()) {
        
        // 文件管理器
        let fileManger = FileManager.default
        
        // 获取沙盒 Document路径
        let documentPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
        
        // 创建文件路径 用于记录版本号 此时沙盒中并没有plist文件  要写入plist文件在存在
        let versionPlist = documentPath! + "/version.plist"
        
        // 判断文件是否存在
        if fileManger.fileExists(atPath: versionPlist) == true {//存在
            let fileDict = NSDictionary(contentsOfFile: versionPlist)
            // 获取字典中的版本号
            currentVersion = fileDict?.object(forKey: "CFBundleShortVersionString") as? String
        }
        
        // 判断是否第一次启动
        if currentVersion != LCZVersion { // 进入引导页
            // 把版本号存入字典
            let dict = NSDictionary(dictionary: ["CFBundleShortVersionString":LCZVersion!])
            // 把字典写入plist文件
            dict.write(toFile: versionPlist, atomically: true)
            guidePage()
        }else {
            // 进入首页
            homePage()
        }
        
    }
}
