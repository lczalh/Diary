//
//  NewsDetailsViewController.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/2/26.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class NewsDetailsViewController: DiaryBaseViewController {
    
    /// 新闻模型
    public var model: SpeedNewsListModel?
    
    /// 父视图
    private var parentView: NewsDetailsView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.parentView = NewsDetailsView(frame: CGRect(x: 0, y: 0, width: LCZWidth, height: LCZHeight - LCZNaviBarHeight - LCZStatusBarHeight - LCZSafeAreaBottomHeight))
        self.view.addSubview(self.parentView)
        
        let viewModel = NewsDetailsViewModel()
        
        self.parentView.webView.loadHTMLString(viewModel.jointHtml(model: model!), baseURL: nil)

    }
    
    

}
