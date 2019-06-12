//
//  CommonlyExpressViewController.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/6/12.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class CommonlyExpressViewController: DiaryBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.navigationItem.title = "常用快递"
        self.tabBarController?.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: LCZHexadecimalColor(hexadecimal: "#57310C")]
    }
    

}
