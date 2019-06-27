//
//  LCZGlobalTool.swift
//  LCZGlobalToolDemo
//
//  Created by 刘超正 on 2018/7/26.
//  Copyright © 2018年 刘超正. All rights reserved.
//

import Foundation
import UIKit

/// 获取当前APP版本号
public let LCZVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String

/// 获取状态栏高度
public let LCZStatusBarHeight = UIApplication.shared.statusBarFrame.height

/// 获取tabbar的高度
public let LCZTabbarHeight = UITabBarController().tabBar.frame.height

/// 获取导航条的高度
public let LCZNaviBarHeight = UINavigationController().navigationBar.frame.height

/// 获取屏幕的宽
public let LCZWidth = UIScreen.main.bounds.width

/// 获取屏幕的高
public let LCZHeight = UIScreen.main.bounds.height

/// 用于获得 是iphone X 则tabbar距离的底部差34。 否则距离0
public let LCZSafeAreaBottomHeight: CGFloat =  (LCZHeight == 812.0 ? 34.0 : 0.0)

/// 用户偏好设置
public let LCZUserDefaults = UserDefaults.standard

/// 字体大小比例。@2x、@3x比例
public let LCZSizeScale : CGFloat = LCZWidth / 375.0

/// iphone7Plus屏幕高度
public let LCZiphone7PlusHeight = 736

/// iphoneX屏幕高度
public let LCZiphoneXHeight = 812

/// iphone7屏幕高度
public let LCZiphone7Height = 667

/// iphone5S屏幕高度
public let LCZiphone5SHeight = 568

/// APP名称
public let LCZAppName: String = Bundle.main.infoDictionary!["CFBundleDisplayName"] as! String

/// 获取根控制器
public var LCZAppDelegateRootViewController = UIApplication.shared.delegate?.window??.rootViewController

// 获取沙盒 Document路径
public let LCZDocumentPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first


/// ------------------------- MARK - method -----------------------------

/// 调试输出
///
/// - Parameters:
///   - message: 打印内容
///   - file: 文件名
///   - method: 方法名
///   - line: 行数
public func LCZPrint(_ items: Any...,file: String = #file,method: String = #function,line: Int = #line) {
    #if DEBUG
    print("类名:\((file as NSString).lastPathComponent),方法名:\(method),第\(line)行,内存地址:\(Unmanaged.passUnretained(items as AnyObject).toOpaque()),打印内容:\(items)")
    #endif
}

/// 设置字体大小
///
/// - Parameter size: 大小
/// - Returns: UIFont
public func LCZFontSize(size : CGFloat) -> UIFont {
    return UIFont.systemFont(ofSize: LCZSizeScale * size)
}

/// 设置加粗字体大小
///
/// - Parameter size: 大小
/// - Returns: UIFont
public func LCZBoldFontSize(size : CGFloat) -> UIFont {
    return UIFont.boldSystemFont(ofSize: LCZSizeScale * size)
}

/// 设置字体名称和字体大小
///
/// - Parameters:
///   - name: 字体名称
///   - size: 大小
/// - Returns: UIFont
public func LCZFontNameSize(name: String, size: CGFloat) -> UIFont {
    return UIFont(name: name, size: size * LCZSizeScale)!
}


/// 设置RGB颜色
///
/// - Parameters:
///   - red: red
///   - green: green
///   - blue: blue
///   - alpha: alpha
/// - Returns: UIColor
public func LCZRgbColor(_ red : CGFloat,_ green : CGFloat,_ blue : CGFloat,_ alpha : CGFloat) -> UIColor {
    return UIColor.init(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: alpha)
}

/// 设置16进制颜色
///
/// - Parameter hexadecimal: 16进制
/// - Returns: UIColor
public func LCZHexadecimalColor(hexadecimal: String) -> UIColor {
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

/// 删除所有偏好设置
public func LCZRemoveUserDefaults() -> Void {
    LCZUserDefaults.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
}

/// 日期转字符串
///
/// - Parameters:
///   - date: 日期
///   - dateFormat: 日期格式
/// - Returns: 字符串
func LCZDateConversionString(_ date:Date, dateFormat:String = "yyyy-MM-dd HH:mm:ss") -> String {
    let formatter = DateFormatter()
    formatter.locale = Locale.init(identifier: "zh_CN")
    formatter.dateFormat = dateFormat
    let date = formatter.string(from: date)
    return date
}


/// 字符串转日期
///
/// - Parameters:
///   - string: 字符串
///   - dateFormat: 日期格式
/// - Returns: 日期
func LCZStringConversionDate(_ string:String, dateFormat:String = "yyyy-MM-dd HH:mm:ss") -> Date {
    let formatter = DateFormatter()
    formatter.locale = Locale.init(identifier: "zh_CN")
    formatter.dateFormat = dateFormat
    let date = formatter.date(from: string)
    return date!
}

/// 时间转时间戳函数
///
/// - Parameters:
///   - time: 时间字符串
///   - dateFormat: 时间格式
/// - Returns: 时间戳
func LCZTimeToTimeStamp(time: String, dateFormat:String = "yyyy-MM-dd HH:mm:ss") -> Double {
    let dfmatter = DateFormatter()
    dfmatter.dateFormat = dateFormat
    let last = dfmatter.date(from: time)
    let timeStamp = last?.timeIntervalSince1970
    return timeStamp!
}

/// 根据时间戳返回几分钟前，几小时前，几天前
///
/// - Parameters:
///   - timeStamp: 时间戳
///   - dateFormat: 时间格式
/// - Returns: 字符串
func LCZUpdateTimeToCurrennTime(timeStamp: Double, dateFormat:String = "yyyy-MM-dd HH:mm:ss") -> String {
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

/// 获取当前视图中的目标父视图
///
/// - Parameters:
///   - currentView: 当前视图
///   - superView: 目标父视图
/// - Returns: 返回父视图
public func LCZGetSuperView<T: UIView>(currentView: UIView, superView: T.Type) -> T? {
    var view: UIView = currentView.superview!
    
    while view.isKind(of: T.self) != true {
        guard view.superview != nil else {
            return nil
        }
        view = view.superview!
    }
    return view as? T
}

public func LCZGetSubViews<T: UIView>(currentView: UIView, subView: T.Type) -> T? {
    let views = currentView.subviews
    if views.count == 0 {
        return nil
    }
    for view in views {
        LCZPrint(view)
        if view.isKind(of: T.self) == true {
            return view as? T
        }
    }
    return nil
}







