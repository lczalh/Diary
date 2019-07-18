//
//  TelevisionPlayerViewController.swift
//  Diary
//
//  Created by glgl on 2019/7/17.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class TelevisionPlayerViewController: DiaryBaseViewController {
    
    public var model: TelevisionCellModel?
    
    var televisionPlayerView: TelevisionPlayerView!

    override func viewDidLoad() {
        super.viewDidLoad()
        televisionPlayerView = TelevisionPlayerView(frame: self.view.bounds)
        self.view.addSubview(televisionPlayerView)
        self.televisionPlayerView.playerManager.assetURL = URL(string: (model?.playUrl!)!)!
        self.televisionPlayerView.controlView.showTitle(model?.title, cover: model?.image?.isEmpty == false ? UIImage(data: try! Data(contentsOf: URL(string: model!.image!)!)) : nil, fullScreenMode: .automatic)
        
        // 返回
        self.televisionPlayerView.controlView.backBtnClickCallback = { [weak self] in
            self!.televisionPlayerView.playerController?.enterFullScreen(false, animated: false)
            self!.televisionPlayerView.playerController?.stop()
            self?.navigationController?.popViewController(animated: true)
            
        }
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.televisionPlayerView.playerController?.isViewControllerDisappear = false
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.televisionPlayerView.playerController?.isViewControllerDisappear = true
    }

    // 设置状态栏颜色
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if self.televisionPlayerView != nil {
            if self.televisionPlayerView.playerController!.isFullScreen {
                return .lightContent
            }
            return .default
        }
        return .default
    }

    override var prefersStatusBarHidden: Bool {
        if self.televisionPlayerView != nil {
            return self.televisionPlayerView.playerController!.isStatusBarHidden
        } else {
            return false
        }
    }

    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }
    
    // 是否支持屏幕旋转
    override var shouldAutorotate: Bool {
        if self.televisionPlayerView != nil {
            return self.televisionPlayerView.playerController!.shouldAutorotate
        } else {
            return false
        }
        
    }
    
    // 支持的屏幕旋转方向
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }

    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .landscapeRight
    }

}
