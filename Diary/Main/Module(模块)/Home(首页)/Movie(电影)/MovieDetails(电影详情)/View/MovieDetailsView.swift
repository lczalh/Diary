//
//  MovieDetailsView.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/3/20.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit
import WebKit

class MovieDetailsView: DiaryBaseView {
    
    // 播放器内的视图
    var controlView: ZFPlayerControlView!
    
    // 播放器控制器
    var playerController: ZFPlayerController!
    
    /// 播放按钮
    var playerButton: UIButton!
    
    /// 播放视图
    var playerView: UIImageView!
    
    var tableView: UITableView!
    
    
    override func configUI() {
        createPlayerView();
        createTableView();
    }
    
    // MARK: - 播放器
    private func createPlayerView() {
        controlView = ZFPlayerControlView()
        controlView.fastViewAnimated = true
        
        playerView = UIImageView(frame: CGRect(x: 0, y: LCZStatusBarHeight, width: LCZWidth, height: 215))
        playerView.contentMode = .scaleAspectFill
        playerView.clipsToBounds = true
        self.addSubview(playerView)
        
        playerController = ZFPlayerController(playerManager: ZFAVPlayerManager(), containerView: playerView)
        playerController.controlView = controlView
        playerController.shouldAutoPlay = false;
        /// 设置退到后台继续播放
        playerController.pauseWhenAppResignActive = false
        /// 播放按钮
        playerButton = UIButton()
        playerView.addSubview(playerButton);
        playerButton.setImage(UIImage(named: "MoviePlayer"), for: .normal)
        playerButton.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }
    
    // MARK: - 集合视图
    private func createTableView() {
        
        tableView = UITableView(frame: CGRect(x: 0, y: self.playerView.frame.height + LCZStatusBarHeight, width: LCZWidth, height: LCZHeight - self.playerView.frame.height - LCZStatusBarHeight - LCZSafeAreaBottomHeight), style: .grouped)
        self.addSubview(tableView)
        tableView.register(SynopsisCell.self, forCellReuseIdentifier: "SynopsisCell")
        tableView.register(EpisodeCell.self, forCellReuseIdentifier: "EpisodeCell")
        tableView.register(MovieDetailsTableHeaderView.self, forHeaderFooterViewReuseIdentifier: "MovieDetailsTableHeaderView")
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 60
        
        
    }
}
