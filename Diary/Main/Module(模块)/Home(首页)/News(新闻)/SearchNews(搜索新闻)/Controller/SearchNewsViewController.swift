//
//  SearchNewsViewController.swift
//  Diary
//
//  Created by glgl on 2019/7/24.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class SearchNewsViewController: DiaryBaseViewController {
    
    private lazy var searchNewsView: SearchNewsView = {
        let view = SearchNewsView(frame: self.view.bounds)
        view.tableView.delegate = self
        view.tableView.dataSource = self
        return view
    }()
    
    /// 新闻数据
    private var models: Array<SpeedNewsListModel> = []
    
    /// 搜索的内容
    public var searchContent: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "搜索详情"
        
        self.view.addSubview(searchNewsView)
        view.isSkeletonable = true
        view.showAnimatedGradientSkeleton(usingGradient: SkeletonGradient(baseColor: UIColor.clouds),animation: GradientDirection.topLeftBottomRight.slidingAnimation())
        let viewModel = SearchNewsViewModel()
        viewModel.getSearchNewsData(keyword: self.searchContent)
                 .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .userInitiated))
                 .observeOn(MainScheduler.instance).subscribe(onSuccess: {[weak self] (models) in
                        self!.models = models
                        self!.searchNewsView.tableView.reloadData()
                        self!.view.hideSkeleton()
                  }) {[weak self] (error) in
                        self!.view.hideSkeleton()
                  }.disposed(by: rx.disposeBag)
        
        self.searchNewsView.tableView.lcz_reloadClick = { [weak self] sender in
            self!.view.isSkeletonable = true
            self!.view.showAnimatedGradientSkeleton(usingGradient: SkeletonGradient(baseColor: UIColor.clouds),animation: GradientDirection.topLeftBottomRight.slidingAnimation())
            viewModel.getSearchNewsData(keyword: self!.searchContent)
                .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .userInitiated))
                .observeOn(MainScheduler.instance).subscribe(onSuccess: {[weak self] (models) in
                    self!.models = models
                    self!.searchNewsView.tableView.reloadData()
                    self!.view.hideSkeleton()
                }) {[weak self] (error) in
                    self!.view.hideSkeleton()
                }.disposed(by: self!.rx.disposeBag)
        }
    }

}

extension SearchNewsViewController: SkeletonTableViewDataSource {
    
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
            cell.timeLabel.text = LCZPublicHelper.shared.getUpdateTimeToCurrennTime(timeStamp: LCZPublicHelper.shared.getTimeToTimeStamp(time: element.time!))
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
extension SearchNewsViewController: SkeletonTableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = self.models[indexPath.row]
        diaryRoute.push("diary://homeEntrance/newsHome/newsDetails" ,context: model)
    }
}
