//
//  NewsDetailsView.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/2/27.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit
import WebKit

class NewsDetailsView: DiaryBaseView {
    
    var webView: WKWebView!
    

    override func configUI() {
        createWKWebView()
    }
    
    private func createWKWebView() -> Void {
        self.webView = WKWebView(frame: CGRect(x: 0, y: 0, width: LCZPublicHelper.shared.getScreenWidth!, height: LCZPublicHelper.shared.getScreenHeight! - LCZPublicHelper.shared.getSafeAreaBottomHeight - LCZPublicHelper.shared.getNavigationHeight! - LCZPublicHelper.shared.getStatusBarHeight!))
        self.addSubview(self.webView)
        
    }
}
