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
        
        // 设置播放地址
        movieDetailsView.playerController.assetURLs = getMovieUrls()
        
        // 设置视频封面
        if self.movieHomeModel.vod_pic?.isEmpty == false {
            movieDetailsView.playerView.kf.setImage(with: ImageResource(downloadURL: URL(string: self.movieHomeModel.vod_pic!)!))
        }
        
        // 播放按钮的响应
        movieDetailsView.playerButton.rx.tap.subscribe { (sender) in
            self.movieDetailsView.playerController.playTheIndex(0)
            self.movieDetailsView.controlView.showTitle(self.movieHomeModel.vod_name, coverURLString: self.movieHomeModel.vod_pic, fullScreenMode: .landscape)
        }.disposed(by: rx.disposeBag)
        
        // ---------------------------------

        
        // 设置代理
        movieDetailsView.tableView.rx.setDelegate(self).disposed(by: rx.disposeBag)
        movieDetailsView.tableView.rx.setDataSource(self).disposed(by: rx.disposeBag)
        
    
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
        }
        return urls
    }
    
    @objc private func synopsisButtonAction(_ sender: UIButton) {

//        UIView.animate(withDuration: 2, animations: {
//            sender.imageView?.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
//        }) { (state) in
//            self.synopsisState = !self.synopsisState
//            self.movieDetailsView.tableView.reloadData()
//        }
        
        self.synopsisState = !self.synopsisState
        self.movieDetailsView.tableView.reloadData()
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
        } else if section == 1 {
            headerView.titleLabel?.text = "选集";
        }
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 100
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
            return 2
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
            //初始化数据
            let sections = Observable.just(self.getMovieUrls()).map{
                [SectionModel(model: "", items: $0)]
            }
            
            //创建数据源
            let dataSource = RxCollectionViewSectionedReloadDataSource<SectionModel<String, URL>>(
                configureCell: { (dataSource, collectionView, indexPath, element) in
                    let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectorEpisodeCell",
                                                                  for: indexPath) as! SelectorEpisodeCell
                    return cell1
                    
                }
            )
          
            //绑定单元格数据
            sections
                .bind(to: cell.collectionView.rx.items(dataSource: dataSource))
                .disposed(by: rx.disposeBag)
            return cell
        }
        
    }
    
 
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2;
    }
}




