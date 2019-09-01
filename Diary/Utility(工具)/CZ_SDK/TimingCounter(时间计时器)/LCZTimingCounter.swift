//
//  LCZCountdownTimer .swift
//  360Intelligent
//
//  Created by 刘超正 on 2018/6/6.
//  Copyright © 2018年 刘超正. All rights reserved.
//

import Foundation

struct LCZTimingCounterModel {
    var year:Int = 0
    var month:Int = 0
    var day:Int = 0
    var hour:Int = 0
    var minute:Int = 0
    var second:Int = 0
    var millisecond:Int = 0
}

class LCZTimingCounter  {
    fileprivate static let sharedInstance = LCZTimingCounter()
    fileprivate init() {}
    //提供静态访问方法
    public static var shared: LCZTimingCounter  {
        return self.sharedInstance
    }
    ///时间倒计时标识存储，预防重复创建同一计时线程
    var notifyNames:[String] = []
}
extension LCZTimingCounter  {
    //MARK:--- 时间倒计时 ----------
    ///时间倒计时
    open class func addCountDown(_ notifyName:String, nowTimestamp:TimeInterval, endTimestamp:TimeInterval, second:Double = 0.1) {
        //以notifyName为标识，不必重复创建线程
        if LCZTimingCounter .shared.notifyNames.contains(notifyName) {return}
        LCZTimingCounter .shared.notifyNames.append(notifyName)
        //截止日期
        let endDate:Date = Date(timeIntervalSince1970: endTimestamp)
        //当前时间
        let nowDate:Date = Date(timeIntervalSince1970: nowTimestamp)
        //当前时间与系统时间差
        let nowDateDiffer:TimeInterval = nowDate.timeIntervalSinceNow
        //时间间隔 ^ 毫秒
        var aTime:TimeInterval = endDate.timeIntervalSince(Date()) * 10
        var bTime:Int = 999
        
        var saveSecond:Int = 59
        // 创建一个时间源
        let queue = DispatchQueue(label: notifyName)
        let timer = DispatchSource.makeTimerSource(queue:queue)
        //循环执行，马上开始，间隔为1ms
        timer.schedule(deadline: .now(), repeating: .milliseconds(Int(second*1000)))
        // 设定时间源的触发事件
        timer.setEventHandler(handler: {
            //计算剩余时间
            let gregorian = Calendar(identifier: .gregorian)
            let cmps = gregorian.dateComponents([Calendar.Component.year,Calendar.Component.month,Calendar.Component.day,Calendar.Component.hour,Calendar.Component.minute,Calendar.Component.second], from: Date(timeIntervalSince1970: Date().timeIntervalSince1970 + nowDateDiffer), to: endDate)
            aTime = endDate.timeIntervalSince(Date(timeIntervalSince1970: Date().timeIntervalSince1970 + nowDateDiffer)) * 10
            
            bTime = saveSecond != cmps.second ? 999 : (bTime <= 0 ? 999 : bTime - Int(second*1000))
            
            saveSecond = cmps.second ?? 59
            
            if aTime <= 0 {
                timer.cancel()
                DispatchQueue.main.async(execute: {
                    //print("通知\(aTime)毫秒")
                    LCZTimingCounter.shared.notifyNames.remove(at: LCZTimingCounter.shared.notifyNames.firstIndex(of: notifyName)!)
                    NotificationCenter.default.post(name: NSNotification.Name.init(notifyName), object: LCZTimingCounterModel(year: 0, month: 0, day: 0, hour: 0, minute: 0, second: 0, millisecond: 0))
                })
            } else {
                DispatchQueue.main.async(execute: {
                    //print("通知\(aTime)毫秒")
                    NotificationCenter.default.post(name: NSNotification.Name.init(notifyName), object: LCZTimingCounterModel(year: cmps.year ?? 0, month: cmps.month ?? 0, day: cmps.day ?? 0, hour: cmps.hour ?? 0, minute: cmps.minute ?? 0, second: cmps.second ?? 0, millisecond:bTime))
                })
                
            }
        })
        // 启动时间源
        timer.resume()
    }
}
extension LCZTimingCounter {
    //MARK:--- 验证码秒表倒计时 ----------
    ///验证码秒表倒计时
    open class func addVerifyCode(_ notifyName:String, maxTime: Int = 60) {
        let toTime = Date().timeIntervalSince1970 + TimeInterval(maxTime)
        var aTime = maxTime
        let queue = DispatchQueue(label: notifyName)
        // 创建一个时间源
        let timer = DispatchSource.makeTimerSource(queue:queue)
        //循环执行，马上开始，间隔为0.1s,误差允许10微秒
        timer.schedule(deadline: .now(), repeating: .seconds(1), leeway: .milliseconds(10))
        // 设定时间源的触发事件
        timer.setEventHandler(handler: {
            aTime = Int(toTime - Date().timeIntervalSince1970)
            if aTime <= 0 {
                //timer.suspend()
                timer.cancel()
                
                DispatchQueue.main.async {
                    //print("通知\(aTime)")
                    NotificationCenter.default.post(name: NSNotification.Name.init(notifyName), object: 0)
                }
            }else{
                DispatchQueue.main.async {
                    //print("通知\(aTime)")
                    NotificationCenter.default.post(name: NSNotification.Name.init(notifyName), object: aTime)
                }
            }
        })
        // 启动时间源
        timer.resume()
    }
}


