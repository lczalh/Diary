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
    public let cellTitles: Array<Array<String>> = [["快递","新闻"],
                                                   ["视频"]
                                                  ]
    
    /// 单元格图标
    public let cellImages: Array<Array<String>> = [
                                                    ["xingqiu","bangzhu"],
                                                    ["shipin"]
                                                  ]
    
    /// 分组标题
    public let sectionTitles: Array<String> = ["生活服务","休闲娱乐"]
    
    /// 分组图标
    public let sectionImages: Array<String> = ["kcb_hangyeicon","yule"]
    
    /// 轮播图样式
    public let shufflingFigureTransformerTypes: [FSPagerViewTransformerType] = [.crossFading,
                                                                                .zoomOut,
                                                                                .depth,
                                                                                .linear,
                                                                                .overlap,
                                                                                .ferrisWheel,
                                                                                .invertedFerrisWheel,
                                                                                .coverFlow,
                                                                                .cubic]
}
