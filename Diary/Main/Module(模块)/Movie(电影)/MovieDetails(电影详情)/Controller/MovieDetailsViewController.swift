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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieDetailsView = MovieDetailsView(frame: self.view.bounds)
        self.view.addSubview(movieDetailsView)
        // 暂时只播放一集
        let urlAry = self.movieHomeModel.vod_play_url?.components(separatedBy: CharacterSet(charactersIn: "$"))
        var url: String!
        if urlAry![1].contains(Character("#")) {
            url = urlAry![1].components(separatedBy: CharacterSet(charactersIn: "#"))[0]
        } else {
            url = urlAry![1]
        }
        let player = AVPlayer(url: URL(string: url)!)
        let playerController = AVPlayerViewController()
        playerController.view.frame = self.view.bounds
        playerController.player = player
        self.present(playerController, animated: true, completion: {
            playerController.player?.play()
        });
    }
    


}




