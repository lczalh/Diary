//
//  LCZCacheTool.swift
//  360Intelligent
//
//  Created by 刘超正 on 2018/5/29.
//  Copyright © 2018年 刘超正. All rights reserved.
//

import UIKit

class LCZClearCache: NSObject {
    /// 计算缓存大小
    static var cacheSize: String{
        get{
            // 路径
            let basePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
            let fileManager = FileManager.default
            // 遍历出所有缓存文件加起来的大小
            func caculateCache() -> Float{
                var total: Float = 0
                if fileManager.fileExists(atPath: basePath!){
                    let childrenPath = fileManager.subpaths(atPath: basePath!)
                    if childrenPath != nil{
                        for path in childrenPath!{
                            let childPath = basePath!.appending("/").appending(path)
                            do{
                                let attr:NSDictionary = try fileManager.attributesOfItem(atPath: childPath) as NSDictionary
                                let fileSize = attr["NSFileSize"] as! Float
                                total += fileSize
                                
                            }catch _{
                                
                            }
                        }
                    }
                }
                // 缓存文件大小
                return total
            }
            // 调用函数
            let totalCache = caculateCache()
            return NSString(format: "%.2f MB", totalCache / 1024.0 / 1024.0 ) as String
        }
    }
    
    /// 清除缓存
    class func clearCache() {
        LCZProgressHUD.show(title: "清除缓存")
        // 取出cache文件夹目录 缓存文件都在这个目录下
        let cachePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
        // 取出文件夹下所有文件数组
        let fileArr = FileManager.default.subpaths(atPath: cachePath!)
        // 遍历删除
        for file in fileArr! {
            // 拼接文件路径
            let path = cachePath?.appending("/\(file)")
            if FileManager.default.fileExists(atPath: path!) {
                // 循环删除
                do {
                    try FileManager.default.removeItem(atPath: path!)
                } catch {
                    
                }
            }
        }
        LCZProgressHUD.dismiss()
        LCZProgressHUD.showSuccess(title: "清除成功")
    }
}
