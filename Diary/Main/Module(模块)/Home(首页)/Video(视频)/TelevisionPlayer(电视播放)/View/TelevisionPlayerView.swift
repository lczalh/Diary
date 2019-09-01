//
//  TelevisionPlayerView.swift
//  Diary
//
//  Created by glgl on 2019/7/17.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class TelevisionPlayerView: DiaryBaseView {
    
    
    /// 播放器视图
    public lazy var controlView: ZFPlayerControlView = {
        let view = ZFPlayerControlView()
        view.fastViewAnimated = true
        view.effectViewShow = false
        view.prepareShowLoading = true
        return view
    }()
    
    /// 播放控制器
    public var playerController: ZFPlayerController?
    
    
    /// 播放管理
    public lazy var playerManager: ZFAVPlayerManager = {
        let manager = ZFAVPlayerManager()
        return manager
    }()
    
    override func configUI() {
        playerController = ZFPlayerController(playerManager: playerManager, containerView: cz_LastWindow()!)
        playerController?.isWWANAutoPlay = true
        self.playerController?.controlView = self.controlView
        self.playerController?.orientationObserver.supportInterfaceOrientation = .landscape
        self.playerController?.enterFullScreen(true, animated: false)
    }
}
