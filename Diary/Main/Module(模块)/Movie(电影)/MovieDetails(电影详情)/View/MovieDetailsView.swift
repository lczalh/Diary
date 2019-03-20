//
//  MovieDetailsView.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/3/20.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit
import WebKit

class MovieDetailsView: DiaryBaseView {
    
    public var webView: WKWebView!
    
    override func configUI() {
        // 创建网页配置对象
        let config = WKWebViewConfiguration()
        // 创建设置对象
        let preference = WKPreferences()
        // 最小字体大小
        preference.minimumFontSize = 10
        //是否允许不经过用户交互由javaScript自动打开窗口
        preference.javaScriptCanOpenWindowsAutomatically = true
        preference.javaScriptEnabled = true
        config.preferences = preference
        // 是使用h5的视频播放器在线播放, 还是使用原生播放器全屏播放
        config.allowsInlineMediaPlayback = true
        // 设置是否允许画中画技术 在特定设备上有效
        config.allowsPictureInPictureMediaPlayback = true
        
        webView = WKWebView(frame: self.bounds, configuration: config)
        self.addSubview(webView)
    }
}
