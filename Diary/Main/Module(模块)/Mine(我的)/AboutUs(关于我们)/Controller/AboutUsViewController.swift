//
//  AboutUsViewController.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/6/24.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class AboutUsViewController: DiaryBaseViewController {
    
    lazy var aboutUsView: AboutUsView = {
        let view = AboutUsView(frame: self.view.bounds)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "关于我们"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: cz_HexadecimalColor(hexadecimal: AppTitleColor)]
        self.view.addSubview(aboutUsView)
    }
    

    

}
