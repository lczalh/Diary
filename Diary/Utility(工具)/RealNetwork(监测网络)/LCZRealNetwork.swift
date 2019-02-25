//
//  LCZRealReachability.swift
//  LCZGlobalToolDemo
//
//  Created by 刘超正 on 2018/7/28.
//  Copyright © 2018年 刘超正. All rights reserved.
//
//  LCZRealReachabilityTool使用方式
//  1.在AppDelegate中的didFinishLaunchingWithOptions方法中调用startRealTimeMonitorNetworkStatus()方法
//  2.懒加载LCZRealReachabilityTool对象
//  3.在控制器中监听网络状态，需要在viewWillAppear设置代理 并且实现代理方法
//  4.需要在自定义的方法中监听网络状态可使用getNetworkState属性
//

import UIKit
import RealReachability

class LCZRealNetwork {
    
    /// 定义网络状态闭包
    typealias reachabilityStatus = (_ state:ReachabilityStatus) -> (Void)
    
    /// 获取网络状态
    public var getNetworkState: reachabilityStatus?
    
    // 单利
    public static let shared = LCZRealNetwork()
    
    private init() {}
    
    /// 实时检测网络状态
    func realTimeMonitorNetworkStatus() {
        let realReachability = RealReachability.sharedInstance()
        realReachability?.startNotifier()
        
        // 创建通知
        NotificationCenter.default.addObserver(self, selector: #selector(networkChanged(notification:)), name: NSNotification.Name("kRealReachabilityChangedNotification"), object: nil)
        
        // 首次监测网络状态
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

extension AppDelegate {
    
    /// 开启实时检测网络状态
    func startRealTimeMonitorNetworkStatus() {
        let lczRealReachabilityTool = LCZRealNetwork.shared
        lczRealReachabilityTool.realTimeMonitorNetworkStatus()
    }
    
}
