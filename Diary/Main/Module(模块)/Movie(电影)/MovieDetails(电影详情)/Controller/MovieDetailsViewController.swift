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
    
    var movieDetailsView: MovieDetailsView!
    
    var movieHomeModel: MovieHomeModel!
    
    
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
        
        movieDetailsView.playerController.assetURLs = getMovieUrls()
        if self.movieHomeModel.vod_pic?.isEmpty == false {
            movieDetailsView.playerView.kf.setImage(with: ImageResource(downloadURL: URL(string: self.movieHomeModel.vod_pic!)!))
        }
        
        // 播放按钮的响应
        movieDetailsView.playerButton.rx.tap.subscribe { (sender) in
            self.movieDetailsView.playerController.playTheIndex(0)
            self.movieDetailsView.controlView.showTitle(self.movieHomeModel.vod_name, coverURLString: self.movieHomeModel.vod_pic, fullScreenMode: .landscape)
        }.disposed(by: rx.disposeBag)
    
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
        LCZPrint(urls)
        return urls
    }

}




