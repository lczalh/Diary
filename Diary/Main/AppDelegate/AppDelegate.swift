//
//  AppDelegate.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/2/13.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // 控制整个功能是否启用
        IQKeyboardManager.shared.enable = true
        // 控制点击背景是否收起键盘
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        // 将右边Done改成完成
        IQKeyboardManager.shared.toolbarDoneBarButtonItemText = "完成"
        // 初始化路由
        DiaryRoute.initialize(navigator: diaryRoute)
        // 初始化window
        self.window = UIWindow(frame: UIScreen.main.bounds)
        // 设置首页
        LCZHomePage.shared.setHomePage(guidePage: { // 引导页
            self.window?.rootViewController = UINavigationController(rootViewController: LoginViewController())
        }) {
            // 判断用户是否登陆
            if (LCZUserDefaults.object(forKey: "account") != nil) && (LCZUserDefaults.object(forKey: "password") != nil) { // 首页
                self.window?.rootViewController = MainTabBarController()
            } else { // 登陆
                self.window?.rootViewController = UINavigationController(rootViewController: LoginViewController())
            }
        }
        self.window?.makeKeyAndVisible()
        self.window!.backgroundColor = UIColor.white

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    // 应用重后台进入
    func applicationWillEnterForeground(_ application: UIApplication) {
//        let splashAd = GDTSplashAd.init(appId: "1109542481", placementId: "4040071110541328")
//        splashAd!.delegate = self
//        splashAd!.fetchDelay = 3
//        var splashImage = UIImage.init(named: "SplashNormal")
//        if LCZiphoneXHeight == LCZHeight {
//            splashImage = UIImage.init(named: "SplashX")
//        } else  {
//            splashImage = UIImage.init(named: "SplashSmall")
//        }
//        splashAd!.backgroundImage = splashImage
//        let bottomView = UIView.init(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.height * 0.25)))
//        bottomView.backgroundColor = .white
//        let logo = UIImageView.init(image: UIImage.init(named: "SplashLogo"))
//        logo.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: 311, height: 47))
//        logo.center = bottomView.center
//        bottomView.addSubview(logo)
//        let window = UIApplication.shared.keyWindow
//        splashAd!.loadAndShow(in: window, withBottomView: bottomView, skip: nil)
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

//extension AppDelegate: GDTSplashAdDelegate {
//    func splashAdSuccessPresentScreen(_ splashAd: GDTSplashAd!) {
//        LCZPrint(123)
//    }
//
//    func splashAdFail(toPresent splashAd: GDTSplashAd!, withError error: Error!) {
//        LCZPrint(error)
//    }
//}
