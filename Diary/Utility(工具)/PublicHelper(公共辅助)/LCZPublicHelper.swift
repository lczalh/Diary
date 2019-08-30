//
//  LCZPublicHelper.swift
//  Diary
//
//  Created by glgl on 2019/7/29.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit
import MessageUI
import Social

/// 邮件数据闭包
typealias sendEmail = (_ controller: MFMailComposeViewController, _ result: MFMailComposeResult) -> Void

/// 系统分享是否成功闭包
typealias nativeShare = (_ completed: Bool) -> Void

class LCZPublicHelper: NSObject {
    
    /// 地址key
    private struct AssociatedKeys {
        static var sendEmailKey = "LCZPublicHelper.setSendEmail" // 邮件
    }
    
    /// 单利
    static let shared = LCZPublicHelper()
    private override init() {}
    
    /// 获取当前APP版本号
    public var getAppVersionNumber: String? {
        return Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String
    }
    
    /// 获取屏幕宽度
    public var getScreenWidth: CGFloat? {
        return UIScreen.main.bounds.width
    }
    
    /// 获取屏幕高度
    public var getScreenHeight: CGFloat? {
        return UIScreen.main.bounds.height
    }
    
    /// 获取标签页高度
    public var getTabbarHeight: CGFloat? {
        return UITabBarController().tabBar.frame.height
    }
    
    /// 获取导航条高度
    public var getNavigationHeight: CGFloat? {
        return UINavigationController().navigationBar.frame.height
    }
    
    /// 获取状态栏高度
    public var getStatusBarHeight: CGFloat? {
        return UIApplication.shared.statusBarFrame.height
    }
    
    /// 获取安全距离
    public var getSafeAreaBottomHeight: CGFloat {
        return self.getScreenHeight == 812.0 ? 34.0 : 0.0
    }
    
    /// 获取屏幕比例
    public var getScreenSizeScale: CGFloat {
        return self.getScreenWidth! / 375.0
    }
    
    /// 获取APP名称
    public var getAppName: String {
        return Bundle.main.infoDictionary!["CFBundleDisplayName"] as! String
    }
    
    /// 获取沙盒Document路径
    public var getDocumentPath: String {
        return NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first!
    }
    
    /// 获取沙盒Library路径
    public var getLibraryPath: String {
        return NSSearchPathForDirectoriesInDomains(.libraryDirectory, .allDomainsMask, true).first!
    }
    
    /// 获取沙盒tmp路径
    public var getTmpPath: String {
        return NSTemporaryDirectory()
    }
    
