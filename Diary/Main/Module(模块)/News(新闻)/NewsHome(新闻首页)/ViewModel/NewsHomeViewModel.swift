//
//  NewsHomeViewModel.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/3/27.
//  Copyright © 2019 lcz. All rights reserved.
//

import Foundation

class NewsHomeViewModel {
    
    /// 新闻类型数据
    let newsDictionary: NSDictionary = ["top":"头条",
                                "shehui":"社会",
                                "guonei":"国内",
                                "guoji":"国际",
                                "yule":"娱乐",
                                "tiyu":"体育",
                                "junshi":"军事",
                                "keji":"科技",
                                "caijing":"财经",
                                "shishang":"时尚"]
    
    // 创建文件路径 用于存储新闻类型 此时沙盒中并没有plist文件  要写入plist文件才存在
    let newsTypeListPlistPath = LCZDocumentPath! + "/newsTypeList.plist"
    
    /// 获取本地新闻类型数据
    public func getLocalNewsTypeList() -> [String] {
        let newsTypeList = NSArray(contentsOfFile: newsTypeListPlistPath) as? [String]
        return newsTypeList == nil ? [] : newsTypeList!
    }
}
