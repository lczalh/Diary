//
//  CZMacro.swift
//  Diary
//
//  Created by 刘超正 on 2019/9/1.
//  Copyright © 2019 lcz. All rights reserved.
//

import Foundation

/// 获取当前APP版本号
public var cz_AppVersionNumber: String? {
    return Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String
}

/// 获取屏幕宽度
public var cz_ScreenWidth: CGFloat? {
    return UIScreen.main.bounds.width
}

/// 获取屏幕高度
public var cz_ScreenHeight: CGFloat? {
    return UIScreen.main.bounds.height
}

/// 获取标签页高度
public var cz_TabbarHeight: CGFloat? {
    return UITabBarController().tabBar.frame.height
}

/// 获取导航条高度
public var cz_NavigationHeight: CGFloat? {
    return UINavigationController().navigationBar.frame.height
}

/// 获取状态栏高度
public var cz_StatusBarHeight: CGFloat? {
    return UIApplication.shared.statusBarFrame.height
}

/// 获取安全距离
public var cz_SafeAreaBottomHeight: CGFloat {
    return cz_ScreenHeight == 812.0 ? 34.0 : 0.0
}

/// 获取屏幕比例
public var cz_ScreenSizeScale: CGFloat {
    return cz_ScreenWidth! / 375.0
}

/// 获取APP名称
public var cz_AppName: String {
    return Bundle.main.infoDictionary!["CFBundleDisplayName"] as! String
}

/// 获取沙盒Document路径
public var cz_DocumentPath: String {
    return NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first!
}

/// 获取沙盒Library路径
public var cz_LibraryPath: String {
    return NSSearchPathForDirectoriesInDomains(.libraryDirectory, .allDomainsMask, true).first!
}

/// 获取沙盒tmp路径
public var cz_TmpPath: String {
    return NSTemporaryDirectory()
}

/// 调试输出
///
/// - Parameters:
///   - message: 打印内容
///   - file: 文件名
///   - method: 方法名
///   - line: 行数
public func cz_Print(_ items: Any...,file: String = #file,method: String = #function,line: Int = #line) {
    #if DEBUG
    print("类名:\((file as NSString).lastPathComponent),方法名:\(method),第\(line)行,内存地址:\(Unmanaged.passUnretained(items as AnyObject).toOpaque()),打印内容:\(items)")
    #endif
}

/// 通过RGB值获取颜色
///
/// - Parameters:
///   - red: red
///   - green: green
///   - blue: blue
///   - alpha: alpha
/// - Returns: UIColor
public func cz_RgbColor(_ red : CGFloat,_ green : CGFloat,_ blue : CGFloat,_ alpha : CGFloat) -> UIColor {
    return UIColor.init(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: alpha)
}

/// 通过16进制数获取颜色
///
/// - Parameter hexadecimal: 16进制
/// - Returns: UIColor
public func cz_HexadecimalColor(hexadecimal: String) -> UIColor {
    var cstr = hexadecimal.trimmingCharacters(in:  CharacterSet.whitespacesAndNewlines).uppercased() as NSString;
    if(cstr.length < 6){
        return UIColor.clear;
    }
    if(cstr.hasPrefix("0X")){
        cstr = cstr.substring(from: 2) as NSString
    }
    if(cstr.hasPrefix("#")){
        cstr = cstr.substring(from: 1) as NSString
    }
    if(cstr.length != 6){
        return UIColor.clear;
    }
    var range = NSRange.init()
    range.location = 0
    range.length = 2
    //r
    let rStr = cstr.substring(with: range);
    //g
    range.location = 2;
    let gStr = cstr.substring(with: range)
    //b
    range.location = 4;
    let bStr = cstr.substring(with: range)
    var r :UInt32 = 0x0;
    var g :UInt32 = 0x0;
    var b :UInt32 = 0x0;
    Scanner.init(string: rStr).scanHexInt32(&r);
    Scanner.init(string: gStr).scanHexInt32(&g);
    Scanner.init(string: bStr).scanHexInt32(&b);
    return UIColor.init(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: 1);
}

/// 计算字符串宽度
///
/// - Parameters:
///   - font: 待显示的文字大小
///   - size: 预估字符串大小
///   - text: 字符串
/// - Returns: CGSize
public func cz_TextWidth(font: UIFont, size: CGSize = CGSize(width: CGFloat(MAXFLOAT), height: cz_ScreenHeight!), text: NSString) -> CGSize {
    var textSize:CGSize
    if __CGSizeEqualToSize(size,CGSize.zero){
        let attributes = NSDictionary(object: font, forKey: NSAttributedString.Key.font as NSCopying)
        textSize = text.size(withAttributes:attributes as? [NSAttributedString.Key : Any])
    }else{
        let attributes = NSDictionary(object: font, forKey: NSAttributedString.Key.font as NSCopying)
        let stringRect = text.boundingRect(with:size, options:NSStringDrawingOptions.usesLineFragmentOrigin, attributes:attributes as? [NSAttributedString.Key : Any], context: nil)
        textSize = stringRect.size
    }
    return textSize
}

