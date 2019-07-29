//
//  EnshrineNewsViewController.swift
//  Diary
//
//  Created by glgl on 2019/7/25.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class EnshrineNewsViewController: DiaryBaseViewController {
    
    private lazy var searchNewsView: SearchNewsView = {
        let view = SearchNewsView(frame: self.view.bounds)
        view.tableView.delegate = self
        view.tableView.dataSource = self
        return view
    }()
    
    /// 新闻数据
    private var models: Array<SpeedNewsListModel> = []
    
    private var viewModel = EnshrineNewsViewModel()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getLocalEnshrineData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(searchNewsView)
        
        self.searchNewsView.tableView.lcz_reloadClick = { sender in
            LCZProgressHUD.showError(title: "暂无收藏新闻")
        }
        
    }
    
    
    /// 读取本地数据 并刷新
    private func getLocalEnshrineData() {
        // 读取本地收藏数据
        let enshrineListJson = NSArray(contentsOfFile: viewModel.enshrineNewsPlist) // 读取本地数据
        if enshrineListJson != nil {
            self.models = Mapper<SpeedNewsListModel>().mapArray(JSONArray: enshrineListJson as! [[String : Any]])
            self.searchNewsView.tableView.reloadData()
        }
        
    }
    

}

extension EnshrineNewsViewController: SkeletonTableViewDataSource {
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

extension EnshrineNewsViewController: SkeletonTableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = self.models[indexPath.row]
        diaryRoute.push("diary://homeEntrance/newsHome/newsDetails" ,context: model)
    }
}
