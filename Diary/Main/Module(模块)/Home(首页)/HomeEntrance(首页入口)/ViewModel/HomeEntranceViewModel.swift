//
//  HomeEntranceViewModel.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/6/10.
//  Copyright © 2019 lcz. All rights reserved.
//

import Foundation

class HomeEntranceViewModel {
    
    private let state = diaryApple()
    
    /// 轮播图图片
    public let shufflingFigureImage: Array<String> = ["1","2","3","4","5","6","7"]
    
    /// 单元格标题
//    public let cellTitles: Array<Array<String>> = [["快递","新闻"],
//                                                   ["视频"]
//                                                    ]
    
    public lazy var cellTitles: Array<Array<String>> = {
        if self.state == true {
            return [["快递","新闻"]
                   ]
        } else {
            return [["快递","新闻"],
                    ["视频"]
                   ]
        }
    }()
    
    /// 单元格图标
//    public let cellImages: Array<Array<String>> = [
//                                                    ["xingqiu","bangzhu"],
//                                                    ["shipin"]
//                                                  ]
    public lazy var cellImages: Array<Array<String>> = {
        if diaryApple() == true {
            return [
                    ["xingqiu","bangzhu"]
                   ]
        } else {
            return [
                    ["xingqiu","bangzhu"],
                    ["shipin"]
                   ]
        }
    }()
    
    
    /// 分组标题
//    public let sectionTitles: Array<String> = ["生活服务","休闲娱乐"]
    
    public lazy var sectionTitles: Array<String> = {
        if diaryApple() == true {
            return ["生活服务"]
        } else {
            return ["生活服务","休闲娱乐"]
        }
    }()
    
    /// 分组图标
//    public let sectionImages: Array<String> = ["kcb_hangyeicon","yule"]
    
    public lazy var sectionImages: Array<String> = {
        if diaryApple() == true {
            return ["kcb_hangyeicon"]
        } else {
            return ["kcb_hangyeicon","yule"]
        }
    }()
    
//    /// 轮播图样式
//    public let shufflingFigureTransformerTypes: [FSPagerViewTransformerType] = [.crossFading,
//                                                                                .zoomOut,
//                                                                                .depth,
//                                                                                .linear,
//                                                                                .overlap,
//                                                                                .ferrisWheel,
//                                                                                .invertedFerrisWheel,
//                                                                                .coverFlow,
//                                                                                .cubic]
}
