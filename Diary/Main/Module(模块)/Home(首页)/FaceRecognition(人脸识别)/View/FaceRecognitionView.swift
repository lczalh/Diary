//
//  FaceRecognitionView.swift
//  Diary
//
//  Created by glgl on 2019/7/18.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class FaceRecognitionView: DiaryBaseView {
    
    public var middleView: UIView?

    override func configUI() {
        self.middleView = UIView(frame: CGRect(x: LCZWidth / 2 - 125, y: LCZHeight / 2 - 125, width: 250, height: 250))
        self.middleView?.backgroundColor = UIColor.purple
        self.addSubview(self.middleView!)
    }

}