/// 计算字符串高度
///
/// - Parameters:
///   - font: 待显示的文字大小
///   - size: 预估字符串大小
///   - text: 字符串
/// - Returns: CGSize
public func cz_TextHeight(font: UIFont, size: CGSize = CGSize(width: cz_ScreenWidth!, height: CGFloat(MAXFLOAT)), text: NSString) -> CGSize {
    var textSize:CGSize
    if __CGSizeEqualToSize(size,CGSize.zero){
        let attributes = NSDictionary(object: font, forKey: NSAttributedString.Key.font as NSCopying)
        textSize = text.size(withAttributes:attributes as? [NSAttributedString.Key : Any])
    }else{
        let attributes = NSDictionary(object: font, forKey: NSAttributedString.Key.font as NSCopying)
        let stringRect = text.boundingRect(with:size, options:NSStringDrawingOptions.usesLineFragmentOrigin, attributes:attributes as? [NSAttributedString.Key : Any], context: nil)
        textSize = stringRect.size
    }
    return textSize
}

/// 获取常规字体
///
/// - Parameter size: 字体大小
/// - Returns: UIFont
public func cz_ConventionFont(size: CGFloat) -> UIFont {
    return UIFont.systemFont(ofSize: cz_ScreenSizeScale * size)
}

/// 获取加粗字体
///
/// - Parameter size: 大小
/// - Returns: UIFont
public func cz_BoldFont(size: CGFloat) -> UIFont {
    return UIFont.boldSystemFont(ofSize: cz_ScreenSizeScale * size)
}

//返回随机颜色
public var cz_RandomColor: UIColor {
    let red = CGFloat(arc4random()%256)/255.0
    let green = CGFloat(arc4random()%256)/255.0
    let blue = CGFloat(arc4random()%256)/255.0
    return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
}

/// 获取缓存大小
public var cz_CacheSize: String{
    get{
        // 路径
        let basePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
        let fileManager = FileManager.default
        // 遍历出所有缓存文件加起来的大小
        func caculateCache() -> Float{
            var total: Float = 0
            if fileManager.fileExists(atPath: basePath!){
                let childrenPath = fileManager.subpaths(atPath: basePath!)
                if childrenPath != nil{
                    for path in childrenPath!{
                        let childPath = basePath!.appending("/").appending(path)
                        do{
                            let attr:NSDictionary = try fileManager.attributesOfItem(atPath: childPath) as NSDictionary
                            let fileSize = attr["NSFileSize"] as! Float
                            total += fileSize
                            
                        }catch _{
                            
                        }
                    }
                }
            }
            // 缓存文件大小
            return total
        }
        // 调用函数
        let totalCache = caculateCache()
        return NSString(format: "%.2f MB", totalCache / 1024.0 / 1024.0 ) as String
    }
}

/// 清除缓存
public func cz_ClearCache() {
    LCZProgressHUD.show(title: "清除缓存")
    // 取出cache文件夹目录 缓存文件都在这个目录下
    let cachePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
    // 取出文件夹下所有文件数组
    let fileArr = FileManager.default.subpaths(atPath: cachePath!)
    // 遍历删除
    for file in fileArr! {
        // 拼接文件路径
        let path = cachePath?.appending("/\(file)")
        if FileManager.default.fileExists(atPath: path!) {
            // 循环删除
            do {
                try FileManager.default.removeItem(atPath: path!)
            } catch {
                
            }
        }
    }
    LCZProgressHUD.dismiss()
    LCZProgressHUD.showSuccess(title: "清除成功")
}

/// 删除所有偏好设置
public func cz_RemoveUserDefaults() -> Void {
    UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
}

/// 跳转到AppStore进行评分
///
/// - Parameter appId: appId
public func cz_JumpAppStoreScore(appId: String) {
    UIApplication.shared.open(URL(string: "https://itunes.apple.com/us/app/itunes-u/id\(appId)?action=write-review&mt=8")!, options: [:], completionHandler: nil)
}

/// 跳转到AppStore首页
///
/// - Parameter appId: appId
public func cz_JumpAppStotrScore(appId: String) {
    UIApplication.shared.open(URL(string: "https://itunes.apple.com/us/app/itunes-u/id\(appId)?mt=8")!, options: [:], completionHandler: nil)
}

/// 应用第一次启动
public func cz_IsFirstLaunch() -> Bool {
    let hasBeenLaunched = "hasBeenLaunched"
    let isFirstLaunch = !UserDefaults.standard.bool(forKey: hasBeenLaunched)
    if isFirstLaunch {
        UserDefaults.standard.set(true, forKey: hasBeenLaunched)
        UserDefaults.standard.synchronize()
    }
    return isFirstLaunch
}

/// 当前版本第一次启动
public func cz_IsFirstLaunchOfNewVersion() -> Bool {
    //主程序版本号
    let infoDictionary = Bundle.main.infoDictionary!
    let majorVersion = infoDictionary["CFBundleShortVersionString"] as! String
    
    //上次启动的版本号
    let hasBeenLaunchedOfNewVersion = "hasBeenLaunchedOfNewVersion"
    let lastLaunchVersion = UserDefaults.standard.string(forKey:
        hasBeenLaunchedOfNewVersion)
    
    //版本号比较
    let isFirstLaunchOfNewVersion = majorVersion != lastLaunchVersion
    if isFirstLaunchOfNewVersion {
        UserDefaults.standard.set(majorVersion, forKey:
            hasBeenLaunchedOfNewVersion)
        UserDefaults.standard.synchronize()
    }
    return isFirstLaunchOfNewVersion
}
