//
//  MovieDetailsViewController.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/3/20.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit
import WebKit

class MovieDetailsViewController: DiaryBaseViewController {
    
    var movieDetailsView: MovieDetailsView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        movieDetailsView = MovieDetailsView(frame: self.view.bounds)
        self.view.addSubview(movieDetailsView)
        movieDetailsView.webView.navigationDelegate = self as WKNavigationDelegate
        movieDetailsView.webView.load(URLRequest(url: URL(string: "http://jqaaa.com/jx.php?url=https://v.qq.com/x/cover/6n89qmcgox3zflm.html")!))
    }
    


}

extension MovieDetailsViewController: WKNavigationDelegate {
    // 页面开始加载时调用
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        LCZProgressHUD.show()
    }
    // 页面加载失败时调用
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        LCZProgressHUD.dismiss()
    }
    // 当内容开始返回时调用
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        LCZProgressHUD.dismiss()
    }
    // 页面加载完成之后调用
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
    }
    // 根据WebView对于即将跳转的HTTP请求头信息和相关信息来决定是否跳转
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let str = navigationAction.request.url?.absoluteString
        LCZPrint(str)
        if (navigationAction.request.url?.absoluteString.count)! > 0 {
            // 过滤广告
            if ((str?.contains("ynjczy.net"))! || (str?.contains("ynjczy.net"))! || (str?.contains("662820.com"))! || (str?.contains("api.vparse.org"))! || (str?.contains("hyysvip.duapp.com"))! || (str?.contains("f.qcwzx.net.cn"))!) {
                decisionHandler(.cancel)
            } else {
                decisionHandler(.allow)
            }
        } else {
            decisionHandler(.cancel)
        }
    }
    
    
}
