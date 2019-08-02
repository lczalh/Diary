//
//  DiaryPopAnimation.swift
//  Diary
//
//  Created by glgl on 2019/8/2.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

class DiaryPopAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 2
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
//        let toViewController = transitionContext.viewController(forKey: .to)
//        let fromViewController = transitionContext.viewController(forKey: .from)
        let toView = transitionContext.view(forKey: .to)
        let fromView = transitionContext.view(forKey: .from)
        transitionContext.containerView.insertSubview(toView!, belowSubview: fromView!)
        UIView.transition(with: toView!, duration: self.transitionDuration(using: transitionContext), options: .transitionFlipFromLeft, animations: {
            fromView?.frame = CGRect(x: LCZPublicHelper.shared.getScreenWidth!, y: 0, width: LCZPublicHelper.shared.getScreenWidth!, height: LCZPublicHelper.shared.getScreenHeight!)
            toView?.frame = CGRect(x: 0, y: 0, width: LCZPublicHelper.shared.getScreenWidth!, height: LCZPublicHelper.shared.getScreenHeight!)
        }, completion: { _ in
            
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
//        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), animations: {
//            
//        }) { (b) in
//            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
//        }
    }
    

}
