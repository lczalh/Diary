//
//  CZDateMacro.swift
//  Diary
//
//  Created by 刘超正 on 2019/9/1.
//  Copyright © 2019 lcz. All rights reserved.
//

import Foundation

/// 获取指定年月开始日期
public func cz_SpecifiedYearStartDate(year: Int, month: Int) -> Date {
    let calendar = NSCalendar.current
    var startComps = DateComponents()
    startComps.day = 1
    startComps.month = month
    startComps.year = year
    let startDate = calendar.date(from: startComps)!
    return startDate
}

/// 获取指定年月结束日期 returnEndTime：true 则为23:59:59 false： 00:00:00
public func cz_SpecifiedYearEndDate(year: Int, month: Int, returnEndTime:Bool = false) -> Date {
    let calendar = NSCalendar.current
    var components = DateComponents()
    components.month = 1
    if returnEndTime {
        components.second = -1
    } else {
        components.day = -1
    }
    
    let endOfYear = calendar.date(byAdding: components,
                                  to: cz_SpecifiedYearStartDate(year: year, month:month))!
    return endOfYear
}

/// 通过日期（Date）获取时间字符串
///
/// - Parameters:
///   - date: 日期
///   - dateFormat: 日期格式
/// - Returns: 字符串
public func cz_DateConversionString(_ date:Date, dateFormat:String = "yyyy-MM-dd HH:mm:ss") -> String {
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
public func cz_StringConversionDate(_ string:String, dateFormat:String = "yyyy-MM-dd HH:mm:ss") -> Date {
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
public func cz_TimeToTimeStamp(time: String, dateFormat:String = "yyyy-MM-dd HH:mm:ss") -> Double {
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
public func cz_UpdateTimeToCurrennTime(timeStamp: Double, dateFormat:String = "yyyy-MM-dd HH:mm:ss") -> String {
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


