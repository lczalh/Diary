//
//  NewsDetailsViewController.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/2/26.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class NewsDetailsViewController: DiaryBaseViewController {
    
    /// 新闻id
    public var newsId: String!
    
    /// 新闻标题
    public var newsTitle: String!
    
    /// 父视图
    private var parentView: NewsDetailsView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.parentView = NewsDetailsView(frame: CGRect(x: 0, y: 0, width: LCZWidth, height: LCZHeight - LCZNaviBarHeight - LCZStatusBarHeight - LCZSafeAreaBottomHeight))
        self.view.addSubview(self.parentView)
        
        let viewModel = NewsDetailsViewModel(input: (self.newsId, self.newsTitle), dependency: (disposeBag: rx.disposeBag, networkService: NewsDetailsNetworkService()))
        
        // 获取新闻详情数据
        viewModel.newsDetailsData.drive(onNext: { [weak self] (model) in
            DispatchQueue.main.async {
                LCZPrint(model.content)
                self?.parentView.webView.loadHTMLString(self!.jointHtml(model: model), baseURL: nil);
            }
        }).disposed(by: rx.disposeBag)
        
        
    }
    
    // 拼接html
    private func jointHtml(model: NewsDetailsModel) -> String {
        let html = """
        
        <!DOCTYPE html>
        <html data-dpr="1" style="font-size: 50px;">
        <head>
        <meta charset="UTF-8">
        <meta http-equiv="Cache-Control" content="no-transform">
        <meta http-equiv="Cache-Control" content="no-siteapp">
        <meta name="applicable-device" content="mobile">
        <meta name="theme-color" content="#ff3333">
        <meta name="cms_id" content="0040article_ssr_beta">
        <title>\(model.title!)</title>
        <meta name="viewport" content="initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no">
        <style>
        img {
        width: \(270 * LCZSizeScale)px;
        }
        </style>
        </script>
        <link href=\"https://static.ws.126.net/163/wap/f2e/touch-article-2018/run.7111fcd.css\" rel=\"stylesheet\"></head>
        <body>
        <script>\"use strict\";
        var Dpr = 1,
        uAgent = window.navigator.userAgent;
        var isIOS = uAgent.match(/iphone/i);
        var isYIXIN = uAgent.match(/yixin/i);
        var is2345 = uAgent.match(/Mb2345/i);
        var ishaosou = uAgent.match(/mso_app/i);
        var isSogou = uAgent.match(/sogoumobilebrowser/ig);
        var isLiebao = uAgent.match(/liebaofast/i);
        var isGnbr = uAgent.match(/GNBR/i);
        var $fixed = document.getElementById(\"fixed\");
        function resizeRoot() {
        var wWidth = (screen.width > 0) ? (window.innerWidth >= screen.width || window.innerWidth == 0) ? screen.width : window.innerWidth : window.innerWidth,
        wDpr, wFsize;
        var wHeight = (screen.height > 0) ? (window.innerHeight >= screen.height || window.innerHeight == 0) ? screen.height : window.innerHeight : window.innerHeight;
        if (window.devicePixelRatio) {
        wDpr = window.devicePixelRatio;
        } else {
        wDpr = isIOS ? wWidth > 818 ? 3 : wWidth > 480 ? 2 : 1 : 1;
        }
        if (isIOS) {
        wWidth = screen.width;
        wHeight = screen.height;
        }
        // if(window.orientation==90||window.orientation==-90){
        //     wWidth = wHeight;
        // }else if((window.orientation==180||window.orientation==0)){
        // }
        if (wWidth > wHeight) {
        wWidth = wHeight;
        }
        wFsize = wWidth > 1080 ? 144 : wWidth / 7.5;
        wFsize = wFsize > 32 ? wFsize : 32;
        if (wFsize > 100) wFsize = 100;
        window.screenWidth_ = wWidth;
        if (isYIXIN || is2345 || ishaosou || isSogou || isLiebao || isGnbr) { //YIXIN 和 2345 这里有个刚调用系统浏览器时候的bug，需要一点延迟来获取
        setTimeout(function () {
        wWidth = (screen.width > 0) ? (window.innerWidth >= screen.width || window.innerWidth == 0) ? screen.width : window.innerWidth : window.innerWidth;
        wHeight = (screen.height > 0) ? (window.innerHeight >= screen.height || window.innerHeight == 0) ? screen.height : window.innerHeight : window.innerHeight;
        wFsize = wWidth > 1080 ? 144 : wWidth / 7.5;
        wFsize = wFsize > 32 ? wFsize : 32;
        // document.getElementsByTagName('html')[0].dataset.dpr = wDpr;
        document.getElementsByTagName('html')[0].style.fontSize = wFsize + 'px';
        if ($fixed) {
        $fixed.style.display = "none";
        }
        }, 500);
        } else {
        // document.getElementsByTagName('html')[0].dataset.dpr = wDpr;
        document.getElementsByTagName('html')[0].style.fontSize = wFsize + 'px';
        if ($fixed) {
        $fixed.style.display = "none";
        }
        }
        // alert("fz="+wFsize+";dpr="+window.devicePixelRatio+";UA="+uAgent+";width="+wWidth+";sw="+screen.width+";wiw="+window.innerWidth+";wsw="+window.screen.width+window.screen.availWidth);
        }
        resizeRoot();

        var reviseViewPort = function (delay, times) {
        var _delay = delay || 200,
        count = 0,
        max_count = times || 5;
        var timer = setInterval(function () {
            var _width = (screen.width > 0) ? (window.innerWidth >= screen.width) ? screen.width : window.innerWidth : window.innerWidth,
            _wFsize;
            if (_width < window.screenWidth_) {
                window.screenWidth_ = _width;
                //$(window).trigger('viewPort:changed', _width);
                _wFsize = _width > 1080 ? 144 : _width / 7.5;
                _wFsize = _wFsize > 32 ? _wFsize : 32;
                document.getElementsByTagName('html')[0].style.fontSize = _wFsize + 'px';
                clearInterval(timer);
            } else {
                count++;
            }
            if (count >= max_count) {
                clearInterval(timer);
            }
        }, _delay);
        };
        
        reviseViewPort(200);</script>
        <div class="share_mask js-share-mask">
        </div>
        <header style="display: none">
        <div class="topbar" style="display: none"></div>
        </header>
        <!-- 通栏ad1 顶部通栏-->
        <div class="a_adtemp a_topad js-topad" style="display: none">
        </div>
        <main>
        <!--文章内容-->
        <article id="article-EBK8ES8E000189FH">
        <div class="head">
        <h1 class="title">\(model.title!))</h1>
        <div class="info">
        <span class="time js-time">\(model.publishTime!)</span>
        <span class="source js-source">\(model.source!)</span>
        </div>
        </div>
        <div class="content">
        <div class="page js-page on">
        \(model.content!)
        </div>
        </div>
        </article>
        </main>
        <footer>
        
        </footer>
        </body>
        </html>

        """
        return html
    }
    
    

}
