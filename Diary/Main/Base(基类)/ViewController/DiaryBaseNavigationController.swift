//
//  DiaryBaseNavigationController.swift
//  Diary
//
//  Created by glgl on 2019/7/26.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class DiaryBaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // 禁用侧滑返回
        self.interactivePopGestureRecognizer?.isEnabled = false
        // 修改导航标题颜色
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: LCZPublicHelper.shared.getHexadecimalColor(hexadecimal: AppTitleColor)]
        self.delegate = self
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

extension DiaryBaseNavigationController: UINavigationControllerDelegate {
  
//    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
//
//    }
    
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .pop {
            return DiaryPopAnimation()
        } else if operation == .push {
            
        }
        return nil
    }
    
}
