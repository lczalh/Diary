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
        // 全局修改TabBarItem 选中的文字颜色
        UITabBarItem.appearance().setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor: LCZHexadecimalColor(hexadecimal: "#FECE1D")], for: .selected)
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
    
    // 程序将要失去Active状态时调用，比如按下Home键或有电话信息进来。对应applicationWillEnterForeground（将进入前台）
    func applicationWillResignActive(_ application: UIApplication) {
        
    }
    
    // 程序已经进入后台时调用，对应applicationDidBecomeActive（已经变成前台）
    func applicationDidEnterBackground(_ application: UIApplication) {
        // 加载开屏广告
        let splashAd = GDTSplashAd.init(appId: youLiangHuiAppId, placementId: "4040071110541328")
        splashAd!.loadAndShow(in: window)
    }
    
    // 程序即将进去前台时调用，对应applicationWillResignActive（将进入后台）。这个方法用来撤销applicationWillResignActive中做的改变。
    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }
    
    // 当程序复原时，另一个名为 applicationDidBecomeActive 委托方法会被调用，在此你可以通过之前挂起前保存的数据来恢复你的应用程序
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    // 程序意外暂行
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
