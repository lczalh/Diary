//
//  FunnyPicturesViewController.swift
//  Diary
//
//  Created by glgl on 2019/7/26.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class FunnyPicturesViewController: DiaryBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 返回按钮
        let returnBarButtonItem = UIBarButtonItem(image: UIImage(named: "zuojiantou")?.withRenderingMode(.alwaysOriginal), style: .plain, target: nil, action: nil)
        self.navigationItem.leftBarButtonItem = returnBarButtonItem
        returnBarButtonItem.rx.tap.subscribe(onNext: { () in
            UIView.transition(with: (self.view ?? nil)!, duration: 0.5, options: .transitionFlipFromRight, animations: {
                self.tabBarController?.dismiss(animated: true, completion: nil)
            }, completion: nil)
        }).disposed(by: rx.disposeBag)
       
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
