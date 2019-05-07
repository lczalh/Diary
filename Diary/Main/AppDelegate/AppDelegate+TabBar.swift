//
//  AppDelegate+TabBar.swift
//  PopularInformation
//
//  Created by 谷粒公社 on 2019/1/18.
//  Copyright © 2019 lcz. All rights reserved.
//

import Foundation

/// 自定义突tabbar按钮
class ExampleIrregularityContentView: ESTabBarItemContentView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print(frame.size.height)
        self.imageView.backgroundColor = UIColor.init(red: 23/255.0, green: 149/255.0, blue: 158/255.0, alpha: 1.0)
        self.imageView.layer.borderWidth = 1.0
        self.imageView.layer.borderColor = LCZRgbColor(238, 238, 238, 1).cgColor
        self.imageView.layer.cornerRadius = 25
        self.insets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let transform = CGAffineTransform.identity
        self.imageView.transform = transform
        self.superview?.bringSubviewToFront(self)
        
        textColor = UIColor.init(white: 255.0 / 255.0, alpha: 1.0)
        highlightTextColor = UIColor.init(white: 255.0 / 255.0, alpha: 1.0)
        iconColor = UIColor.init(white: 255.0 / 255.0, alpha: 1.0)
        highlightIconColor = UIColor.init(white: 255.0 / 255.0, alpha: 1.0)
        backdropColor = .clear
        highlightBackdropColor = .clear
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let p = CGPoint.init(x: point.x - imageView.frame.origin.x, y: point.y - imageView.frame.origin.y)
        return sqrt(pow(imageView.bounds.size.width / 2.0 - p.x, 2) + pow(imageView.bounds.size.height / 2.0 - p.y, 2)) < imageView.bounds.size.width / 2.0
    }
    
    override func updateLayout() {
        super.updateLayout()
        self.imageView.sizeToFit()
        self.imageView.center = CGPoint.init(x: self.bounds.size.width / 2.0, y: self.bounds.size.height / 2.0)
    }
    
    public override func selectAnimation(animated: Bool, completion: (() -> ())?) {
        let view = UIView.init(frame: CGRect.init(origin: CGPoint.zero, size: CGSize(width: 2.0, height: 2.0)))
        view.layer.cornerRadius = 1.0
        view.layer.opacity = 0.5
        view.backgroundColor = UIColor.init(red: 10/255.0, green: 66/255.0, blue: 91/255.0, alpha: 1.0)
        self.addSubview(view)
        playMaskAnimation(animateView: view, target: self.imageView, completion: {
            [weak view] in
            view?.removeFromSuperview()
            completion?()
        })
    }
    
    public override func reselectAnimation(animated: Bool, completion: (() -> ())?) {
        completion?()
    }
    
    public override func deselectAnimation(animated: Bool, completion: (() -> ())?) {
        completion?()
    }
    
    public override func highlightAnimation(animated: Bool, completion: (() -> ())?) {
        UIView.beginAnimations("small", context: nil)
        UIView.setAnimationDuration(0.2)
        let transform = self.imageView.transform.scaledBy(x: 0.8, y: 0.8)
        self.imageView.transform = transform
        UIView.commitAnimations()
        completion?()
    }
    
    public override func dehighlightAnimation(animated: Bool, completion: (() -> ())?) {
        UIView.beginAnimations("big", context: nil)
        UIView.setAnimationDuration(0.2)
        let transform = CGAffineTransform.identity
        self.imageView.transform = transform
        UIView.commitAnimations()
        completion?()
    }
    
    private func playMaskAnimation(animateView view: UIView, target: UIView, completion: (() -> ())?) {
        view.center = CGPoint.init(x: target.frame.origin.x + target.frame.size.width / 2.0, y: target.frame.origin.y + target.frame.size.height / 2.0)
        
        let scale = POPBasicAnimation.init(propertyNamed: kPOPLayerScaleXY)
        scale?.fromValue = NSValue.init(cgSize: CGSize.init(width: 1.0, height: 1.0))
        scale?.toValue = NSValue.init(cgSize: CGSize.init(width: 36.0, height: 36.0))
        scale?.beginTime = CACurrentMediaTime()
        scale?.duration = 0.3
        scale?.timingFunction = CAMediaTimingFunction.init(name: CAMediaTimingFunctionName.easeOut)
        scale?.removedOnCompletion = true
        
        let alpha = POPBasicAnimation.init(propertyNamed: kPOPLayerOpacity)
        alpha?.fromValue = 0.6
        alpha?.toValue = 0.6
        alpha?.beginTime = CACurrentMediaTime()
        alpha?.duration = 0.25
        alpha?.timingFunction = CAMediaTimingFunction.init(name: CAMediaTimingFunctionName.easeOut)
        alpha?.removedOnCompletion = true
        
        view.layer.pop_add(scale, forKey: "scale")
        view.layer.pop_add(alpha, forKey: "alpha")
        
        scale?.completionBlock = ({ animation, finished in
            completion?()
        })
    }
}

