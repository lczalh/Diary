//
//  NewsDetailsViewController.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/2/26.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit
import WebKit

class NewsDetailsViewController: DiaryBaseViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        createWKWebView()
    }
    
    private func createWKWebView() -> Void {
        let webView = WKWebView(frame: self.view.bounds)
        self.view.addSubview(webView)
        webView.load(URLRequest(url: URL(string: "")!))
    }

}
