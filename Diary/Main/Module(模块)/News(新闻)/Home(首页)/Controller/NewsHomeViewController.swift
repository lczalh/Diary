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
    
    var newsHomeListView: NewsHomeListView!
    
    var viewModel: NewsHomeViewModel?
    
    
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
        
        // 内容视图
        self.newsHomeListView = NewsHomeListView(frame:listContainerView.bounds)
        
        // viewModel
        viewModel = NewsHomeViewModel(input: (headerRefresh: newsHomeListView.tableView.mj_header.rx.refreshing.asDriver(),
                                              footerRefresh: newsHomeListView.tableView.mj_footer.rx.refreshing.asDriver()),
                                      dependency: (disposeBag: rx.disposeBag,
                                                   networkService: NewsHomeNetworkService()))
        
        // 设置栏目
        newsHomeView.categoryView!.titles = viewModel!.titles
        
        // 下拉刷新状态结束的绑定
        viewModel!.endHeaderRefreshing
            .drive(newsHomeListView.tableView.mj_header.rx.endRefreshing)
            .disposed(by: rx.disposeBag)
        
        // 上拉刷新状态结束的绑定
        viewModel!.endFooterRefreshing
            .drive(newsHomeListView.tableView.mj_footer.rx.endRefreshing)
            .disposed(by: rx.disposeBag)
        
        // 创建数据源
        let dataSource = RxTableViewSectionedReloadDataSource
            <SectionModel<String, NewsListModel>>(configureCell: {
                (dataSource, tv, indexPath, element) in
                let cell = tv.dequeueReusableCell(withIdentifier: "Cell")!
                cell.textLabel?.text = "\(indexPath.row)：\(element)"
                return cell
            })
        
        // 数据绑定
        viewModel!.tableData.map {
            [SectionModel(model: "", items: $0)]}
            .bind(to: self.newsHomeListView.tableView.rx.items(dataSource: dataSource))
            .disposed(by: rx.disposeBag)

        
        

        
        
    }
    

}


// MARK: - JXCategoryViewDelegate
extension NewsHomeViewController: JXCategoryViewDelegate {
    func categoryView(_ categoryView: JXCategoryBaseView!, didClickSelectedItemAt index: Int) {
        self.listContainerView.didClickSelectedItem(at: index)
    }
    
    func categoryView(_ categoryView: JXCategoryBaseView!, scrollingFromLeftIndex leftIndex: Int, toRightIndex rightIndex: Int, ratio: CGFloat) {
        self.listContainerView.scrolling(fromLeftIndex: leftIndex, toRightIndex: rightIndex, ratio: ratio, selectedIndex: newsHomeView.categoryView!.selectedIndex)
    }
}

// MARK: - JXCategoryListContainerViewDelegate
extension NewsHomeViewController: JXCategoryListContainerViewDelegate {
    
    func number(ofListsInlistContainerView listContainerView: JXCategoryListContainerView!) -> Int {
        return viewModel!.titles.count
    }
    
    func listContainerView(_ listContainerView: JXCategoryListContainerView!, initListFor index: Int) -> JXCategoryListContentViewDelegate! {
        
        
        return (self.newsHomeListView as JXCategoryListContentViewDelegate)
    }
    
}
