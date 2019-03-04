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
        self.parentView = NewsDetailsView(frame: (self.viewIfLoaded?.bounds)!)
        self.view.addSubview(self.parentView)
        
        let viewModel = NewsDetailsViewModel(input: (self.newsId, self.newsTitle), dependency: (disposeBag: rx.disposeBag, networkService: NewsDetailsNetworkService()))
        
        // 获取新闻详情数据
        viewModel.newsDetailsData.drive(onNext: { [weak self] (model) in
            DispatchQueue.main.async {
                self?.parentView.webView.loadHTMLString("<html><head></head><body>\(model.content!)</body></html>", baseURL: nil);
            }
        }).disposed(by: rx.disposeBag)
        
        
    }
    
    

}
