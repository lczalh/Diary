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
    
    
    override func configUI() {
        
        controlView = ZFPlayerControlView()
        controlView.portraitControlView.titleLabel.frame = CGRect(x: 0, y: 20, width: LCZWidth, height: 30)
        controlView.fastViewAnimated = true
        
        playerView = UIImageView(frame: CGRect(x: 0, y: LCZStatusBarHeight, width: LCZWidth, height: 215))
        self.addSubview(playerView)
        
        playerController = ZFPlayerController(playerManager: ZFAVPlayerManager(), containerView: playerView)
        playerController.controlView = controlView
        playerController.shouldAutoPlay = false;
        
        playerButton = UIButton()
        playerView.addSubview(playerButton);
        playerButton.setImage(UIImage(named: "MoviePlayer"), for: .normal)
        playerButton.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }
}
