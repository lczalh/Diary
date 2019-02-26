//
//  LCZGlobalTool.swift
//  LCZGlobalToolDemo
//
//  Created by 刘超正 on 2018/7/26.
//  Copyright © 2018年 刘超正. All rights reserved.
//

import Foundation
import UIKit

/// 获取当前版本号
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
public let LCZSafeAreaBottomHeight =  (LCZHeight == 812.0 ? 34 : 0)

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

/// 获取根控制器
public let LCZAppDelegateRootViewController = UIApplication.shared.delegate?.window??.rootViewController


/// ------------------------- MARK - method -----------------------------

/// 调试输出
///
/// - Parameters:
///   - message: 打印内容
///   - file: 文件名
///   - method: 方法名
///   - line: 行数
public func LCZPrint<T>(_ message: T,file: String = #file,method: String = #function,line: Int = #line) {
    #if DEBUG
    print("类名:\((file as NSString).lastPathComponent),方法名:\(method),第\(line)行,打印内容:\(message)")
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







