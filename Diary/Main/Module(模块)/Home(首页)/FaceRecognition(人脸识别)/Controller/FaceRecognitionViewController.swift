//
//  FaceRecognitionViewController.swift
//  Diary
//
//  Created by glgl on 2019/7/18.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class FaceRecognitionViewController: DiaryBaseViewController {
    
    private lazy var faceRecognitionView: FaceRecognitionView = {
        let view = FaceRecognitionView(frame: self.view.bounds)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.faceRecognitionView)
    }
    

    

}
