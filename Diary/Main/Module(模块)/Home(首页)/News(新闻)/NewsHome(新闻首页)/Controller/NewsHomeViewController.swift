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
 //   var currentCategory: String?
    
    var listContainerView: JXCategoryListContainerView!
    
    var models: Array<SpeedNewsListModel> = []
    
    let listViewModel = NewsHomeListViewModel()
    
    /// 起始新闻数量
    var start: Int = 0
    
    /// 存储每个view中的数据
    var datas: NSMutableDictionary = [:]
    
//    var itemSelectIndex: Int!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 返回按钮
        let returnBarButtonItem = UIBarButtonItem(image: UIImage(named: "zuojiantou")?.withRenderingMode(.alwaysOriginal), style: .plain, target: nil, action: nil)
        self.navigationItem.leftBarButtonItem = returnBarButtonItem
        returnBarButtonItem.rx.tap.subscribe(onNext: { () in
            self.tabBarController?.dismiss(animated: true, completion: nil)
        }).disposed(by: rx.disposeBag)
        
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        backBarButtonItem.tintColor = LCZHexadecimalColor(hexadecimal: "#FECE1D")
        self.navigationItem.backBarButtonItem = backBarButtonItem
        
        // 主视图
        self.newsHomeView = NewsHomeView(frame: self.view.bounds)
        self.newsHomeView.categoryView!.delegate = self
        view.addSubview(newsHomeView)

        // 滚动控件
        listContainerView = JXCategoryListContainerView(delegate: self)
        listContainerView!.frame = CGRect(x: 0,
                                          y: 44,
                                          width: LCZWidth,
                                          height: LCZHeight - LCZNaviBarHeight - LCZStatusBarHeight - 44)
        listContainerView!.defaultSelectedIndex = 0
        newsHomeView.addSubview(listContainerView!)
        newsHomeView.categoryView!.contentScrollView = listContainerView!.scrollView;
        
        let viewModel = NewsHomeViewModel()
        
        
        self.newsHomeNetworkService.getNewsTypeListData()
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .userInitiated)) //后台构建序列
            .observeOn(MainScheduler.instance)  //主线程监听并处理序列结果
            .asDriver(onErrorJustReturn: viewModel.newsItems )
            .drive(onNext: { (items) in
                self.categorys = items
                self.newsHomeView.categoryView!.titles = self.categorys
                self.newsHomeView.categoryView?.reloadData()
                self.listContainerView.reloadData()
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
        // 初始化时清空原有数据
        self.models.removeAll()
        // 内容视图
        let newsHomeListView = NewsHomeListView(frame:listContainerView.bounds)
        self.start = 0
        //设置头部刷新控件
        newsHomeListView.tableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(dropDownRefresh))
        //设置尾部刷新控件
        newsHomeListView.tableView.mj_footer = MJRefreshBackNormalFooter(refreshingTarget: self, refreshingAction: #selector(pullToRefresh))
        listContainerView.didAppearPercent = 0.99
        
        newsHomeListView.tableView.dataSource = self
        newsHomeListView.tableView.delegate = self
        
        reloadData(view: newsHomeListView, index: index)
        
        newsHomeListView.tableView.lcz_reloadClick = { [weak self] _ in
            let viewDictionary = listContainerView.validListDict! as NSDictionary
            var view = viewDictionary.object(forKey: self!.newsHomeView.categoryView!.selectedIndex) as? NewsHomeListView
            if view == nil  {
                view = newsHomeListView
            }
            self!.reloadData(view: newsHomeListView, index: index)
        }

        
        return (newsHomeListView as JXCategoryListContentViewDelegate)
    }
    
    /// 下拉刷新
    @objc private func dropDownRefresh() {
        let viewDictionary = self.listContainerView.validListDict! as NSDictionary
        let view = viewDictionary.object(forKey: newsHomeView.categoryView!.selectedIndex) as! NewsHomeListView
        self.start = 0
        self.listViewModel.getNewsListData(channel: self.categorys![self.newsHomeView.categoryView!.selectedIndex], start: self.start).subscribe(onSuccess: { (models) in
            self.datas.setValue(models, forKey: "\(self.newsHomeView.categoryView!.selectedIndex)")
            self.models = models
            DispatchQueue.main.async(execute: {
                view.tableView.mj_header.endRefreshing()
                view.tableView.reloadData()
            })
        }) { (error) in
            DispatchQueue.main.async(execute: {
                view.tableView.mj_header.endRefreshing()
            })
        }.disposed(by: rx.disposeBag)
    }
    
    /// 上拉刷新
    @objc private func pullToRefresh() {
        let viewDictionary = self.listContainerView.validListDict! as NSDictionary
        let view = viewDictionary.object(forKey: newsHomeView.categoryView!.selectedIndex) as! NewsHomeListView
        let datas = self.datas.object(forKey: newsHomeView.categoryView!.selectedIndex) as! [SpeedNewsListModel]
        self.start += 20
        self.listViewModel.getNewsListData(channel: self.categorys![self.newsHomeView.categoryView!.selectedIndex], start: self.start).subscribe(onSuccess: { (models) in
            self.datas.setValue(datas + models, forKey: "\(self.newsHomeView.categoryView!.selectedIndex)")
            self.models = datas + models
            DispatchQueue.main.async(execute: {
                view.tableView.mj_footer.endRefreshing()
                view.tableView.reloadData()
            })
        }) { (error) in
            DispatchQueue.main.async(execute: {
                view.tableView.mj_footer.endRefreshing()
            })
        }.disposed(by: rx.disposeBag)
    }
    
    private func reloadData(view: NewsHomeListView, index: Int) {
        self.listViewModel.getNewsListData(channel: self.categorys![index], start: self.start).subscribe(onSuccess: { (models) in
            self.datas.setValue(models, forKey: "\(index)")
            self.models = models
            DispatchQueue.main.async(execute: {
                view.tableView.reloadData()
            })
        }) { (error) in
            
        }.disposed(by: rx.disposeBag)
    }
    
}

extension NewsHomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsHomeCell", for: indexPath) as! NewsHomeCell
        let element = self.models[indexPath.row]
        cell.titleLabel.text = element.title
        if element.pic?.isEmpty == false {
            cell.newsImageView.kf.indicatorType = .activity
            cell.newsImageView.kf.setImage(with: ImageResource(downloadURL: URL(string: element.pic!)!), placeholder: UIImage(named: "zanwutupian"))
        } else {
            cell.newsImageView.image = UIImage(named: "zanwutupian")
        }
        
        if element.time?.isEmpty == false {
            cell.timeLabel.text = LCZUpdateTimeToCurrennTime(timeStamp: LCZTimeToTimeStamp(time: element.time!))
        } else {
            cell.timeLabel.text = ""
        }
        
        if element.category?.isEmpty == false {
            cell.sourceLabel.text = element.category
        } else {
            cell.sourceLabel.text = ""
        }
        
        return cell
    }
    
}

extension NewsHomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = self.models[indexPath.row]
        diaryRoute.push("diary://homeEntrance/newsHome/newsDetails" ,context: model)
    }
}
