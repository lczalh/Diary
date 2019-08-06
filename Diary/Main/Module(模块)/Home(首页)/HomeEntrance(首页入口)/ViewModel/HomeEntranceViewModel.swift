//
//  HomeEntranceViewModel.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/6/10.
//  Copyright © 2019 lcz. All rights reserved.
//

import Foundation

class HomeEntranceViewModel {
    
    /// 轮播图图片
    public let shufflingFigureImage: Array<String> = ["1","2","3","4","5","6","7"]
    
    /// 单元格标题
    public lazy var cellTitles: Array<Array<String>> = {
        if diaryApple() == true {
            return [["快递","新闻"]
            ]
        } else {
            return [["快递","新闻","人脸识别","笑话","菜谱"],
                    ["视频"]
            ]
        }
    }()
    
    /// 单元格图标
    public lazy var cellImages: Array<Array<String>> = {
        if diaryApple() == true {
            return [
                ["xingqiu","bangzhu"]
            ]
        } else {
            return [
                ["xingqiu","bangzhu","renlianshibie","xiaohua","bangzhu"],
                ["shipin"]
            ]
        }
    }()
    
    /// 分组标题
    public lazy var sectionTitles: Array<String> = {
        if diaryApple() == true {
            return ["休闲服务"]
        } else {
            return ["生活服务","休闲娱乐"]
        }
    }()
    
    /// 分组图标
    public lazy var sectionImages: Array<String> = {
        if diaryApple() == true {
            return ["kcb_hangyeicon"]
        } else {
            return ["kcb_hangyeicon","yule"]
        }
    }()
    

}
