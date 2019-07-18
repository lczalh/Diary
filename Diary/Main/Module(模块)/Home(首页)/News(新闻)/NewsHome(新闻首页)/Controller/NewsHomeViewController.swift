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
    
    var listContainerView: JXCategoryListContainerView!
    
    var models: Array<SpeedNewsListModel> = []
    
    let viewModel = NewsHomeViewModel()
    
    /// 起始新闻数量
    var start: Int = 0
    
    /// 存储每个view中的数据
    var datas: NSMutableDictionary = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 返回按钮
        let returnBarButtonItem = UIBarButtonItem(image: UIImage(named: "zuojiantou")?.withRenderingMode(.alwaysOriginal), style: .plain, target: nil, action: nil)
        self.navigationItem.leftBarButtonItem = returnBarButtonItem
        returnBarButtonItem.rx.tap.subscribe(onNext: { () in
            UIView.transition(with: (self.view ?? nil)!, duration: 0.5, options: .transitionFlipFromRight, animations: {
                self.tabBarController?.dismiss(animated: true, completion: nil)
            }, completion: nil)
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
        
        self.viewModel.getNewsTypeListData()
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .userInitiated))
            .observeOn(MainScheduler.instance)
            .subscribe(onSuccess: { (items) in
                self.categorys = items
                self.newsHomeView.categoryView!.titles = self.categorys
                self.newsHomeView.categoryView?.reloadData()
                self.listContainerView.reloadData()
        }) { [weak self] (error) in
                self!.categorys = self!.viewModel.newsItems
                self!.newsHomeView.categoryView!.titles = self!.categorys
                self!.newsHomeView.categoryView?.reloadData()
                self!.listContainerView.reloadData()
        }.disposed(by: rx.disposeBag)
    }
    
    

}


// MARK: - JXCategoryViewDelegate
extension NewsHomeViewController: JXCategoryViewDelegate {
    
    func categoryView(_ categoryView: JXCategoryBaseView!, scrollingFromLeftIndex leftIndex: Int, toRightIndex rightIndex: Int, ratio: CGFloat) {
        self.listContainerView.scrolling(fromLeftIndex: leftIndex, toRightIndex: rightIndex, ratio: ratio, selectedIndex: newsHomeView.categoryView!.selectedIndex)
    }
    
    func categoryView(_ categoryView: JXCategoryBaseView!, didSelectedItemAt index: Int) {
        self.listContainerView.didClickSelectedItem(at: index)
        // 获取当前索引的view
        let viewDictionary = self.listContainerView.validListDict! as NSDictionary
        if let listView = viewDictionary.object(forKey: index) as? NewsHomeListView, let datas = self.datas.object(forKey: index) as? [SpeedNewsListModel] {
            // 获取当前view中的数据
            self.models = datas
            listView.tableView.reloadData()
        }
        
        
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
        //
        self.start = 0
        // 内容视图
        let newsHomeListView = NewsHomeListView(frame:listContainerView.bounds)
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
            let view = viewDictionary.object(forKey: self!.newsHomeView.categoryView!.selectedIndex) as? NewsHomeListView
            if view == nil  {
                self!.reloadData(view: newsHomeListView, index: index)
            } else {
                self!.reloadData(view: view!, index: self!.newsHomeView.categoryView!.selectedIndex)
            }
        }

        return (newsHomeListView as JXCategoryListContentViewDelegate)
    }
    
    /// 下拉刷新
    @objc private func dropDownRefresh() {
        let viewDictionary = self.listContainerView.validListDict! as NSDictionary
        let view = viewDictionary.object(forKey: newsHomeView.categoryView!.selectedIndex) as! NewsHomeListView
        self.start = 0
        self.viewModel.getNewsListData(channel: self.categorys![self.newsHomeView.categoryView!.selectedIndex],
                                       start: self.start)
                      .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .userInitiated))
                      .observeOn(MainScheduler.instance)
                      .subscribe(onSuccess: { (models) in
                            self.datas.setValue(models, forKey: "\(self.newsHomeView.categoryView!.selectedIndex)")
                            self.models = models
                            view.tableView.mj_header.endRefreshing()
                            view.tableView.reloadData()
                       }) { (error) in
                            view.tableView.mj_header.endRefreshing()
                       }.disposed(by: rx.disposeBag)
    }
    
    /// 上拉刷新
    @objc private func pullToRefresh() {
        let viewDictionary = self.listContainerView.validListDict! as NSDictionary
        let view = viewDictionary.object(forKey: newsHomeView.categoryView!.selectedIndex) as! NewsHomeListView
        let datas = self.datas.object(forKey: newsHomeView.categoryView!.selectedIndex) as! [SpeedNewsListModel]
        self.start += 20
        self.viewModel.getNewsListData(channel: self.categorys![self.newsHomeView.categoryView!.selectedIndex],
                                       start: self.start)
                      .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .userInitiated))
                      .observeOn(MainScheduler.instance)
                      .subscribe(onSuccess: { (models) in
                            self.datas.setValue(datas + models, forKey: "\(self.newsHomeView.categoryView!.selectedIndex)")
                            self.models = datas + models
                            view.tableView.mj_footer.endRefreshing()
                            view.tableView.reloadData()
                      }) { (error) in
                            view.tableView.mj_footer.endRefreshing()
                      }.disposed(by: rx.disposeBag)
    }
    
    private func reloadData(view: NewsHomeListView, index: Int) {
        view.isSkeletonable = true
        view.showAnimatedGradientSkeleton(usingGradient: SkeletonGradient(baseColor: UIColor.clouds),animation: GradientDirection.topLeftBottomRight.slidingAnimation())
        self.viewModel.getNewsListData(channel: self.categorys![index],
                                       start: self.start)
                      .subscribe(onSuccess: { (models) in
                            self.datas.setValue(models, forKey: "\(index)")
                            self.models = models
                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: {
                                view.tableView.reloadData()
                                view.hideSkeleton()
                            })
                      }) { (error) in
                            DispatchQueue.main.async(execute: {
                                view.hideSkeleton()
                            })
                      }.disposed(by: rx.disposeBag)
        LCZPrint("12341242")
    }
    
}

extension NewsHomeViewController: SkeletonTableViewDataSource {
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
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "NewsHomeCell"
    }
}

extension NewsHomeViewController: SkeletonTableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = self.models[indexPath.row]
        diaryRoute.push("diary://homeEntrance/newsHome/newsDetails" ,context: model)
    }
}