    /// 获取缓存大小
    public var getCacheSize: String{
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
    public func clearCache() {
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
    
    /// 调试输出
    ///
    /// - Parameters:
    ///   - message: 打印内容
    ///   - file: 文件名
    ///   - method: 方法名
    ///   - line: 行数
    public func setPrint(_ items: Any...,file: String = #file,method: String = #function,line: Int = #line) {
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
    public func getRgbColor(_ red : CGFloat,_ green : CGFloat,_ blue : CGFloat,_ alpha : CGFloat) -> UIColor {
        return UIColor.init(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: alpha)
    }
    
    /// 删除所有偏好设置
    public func removeUserDefaults() -> Void {
        UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
    }
    
    /// 跳转到AppStore进行评分
    ///
    /// - Parameter appId: appId
    @objc public func jumpAppStoreScore(appId: String) {
        UIApplication.shared.open(URL(string: "https://itunes.apple.com/us/app/itunes-u/id\(appId)?action=write-review&mt=8")!, options: [:], completionHandler: nil)
    }
    
    /// 跳转到AppStore首页
    ///
    /// - Parameter appId: appId
    @objc public func jumpAppStotrScore(appId: String) {
        UIApplication.shared.open(URL(string: "https://itunes.apple.com/us/app/itunes-u/id\(appId)?mt=8")!, options: [:], completionHandler: nil)
    }
    
    /// 调用系统发送邮件功能
    ///
    /// - Parameter recipients: 收件人
    @objc public func callSendEmail(recipients: String, result: @escaping sendEmail) {
        objc_setAssociatedObject(self, &AssociatedKeys.sendEmailKey, result, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        // 首先要判断设备具不具备发送邮件功能
        if MFMailComposeViewController.canSendMail(){
            let controller = MFMailComposeViewController()
            // 设置代理
            controller.mailComposeDelegate = self
            // 设置收件人
            controller.setToRecipients([recipients])
            
            DispatchQueue.main.async {
                self.getTopsideController()!.present(controller, animated: true, completion: nil)
            }
        }else{
            LCZProgressHUD.showError(title: "当前设备尚未配置邮件帐号，请到邮件APP中添加您的邮箱后再使用此功能！")
        }
    }
    
    /// 调用系统分享
    ///
    /// - Parameters:
    ///   - title: 标题
    ///   - image: 图片
    ///   - url: 链接地址
    public func callNativeShare(title: String?, image: String?, url: String?, result: @escaping nativeShare) {
        var items: Array<Any> = []
        if (title == nil && image == nil && url == nil) {
            LCZProgressHUD.showError(title: "分享的数据为空")
            return
        }
        if (title != nil) {
            items.append(title as Any)
        }
        if (image != nil) {
            items.append(UIImage(named: image!) as Any)
        }
        if (url != nil)  {
            items.append(URL(string: url!) as Any)
        }
        let controller = UIActivityViewController(activityItems: items, applicationActivities: nil)
        
        controller.completionWithItemsHandler = { activityType, completed, returnedItems, activityError in
            result(completed)
        }
        DispatchQueue.main.async {
            self.getTopsideController()!.present(controller, animated: true, completion: nil)
        }
    }
    
    /// 通过16进制数获取颜色
    ///
    /// - Parameter hexadecimal: 16进制
    /// - Returns: UIColor
    public func getHexadecimalColor(hexadecimal: String) -> UIColor {
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
    
    /// 通过日期（Date）获取时间字符串
    ///
    /// - Parameters:
    ///   - date: 日期
    ///   - dateFormat: 日期格式
    /// - Returns: 字符串
    public func getDateConversionString(_ date:Date, dateFormat:String = "yyyy-MM-dd HH:mm:ss") -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale.init(identifier: "zh_CN")
        formatter.dateFormat = dateFormat
        let date = formatter.string(from: date)
        return date
    }
    
    
    /// 通过时间字符串获取日期（Date）
    ///
    /// - Parameters:
    ///   - string: 字符串
    ///   - dateFormat: 日期格式
    /// - Returns: 日期
    public func getStringConversionDate(_ string:String, dateFormat:String = "yyyy-MM-dd HH:mm:ss") -> Date {
        let formatter = DateFormatter()
        formatter.locale = Locale.init(identifier: "zh_CN")
        formatter.dateFormat = dateFormat
        let date = formatter.date(from: string)
        return date!
    }
    
    /// 通过时间字符串获取时间戳
    ///
    /// - Parameters:
    ///   - time: 时间字符串
    ///   - dateFormat: 时间格式
    /// - Returns: 时间戳
    public func getTimeToTimeStamp(time: String, dateFormat:String = "yyyy-MM-dd HH:mm:ss") -> Double {
        let dfmatter = DateFormatter()
        dfmatter.dateFormat = dateFormat
        let last = dfmatter.date(from: time)
        let timeStamp = last?.timeIntervalSince1970
        return timeStamp!
    }
    
    /// 通过时间戳获取几分钟前，几小时前，几天前
    ///
    /// - Parameters:
    ///   - timeStamp: 时间戳
    ///   - dateFormat: 时间格式
    /// - Returns: 字符串
    public func getUpdateTimeToCurrennTime(timeStamp: Double, dateFormat:String = "yyyy-MM-dd HH:mm:ss") -> String {
        //获取当前的时间戳
        let currentTime = Date().timeIntervalSince1970
        //时间差
        let reduceTime : TimeInterval = currentTime - timeStamp
        //时间差小于60秒
        if reduceTime < 60 {
            return "刚刚"
        }
        //时间差大于一分钟小于60分钟内
        let mins = Int(reduceTime / 60)
        if mins < 60 {
            return "\(mins)分钟前"
        }
        let hours = Int(reduceTime / 3600)
        if hours < 24 {
            return "\(hours)小时前"
        }
        let days = Int(reduceTime / 3600 / 24)
        if days < 30 {
            return "\(days)天前"
        }
        //不满足上述条件---或者是未来日期-----直接返回日期
        let date = NSDate(timeIntervalSince1970: timeStamp)
        let dfmatter = DateFormatter()
        dfmatter.dateFormat = dateFormat
        return dfmatter.string(from: date as Date)
    }
    
    /// 获取最上层window
    public func getLastWindow() -> UIWindow? {
        for window in UIApplication.shared.windows.reversed() {
            if window.isKind(of: UIWindow.self) && window.bounds == UIScreen.main.bounds {
                return window
            }
        }
        return nil
    }
    
    /// sampleBuffer 转 UIImage
    ///
    /// - Parameter sampleBuffer: sampleBuffer
    /// - Returns: UIImage
    public func setImageFromSampleBuffer(sampleBuffer: CMSampleBuffer) -> UIImage {
        let imageBuffer: CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)!
        let ciimage : CIImage = CIImage(cvPixelBuffer: imageBuffer)
        let context:CIContext = CIContext.init(options: nil)
        let cgImage:CGImage = context.createCGImage(ciimage, from: ciimage.extent)!
        let image:UIImage = UIImage.init(cgImage: cgImage)
        return image
    }
    
    /// 通过当前控制器获取最上层的控制器
    ///
    /// - Parameter viewController: 控制器 默认是根控制器
    /// - Returns: 最上层控制器
    public func getTopsideController(viewController: UIViewController = (UIApplication.shared.delegate?.window?!.rootViewController)!) -> UIViewController? {
        if viewController.isKind(of: UINavigationController.self) {
            let navigationController = viewController as! UINavigationController
            return self.getTopsideController(viewController: navigationController.visibleViewController!)
        } else if (viewController.isKind(of: UITabBarController.self)) {
            let tabBarController = viewController as! UITabBarController
            return self.getTopsideController(viewController: tabBarController.selectedViewController!)
        } else if viewController.presentedViewController != nil {
            return self.getTopsideController(viewController: viewController.presentedViewController!)
        } else {
            return viewController
        }
    }
    
    /// 计算字符串宽度
    ///
    /// - Parameters:
    ///   - font: 待显示的文字大小
    ///   - size: 预估字符串大小
    ///   - text: 字符串
    /// - Returns: CGSize
    public func getTextWidth(font: UIFont, size: CGSize = CGSize(width: CGFloat(MAXFLOAT), height: LCZPublicHelper.shared.getScreenHeight!), text: NSString) -> CGSize {
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
    public func getTextHeight(font: UIFont, size: CGSize = CGSize(width: LCZPublicHelper.shared.getScreenWidth!, height: CGFloat(MAXFLOAT)), text: NSString) -> CGSize {
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
    
    /// 设置导航条透明 须在viewWillAppear调用
    public func setNavigationBarTransparency(navigationController: UINavigationController) {
        navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController.navigationBar.shadowImage = UIImage()
    }
    
    /// 将透明导航条还原 须在viewWillDisappear调用
    public func setRestoreTheTransparentNavigationBar(navigationController: UINavigationController) {
        navigationController.navigationBar.setBackgroundImage(nil, for: .default)
        navigationController.navigationBar.shadowImage = nil
    }
    
    /// 通过视图获取指定父控制器
    ///
    /// - Parameter currentView: 当前视图
    /// - Parameter seekViewController: 查找的父控制器类型
    /// - Returns: 父控制器
    public func getSuperViewController<T: UIViewController>(currentView: UIView, seekViewController: T.Type) -> T? {
        var view: UIView = currentView.superview!
        while view.next!.isKind(of: T.self) != true {
            guard view.superview != nil else {
                return nil
            }
            view = view.superview!
        }
        return view.next as? T
    }
    
    /// 通过视图获取指定父视图
    ///
    /// - Parameter currentView: 当前视图
    /// - Parameter seekSuperView: 查找的父视图类型
    /// - Returns: 父视图
    public func getSuperView<T: UIView>(currentView: UIView, seekSuperView: T.Type) -> T? {
        var view: UIView = currentView.superview!
        while view.isKind(of: T.self) != true {
            guard view.superview != nil else {
                return nil
            }
            view = view.superview!
        }
        return view as? T
    }
    
    /// 通过当前视图获取指定子视图
    ///
    /// - Parameter subView: 查找的子视图类型
    /// - Returns: 子视图
    public func getSubView<T: UIView>(currentView: UIView, seekSubView: T.Type) -> T? {
        return getView(currenView: currentView, superView: T.self)
    }
    private func getView<T: UIView>(currenView: UIView, superView: T.Type) -> T? {
        // 遍历子视图
        for view in currenView.subviews {
            if view.isKind(of: T.self) == true {
                return view as? T
            } else {
                // 递归查询
                let v = getView(currenView: view, superView: T.self)
                if v != nil {
                    return v
                }
            }
        }
        return nil
    }
    
    /// 获取常规字体
    ///
    /// - Parameter size: 字体大小
    /// - Returns: UIFont
    public func getConventionFont(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: self.getScreenSizeScale * size)
    }
    
    /// 获取加粗字体
    ///
    /// - Parameter size: 大小
    /// - Returns: UIFont
    public func getBoldFont(size: CGFloat) -> UIFont {
        return UIFont.boldSystemFont(ofSize: self.getScreenSizeScale * size)
    }
    
    /// 获取适配后的大小
    ///
    /// - Parameter size: size
    /// - Returns: 按屏幕比例适配后的大小
    public func getFitSize(size: CGFloat) -> CGFloat {
        return size * self.getScreenSizeScale
    }
    
    /// push方式 返回指定控制器
    ///
    /// - Parameters:
    ///   - currentViewController: 当前所在控制器
    ///   - specifiedViewController: 待返回到的控制器类型
    /// - Returns: 待返回到的控制器对象
    public func pushBackToTheSpecifiedController<T: UIViewController>(currentViewController: UIViewController, specifiedViewController: T.Type) -> T? {
        for vc in (currentViewController.navigationController?.viewControllers.reversed())! {
            if vc.isKind(of: T.self) {
                currentViewController.navigationController?.popToViewController(vc, animated: true)
                return (vc as! T)
            }
        }
        return nil
    }
    
    /// present方式 返回指定控制权
    ///
    /// - Parameters:
    ///   - currentViewController: 当前所在控制器
    ///   - specifiedViewController: 待返回到的控制器类型
    /// - Returns: 待返回到的控制器对象
    public func presentBackToTheSpecifiedController<T: UIViewController>(currentViewController: UIViewController, specifiedViewController: T.Type) -> T? {
        var vc = currentViewController.presentingViewController
        repeat {
            vc = vc?.presentingViewController
        } while(vc?.presentingViewController != nil)
        
        if (vc != nil) {
            return (vc as! T)
        } else {
            return nil
        }
    }
    
    /// 调用系统拨号
    ///
    /// - Parameter phoneNumber: 电话号码
    public func callSystemDial(phoneNumber: String) {
        UIApplication.shared.open(URL(string: "tel://\(phoneNumber)")!, options: [:], completionHandler: nil)
    }
    
    /// 获取指定年月开始日期
    public func getSpecifiedYearStartDate(year: Int, month: Int) -> Date {
        let calendar = NSCalendar.current
        var startComps = DateComponents()
        startComps.day = 1
        startComps.month = month
        startComps.year = year
        let startDate = calendar.date(from: startComps)!
        return startDate
    }
    
    /// 获取指定年月结束日期
    public func getSpecifiedYearEndDate(year: Int, month: Int, returnEndTime:Bool = false) -> Date {
        let calendar = NSCalendar.current
        var components = DateComponents()
        components.month = 1
        if returnEndTime {
            components.second = -1
        } else {
            components.day = -1
        }
        
        let endOfYear = calendar.date(byAdding: components,
                                      to: getSpecifiedYearStartDate(year: year, month:month))!
        return endOfYear
    }
}


// MARK: - MFMailComposeViewControllerDelegate 系统邮件代理
extension LCZPublicHelper: MFMailComposeViewControllerDelegate {
    //发送邮件代理方法
    func mailComposeController(_ controller: MFMailComposeViewController,
                               didFinishWith result: MFMailComposeResult, error: Error?) {
        let block = objc_getAssociatedObject(self, &AssociatedKeys.sendEmailKey) as! sendEmail
        block(controller,result)
    }
}
