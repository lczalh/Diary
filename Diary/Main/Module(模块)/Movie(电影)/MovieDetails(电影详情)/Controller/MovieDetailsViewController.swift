//
//  MovieDetailsViewController.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/3/20.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit
import WebKit
import AVFoundation
import AVKit

class MovieDetailsViewController: DiaryBaseViewController {
    
    var movieDetailsView: MovieDetailsView!
    
    var movieHomeModel: MovieHomeModel!
    
    var movieUrl: String?
    
    /// 视频的真实地址
    var movieRealAddress: String?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieDetailsView = MovieDetailsView(frame: self.view.bounds)
        self.view.addSubview(movieDetailsView)
        movieDetailsView.webView.navigationDelegate = self as WKNavigationDelegate
        movieDetailsView.webViewTwo.navigationDelegate = self as WKNavigationDelegate
        movieDetailsView.webView.load(URLRequest(url: URL(string: self.movieHomeModel.url)!))
        
        NotificationCenter.default.rx.notification(Notification.Name(rawValue: "movieRealAddressNotification")).subscribe { (notification) in
            
            LCZPrint(notification.element?.object! as! String)
            let player = AVPlayer(url: URL(string: notification.element?.object! as! String)!)
            let playerController = AVPlayerViewController()
            playerController.view.frame = self.view.bounds
            playerController.player = player
            self.present(playerController, animated: true, completion: {
                playerController.player?.play()
                URLProtocol.wk_unregisterScheme("http")
                URLProtocol.wk_unregisterScheme("https")
            });
        }.disposed(by: rx.disposeBag)
    }
    


}

extension MovieDetailsViewController: WKNavigationDelegate {
    // 页面开始加载时调用
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        URLProtocol.wk_registerScheme("http")
        URLProtocol.wk_registerScheme("https")
       // LCZProgressHUD.show()
    }
    // 页面加载失败时调用
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
       /// LCZProgressHUD.dismiss()
    }
    // 当内容开始返回时调用
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        
       // LCZProgressHUD.dismiss()
    }
    // 页面加载完成之后调用
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        if webView == movieDetailsView.webView {
            if self.movieUrl?.isEmpty == false {
                movieDetailsView.webViewTwo.load(URLRequest(url: URL(string: "https://jx.618g.com/?url=\(self.movieUrl!)")!))
            }
        } else if webView == movieDetailsView.webViewTwo {
//            if self.movieRealAddress?.isEmpty == false {
//                let player = AVPlayer(url: URL(string: self.movieRealAddress!)!)
//                let playerController = AVPlayerViewController()
//                playerController.view.frame = self.view.bounds
//                playerController.player = player
//                self.present(playerController, animated: true, completion: {
//                    playerController.player?.play()
//                });
//            }
        }
        
    }
    // 根据WebView对于即将跳转的HTTP请求头信息和相关信息来决定是否跳转
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let urlStr = navigationAction.request.url?.absoluteString
       // LCZPrint(urlStr)
        if webView == movieDetailsView.webView {
            if urlStr!.contains("vid=") {
                self.movieUrl = urlStr
            }
        } else {
//            if urlStr!.contains(".mp4") || urlStr!.contains(".m3u8") {
//                self.movieRealAddress = urlStr?.components(separatedBy: CharacterSet(charactersIn: "="))[1]
//            }
        }
        decisionHandler(.allow)
    }
    
    
}