/// tabbar弹簧动画
class ExampleBouncesContentView: ESTabBarItemContentView {
    
    public var duration = 0.3
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func selectAnimation(animated: Bool, completion: (() -> ())?) {
        self.bounceAnimation()
        completion?()
    }
    
    override func reselectAnimation(animated: Bool, completion: (() -> ())?) {
        self.bounceAnimation()
        completion?()
    }
    
    func bounceAnimation() {
        let impliesAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        impliesAnimation.values = [1.0 ,1.4, 0.9, 1.15, 0.95, 1.02, 1.0]
        impliesAnimation.duration = duration * 2
        impliesAnimation.calculationMode = CAAnimationCalculationMode.cubic
        imageView.layer.add(impliesAnimation, forKey: nil)
    }
}


extension AppDelegate: UITabBarControllerDelegate {
    
    public func createESTabBarController(delegate: UITabBarControllerDelegate?) -> ESTabBarController {
        let tabBarController = ESTabBarController()
        tabBarController.delegate = delegate
//        tabBarController.shouldHijackHandler = {
//            tabbarController, viewController, index in
//            if index == 2 {
//                return true
//            }
//            return false
//        }
        
//        tabBarController.didHijackHandler = {
//            [weak tabBarController] tabbarController, viewController, index in
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
//                let alertController = UIAlertController.init(title: nil, message: nil, preferredStyle: .actionSheet)
//                let takePhotoAction = UIAlertAction(title: "Take a photo", style: .default, handler: nil)
//                alertController.addAction(takePhotoAction)
//                let selectFromAlbumAction = UIAlertAction(title: "Select from album", style: .default, handler: nil)
//                alertController.addAction(selectFromAlbumAction)
//                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//                alertController.addAction(cancelAction)
//                tabBarController?.present(alertController, animated: true, completion: nil)
//            }
//        }
        
        let v1 = NewsHomeViewController()
        let v2 = MovieHomeViewController()
//        let v3 = NewsHomeViewController()
//        let v4 = NewsHomeViewController()
//        let v5 = NewsHomeViewController()
        
        self.customIrregularityStyle(tabBarController: tabBarController, viewController: v1, eSTabBarItemContentView: ExampleBouncesContentView(), title: "新闻", image: UIImage(named: "find"), selectImage: UIImage(named: "find"))
        self.customIrregularityStyle(tabBarController: tabBarController, viewController: v2, eSTabBarItemContentView: ExampleBouncesContentView(), title: "电影", image: UIImage(named: "find"), selectImage: UIImage(named: "find"))
      //  self.customIrregularityStyle(tabBarController: tabBarController, viewController: v3, eSTabBarItemContentView: ExampleBouncesContentView(), title: "测试", image: UIImage(named: "find"), selectImage: UIImage(named: "find"))
      //  self.customIrregularityStyle(tabBarController: tabBarController, viewController: v4, eSTabBarItemContentView: ExampleBouncesContentView(), title: "发现", image: UIImage(named: "find"), selectImage: UIImage(named: "find"))
        //self.customIrregularityStyle(tabBarController: tabBarController, viewController: UIViewController(), eSTabBarItemContentView: ExampleBouncesContentView(), title: "我的", image: UIImage(named: "find"), selectImage: UIImage(named: "find"))
        
        return tabBarController
    }
    
    private func customIrregularityStyle(tabBarController: ESTabBarController, viewController: UIViewController?, eSTabBarItemContentView: ESTabBarItemContentView, title: String?, image: UIImage?, selectImage: UIImage?) {
        
        viewController?.tabBarItem = ESTabBarItem.init(eSTabBarItemContentView, title: title, image: image, selectedImage: selectImage)
        let navi = MainNavigationController(rootViewController: viewController!)
        tabBarController.addChild(navi)
        tabBarController.selectedIndex = 0
    }
    
}
