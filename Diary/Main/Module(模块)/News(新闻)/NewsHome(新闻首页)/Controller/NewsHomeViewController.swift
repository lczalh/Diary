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
    
    /// 当前类别
    var currentCategory: Observable<String>?
    
    var listContainerView: JXCategoryListContainerView!
    
    let newsHomeNetworkReachabilityManager = NetworkReachabilityManager(host: "http://www.baidu.com")

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "新闻"
        
        // 主视图
        self.newsHomeView = NewsHomeView(frame: self.view.bounds)
        self.newsHomeView.categoryView!.delegate = self
        view.addSubview(newsHomeView)

        // 滚动控件
        listContainerView = JXCategoryListContainerView(delegate: self)
        listContainerView!.frame = CGRect(x: 0,
                                          y: 44,
                                          width: LCZWidth,
                                          height: LCZHeight - LCZNaviBarHeight - LCZStatusBarHeight - 44 - LCZTabbarHeight)
        listContainerView!.defaultSelectedIndex = 0
        newsHomeView.addSubview(listContainerView!)
        newsHomeView.categoryView!.contentScrollView = listContainerView!.scrollView;
        
        let viewModel = NewsHomeViewModel()
        
        // 实时检测网络状态
        newsHomeNetworkReachabilityManager?.startListening()
        newsHomeNetworkReachabilityManager?.listener = { _ in
            if self.categorys?.isEmpty == true {
                // 获取最新的新闻类型数据
                self.newsHomeNetworkService.getNewsTypeListData()
                    .asDriver(onErrorJustReturn: viewModel.getLocalNewsTypeList())
                    .drive(onNext: { [weak self] (items) in
                        // 写入数据
                        (items as NSArray).write(toFile: viewModel.newsTypeListPlistPath, atomically: true)
                        DispatchQueue.main.async(execute: {
                            self!.categorys = items
                            self!.newsHomeView.categoryView!.titles = items
                            self!.newsHomeView.categoryView?.reloadData()
                            self!.listContainerView.reloadData()
                        })
                    }).disposed(by: self.rx.disposeBag)
            }
        }
    
        
        
    }
    
    

}


// MARK: - JXCategoryViewDelegate
extension NewsHomeViewController: JXCategoryViewDelegate {
    
    func categoryView(_ categoryView: JXCategoryBaseView!, scrollingFromLeftIndex leftIndex: Int, toRightIndex rightIndex: Int, ratio: CGFloat) {
        self.listContainerView.scrolling(fromLeftIndex: leftIndex, toRightIndex: rightIndex, ratio: ratio, selectedIndex: newsHomeView.categoryView!.selectedIndex)
    }
    
    func categoryView(_ categoryView: JXCategoryBaseView!, didSelectedItemAt index: Int) {
        self.listContainerView.didClickSelectedItem(at: index)
        currentCategory = Observable.just(self.categorys![index])
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
        currentCategory = Observable.just(self.categorys![index])
        // viewModel
        let viewModel = NewsHomeListViewModel(input: (headerRefresh: newsHomeListView.tableView.mj_header.rx.refreshing.asDriver(),
                                                  footerRefresh: newsHomeListView.tableView.mj_footer.rx.refreshing.asDriver(),
                                                  currentCategory: currentCategory!),
                                          dependency: (disposeBag: rx.disposeBag,
                                                  networkService: NewsHomeNetworkService(),
                                                  dataValidation: NewsHomeDataValidation()))
        
        // 下拉刷新状态结束的绑定
        viewModel.endHeaderRefreshing
            .drive(newsHomeListView.tableView.mj_header.rx.endRefreshing)
            .disposed(by: rx.disposeBag)
        
        // 上拉刷新状态结束的绑定
        viewModel.endFooterRefreshing
            .drive(newsHomeListView.tableView.mj_footer.rx.endRefreshing)
            .disposed(by: rx.disposeBag)
     
        // 创建数据源
        let dataSource = RxTableViewSectionedAnimatedDataSource
            <AnimatableSectionModel<String, NewsListModel>>(configureCell: {
                (dataSource, tv, indexPath, element) in
                let cell = tv.dequeueReusableCell(withIdentifier: "NewsHomeCell", for: indexPath) as! NewsHomeCell
                cell.titleLabel.text = element.title
                if element.newsImg?.isEmpty == false {
                    cell.newsImageView.kf.indicatorType = .activity
                    cell.newsImageView.kf.setImage(with: ImageResource(downloadURL: URL(string: element.newsImg!)!))
                }
                if element.publishTime?.isEmpty == false {
                    cell.timeLabel.text = LCZUpdateTimeToCurrennTime(timeStamp: LCZTimeToTimeStamp(time: element.publishTime!))
                }
                cell.sourceLabel.text = element.source
                return cell
            })
        
        // 数据绑定
        viewModel.tableData.map {
            [AnimatableSectionModel(model: "", items: $0)]}
            .bind(to: newsHomeListView.tableView.rx.items(dataSource: dataSource))
            .disposed(by: rx.disposeBag)
        
        // 同时获取索引和模型
        Observable.zip(newsHomeListView.tableView.rx.itemSelected, newsHomeListView.tableView.rx.modelSelected(NewsListModel.self))
            .bind { indexPath, item in
                diaryRoute.push("diary://newsHome/newsDetails" ,context: item)
            }.disposed(by: rx.disposeBag)
        
        return (newsHomeListView as JXCategoryListContentViewDelegate)
    }
    
}
