//
//  LCZRealReachability.swift
//  LCZGlobalToolDemo
//
//  Created by 刘超正 on 2018/7/28.
//  Copyright © 2018年 刘超正. All rights reserved.

import Foundation
import RealReachability

class LCZRealReachability {
    
    /// 定义网络状态闭包
    typealias reachabilityStatus = (_ state:ReachabilityStatus) -> (Void)
    
    /// 获取网络状态
    public var getNetworkState: reachabilityStatus?
    
    // 单例
    public static let shared: LCZRealReachability = {
        let s = LCZRealReachability()
        s.realTimeMonitorNetworkStatus()
        return s
    }()
    
    private init() {}
    
    /// 实时检测网络状态
    private func realTimeMonitorNetworkStatus() {
        let realReachability = RealReachability.sharedInstance()
        realReachability?.startNotifier()
        
        // 创建通知
        NotificationCenter.default.addObserver(self, selector: #selector(networkChanged(notification:)), name: NSNotification.Name("kRealReachabilityChangedNotification"), object: nil)
        
        // 监测网络状态
        networkState(realReachability!)
    }
    
    /// 监听通知
    ///
    /// - Parameter notification: 通知内容
    @objc private func networkChanged(notification: NSNotification) {
        let realReachability = notification.object as! RealReachability;
        networkState(realReachability)
    }
    
    /// 传出网络状态
    ///
    /// - Parameter realReachability: RealReachability对象
    private func networkState(_ realReachability: RealReachability) {
        realReachability.reachability { (state) in
            // 通过闭包传出状态
            if self.getNetworkState != nil {
                self.getNetworkState!(state)
            }
        }
    }
}
