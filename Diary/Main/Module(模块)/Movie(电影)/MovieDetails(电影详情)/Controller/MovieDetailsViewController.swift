//
//  MovieDetailsViewController.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/3/20.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit
import WebKit
import AVFoundation
import AVKit

class MovieDetailsViewController: DiaryBaseViewController {
    
    private var movieDetailsView: MovieDetailsView!
    
    public var movieHomeModel: MovieHomeModel!
    
    /// 简介状态 是否展开
    private var synopsisState: Bool = false
    
    /// 所有剧集地址
    private var movieUrls: Array<URL> = Array()
    
    /// 存储是否在播放状态 1:播放中 0:未播放
    private var playerIndexs: Array<String> = Array()
    
    /// 实用功能
    private var practicalFunctionArray: Array<String> = ["收藏","分享","下载","评论","上集","下集"]
    
    /// 实用功能状态 0:不点击 1:可点击
    private var practicalFunctionStateArray: Array<String> = []
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        movieDetailsView.playerController.isViewControllerDisappear = false;
        //设置导航栏背景透明
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        movieDetailsView.playerController.isViewControllerDisappear = true;
        //重置导航栏背景
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        self.navigationController?.navigationBar.shadowImage = nil
    }
    
    // 是否支持屏幕旋转
    override var shouldAutorotate: Bool {
        return movieDetailsView.playerController.shouldAutorotate
    }
    
    // 状态栏是否隐藏
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    // 状态栏动画
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }
    
    // 设置状态栏颜色
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if self.movieDetailsView != nil {
            if self.movieDetailsView.playerController.isFullScreen {
               return .lightContent
            }
            return .default
        }
        return .default
    }
    
    // 支持的屏幕旋转方向
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if movieDetailsView.playerController.isFullScreen {
            return .landscape
        }
        return .portrait
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieDetailsView = MovieDetailsView(frame: self.view.bounds)
        self.view.addSubview(movieDetailsView)
        
        // 获取所有播放地址
        self.movieUrls = getMovieUrls()
        // 设置播放地址
        movieDetailsView.playerController.assetURLs = self.movieUrls
        
        // 设置视频封面
        if self.movieHomeModel.vod_pic?.isEmpty == false {
            movieDetailsView.playerView.kf.setImage(with: ImageResource(downloadURL: URL(string: self.movieHomeModel.vod_pic!)!))
        }
        
        // 播放按钮的响应
        movieDetailsView.playerButton.rx.tap.subscribe { (sender) in
            // 修改第一集状态
            self.playerIndexs[0] = "1"
            // 获取集数cell 刷新集数状态
            let cell = self.movieDetailsView.tableView.cellForRow(at: IndexPath(row: 0, section: 1)) as! EpisodeCell
            cell.collectionView.reloadData()
            // 修改实用功能状态
            if self.movieUrls.count > 1 {
                self.practicalFunctionStateArray[5] = "1"
                let headerView = self.movieDetailsView.tableView.headerView(forSection: 0) as! MovieDetailsTableHeaderView
                headerView.collectionView.reloadData()
            }
            
            // 播放第一集
            self.movieDetailsView.playerController.playTheIndex(0)
            self.movieDetailsView.controlView.showTitle(self.movieHomeModel.vod_name, coverURLString: self.movieHomeModel.vod_pic, fullScreenMode: .landscape)
        }.disposed(by: rx.disposeBag)
        
        // 设置代理
        movieDetailsView.tableView.rx.setDelegate(self).disposed(by: rx.disposeBag)
        movieDetailsView.tableView.rx.setDataSource(self).disposed(by: rx.disposeBag)
        
        // 配置实用功能默认状态
        for (index,_) in self.practicalFunctionArray.enumerated() {
            if index == 4 || index == 5 {
                practicalFunctionStateArray.append("0")
            } else {
                practicalFunctionStateArray.append("1")
            }
        }
    }
    
    
    /// 获取当前电影所有地址
    ///
    /// - Returns: 返回所有电影地址
    private func getMovieUrls() -> Array<URL> {
        var urls = Array<URL>()
        let movieAry = self.movieHomeModel.vod_play_url?.components(separatedBy: CharacterSet(charactersIn: "#"))
        for eachEpisode in movieAry! {
            // 获取每集的播放地址
            let movieUrl = eachEpisode.components(separatedBy: CharacterSet(charactersIn: "$"))[1]
            urls.append(URL(string: movieUrl)!)
            // 默认没有播放任何一集电影
            playerIndexs.append("0")
        }
        return urls
    }
    
    // MARK: - 简介响应事件
    @objc private func synopsisButtonAction(_ sender: UIButton) {
        self.synopsisState = !self.synopsisState
        self.movieDetailsView.tableView.reloadSections([0], animationStyle: .fade)
    }

}


