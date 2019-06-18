//
//  LoginViewController.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/6/18.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class LoginViewController: DiaryBaseViewController {
    
    lazy var loginView: LoginView = {
        let view = LoginView(frame: self.view.bounds)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(loginView)
      
    }
    

   

}
