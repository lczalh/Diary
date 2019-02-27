//
//  NewsHomeViewController.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/2/13.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class NewsHomeViewController: DiaryBaseViewController {
    
    /// 主视图
    var newsHomeView: NewsHomeView!
    
    /// 所有类别
    var categorys: Array<String>? = Array()
    
    /// 网络服务
    let newsHomeNetworkService = NewsHomeNetworkService()
    
    
    var listContainerView: JXCategoryListContainerView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "新闻"
        
        // 主视图
        self.newsHomeView = NewsHomeView(frame: self.view.bounds)
        self.newsHomeView.categoryView!.delegate = self
        view.addSubview(newsHomeView)
        
        // 滚动控件
        listContainerView = JXCategoryListContainerView(parentVC: self, delegate: self)
        listContainerView!.frame = CGRect(x: 0,
                                          y: 44 + LCZNaviBarHeight + LCZStatusBarHeight,
                                          width: LCZWidth,
                                          height: LCZHeight - LCZNaviBarHeight - LCZStatusBarHeight - 44 - LCZTabbarHeight)
        listContainerView!.defaultSelectedIndex = 0
        newsHomeView.addSubview(listContainerView!)
        newsHomeView.categoryView!.contentScrollView = listContainerView!.scrollView;
        
        
        self.newsHomeNetworkService.getNewsTypeListData().asDriver(onErrorJustReturn: []).drive(onNext: { (items) in
            DispatchQueue.main.async(execute: {
                self.categorys = items
                self.newsHomeView.categoryView!.titles = items
                self.newsHomeView.categoryView?.reloadData()
                self.listContainerView.reloadData()
            })
        }).disposed(by: rx.disposeBag)
        
        
    }
    

}


// MARK: - JXCategoryViewDelegate
extension NewsHomeViewController: JXCategoryViewDelegate {
    
    func categoryView(_ categoryView: JXCategoryBaseView!, scrollingFromLeftIndex leftIndex: Int, toRightIndex rightIndex: Int, ratio: CGFloat) {
        self.listContainerView.scrolling(fromLeftIndex: leftIndex, toRightIndex: rightIndex, ratio: ratio, selectedIndex: newsHomeView.categoryView!.selectedIndex)
    }
    
    func categoryView(_ categoryView: JXCategoryBaseView!, didSelectedItemAt index: Int) {
        self.listContainerView.didClickSelectedItem(at: index)
    }

}

// MARK: - JXCategoryListContainerViewDelegate
extension NewsHomeViewController: JXCategoryListContainerViewDelegate {
    
    func number(ofListsInlistContainerView listContainerView: JXCategoryListContainerView!) -> Int {
        return (self.categorys?.count)!
    }
    
    func listContainerView(_ listContainerView: JXCategoryListContainerView!, initListFor index: Int) -> JXCategoryListContentViewDelegate! {
        // 内容视图
        let newsHomeListView = NewsHomeListView(frame:listContainerView.bounds)
        listContainerView.didAppearPercent = 0.99
        
        // viewModel
        let viewModel = NewsHomeViewModel(input: (headerRefresh: newsHomeListView.tableView.mj_header.rx.refreshing.asDriver(),
                                                  footerRefresh: newsHomeListView.tableView.mj_footer.rx.refreshing.asDriver(),
                                                  currentCategory: self.categorys![index]),
                                          dependency: (disposeBag: rx.disposeBag,
                                                  networkService: NewsHomeNetworkService()))
        
        // 下拉刷新状态结束的绑定
        viewModel.endHeaderRefreshing
            .drive(newsHomeListView.tableView.mj_header.rx.endRefreshing)
            .disposed(by: rx.disposeBag)
        
        // 上拉刷新状态结束的绑定
        viewModel.endFooterRefreshing
            .drive(newsHomeListView.tableView.mj_footer.rx.endRefreshing)
            .disposed(by: rx.disposeBag)
        
        // 创建数据源
        let dataSource = RxTableViewSectionedReloadDataSource
            <SectionModel<String, NewsListModel>>(configureCell: {
                (dataSource, tv, indexPath, element) in
                let cell = tv.dequeueReusableCell(withIdentifier: "NewsHomeCell", for: indexPath) as! NewsHomeCell
                cell.title.text = element.title
                cell.imageV.kf.indicatorType = .activity
                if element.newsImg?.isEmpty == false {
                    cell.imageV.kf.setImage(with: ImageResource(downloadURL: URL(string: element.newsImg!)!))
                }
                cell.time.text = LCZUpdateTimeToCurrennTime(timeStamp: LCZTimeToTimeStamp(time: element.publishTime!))
                cell.source.text = element.source
                return cell
            })
        
        // 数据绑定
        viewModel.tableData.map {
            [SectionModel(model: "", items: $0)]}
            .bind(to: newsHomeListView.tableView.rx.items(dataSource: dataSource))
            .disposed(by: rx.disposeBag)
        
        // 同时获取索引和模型
        Observable.zip(newsHomeListView.tableView.rx.itemSelected, newsHomeListView.tableView.rx.modelSelected(NewsListModel.self))
            .bind { indexPath, item in
                diaryRoute.push("diary://newsHome/newsDetails/\(item.newsId!)")
            }.disposed(by: rx.disposeBag)
        
        return (newsHomeListView as JXCategoryListContentViewDelegate)
    }
    
}