// MARK: - UITableViewDelegate
extension MovieDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "MovieDetailsTableHeaderView") as! MovieDetailsTableHeaderView
        if section == 0 {
            headerView.titleLabel?.text = self.movieHomeModel.vod_name;
            headerView.synopsisButton?.isHidden = false
            headerView.synopsisButton?.addTarget(self, action: #selector(synopsisButtonAction), for: .touchUpInside)
            headerView.synopsisButton?.isSelected = self.synopsisState
            headerView.otherInformationLabel.text = "热度 \(self.movieHomeModel.vod_score_all) / \(self.movieHomeModel.vod_score ?? "") / \(self.movieHomeModel.vod_class ?? "") / 更新至\(self.movieUrls.count)集"
            headerView.collectionView.isHidden = false
            headerView.movieDetailsTableHeaderViewDelegate = self
        } else if section == 1 {
            headerView.titleLabel?.text = "选集";
            headerView.synopsisButton?.isHidden = true
            headerView.collectionView.isHidden = true
        }
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 100 * LCZSizeScale
        } else {
            return 50
        }
    }
    
    
}

extension MovieDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            if self.synopsisState == false {
                return 0
            } else {
                return 1
            }
        } else {
            return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SynopsisCell", for: indexPath) as! SynopsisCell
            cell.directorLabel.text = "导演：\(self.movieHomeModel.vod_director?.isEmpty == true ? "未知" : self.movieHomeModel.vod_director!)"
            cell.actorLabel.text = "主演：\(self.movieHomeModel.vod_actor?.isEmpty == true ? "未知" : self.movieHomeModel.vod_actor!)"
            cell.synopsisLabel.text = self.movieHomeModel.vod_blurb
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "EpisodeCell", for: indexPath) as! EpisodeCell
            cell.episodeDelegate = self
            
            return cell
        }
        
    }
    
 
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2;
    }
}

extension MovieDetailsViewController: EpisodeCellDelegate {
    func episodeCollectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movieUrls.count
    }
    
    func episodeCollectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let selectorCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectorEpisodeCell",
                                                              for: indexPath) as! SelectorEpisodeCell
        selectorCell.episodeLabel.text = "\(indexPath.row + 1)"
        if self.playerIndexs[indexPath.row] == "0" { // 未播放
            selectorCell.episodeLabel.textColor = UIColor.black
        } else { // 播放中
            selectorCell.episodeLabel.textColor = LCZRgbColor(34, 123, 255, 1)
        }
        return selectorCell
    }
    
    func episodeCollectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // 设置播放状态
        for (index, _) in self.playerIndexs.enumerated() {
            if index == indexPath.row {
                self.playerIndexs[index] = "1"
            } else {
                self.playerIndexs[index] = "0"
            }
        }
        
        // 获取集数cell
        let cell = self.movieDetailsView.tableView.cellForRow(at: IndexPath(row: 0, section: 1)) as! EpisodeCell
        cell.collectionView.reloadData()
        
        // 播放当前选中的集数
        self.movieDetailsView.playerController.playTheIndex(indexPath.row)
        self.movieDetailsView.controlView.showTitle(self.movieHomeModel.vod_name, coverURLString: self.movieHomeModel.vod_pic, fullScreenMode: .landscape)
    }

}

extension MovieDetailsViewController: MovieDetailsTableHeaderViewCellDelegate {
    func movieDetailsTableHeaderViewCollectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.practicalFunctionArray.count
    }
    
    func movieDetailsTableHeaderViewCollectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PracticalFunctionCell", for: indexPath) as! PracticalFunctionCell
        cell.titleLabel.text = self.practicalFunctionArray[indexPath.row]
        
        if self.practicalFunctionStateArray[indexPath.row] == "1" { //
            cell.contentView.layer.borderColor = UIColor.black.cgColor
            cell.titleLabel.textColor = UIColor.black
        } else {
            cell.contentView.layer.borderColor = LCZRgbColor(243, 242, 243, 1).cgColor
            cell.titleLabel.textColor = LCZRgbColor(243, 242, 243, 1)
        }
        
        return cell
    }
    
    func movieDetailsTableHeaderViewCollectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        if indexPath.row == 0 { // 收藏
            
        } else if indexPath.row == 1 { // 分享
            
        } else if indexPath.row == 2 { // 下载
            
        } else if indexPath.row == 3 { // 评论
            
        } else if indexPath.row == 4 { // 上集
            
        } else if indexPath.row == 5 { // 下集
            
        }
    }
    
    
}

