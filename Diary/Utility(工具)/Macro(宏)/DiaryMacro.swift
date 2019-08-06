//
//  DiaryMacro.swift
//  Diary
//
//  Created by 谷粒公社 on 2019/3/22.
//  Copyright © 2019 lcz. All rights reserved.
//

import Foundation

/// 路由
public let diaryRoute = Navigator()

/// 极速数据AppKey
public let highSpeedDataAppKey = "62c2edc337648910"

/// 新极速数据appkey
public let newHighSpeedDataAppKey = "2e79d41f7799f918"

/// 校验用户
public func diaryApple() -> Bool {
    let account = UserDefaults.standard.object(forKey: "account") as? String
    if account?.isEmpty == true || account == nil {
        return true
    } else {
        if UserDefaults.standard.object(forKey: "account") as! String == AppAccount && UserDefaults.standard.object(forKey: "password") as! String == AppPassword {
            return true
        } else {
            return false
        }
    }
}

/// 邮箱
public let AppEmail = "123456789@qq.com"

/// 账号
public let AppAccount = "123456"

/// 密码
public let AppPassword = "123456"

/// 标题颜色
public let AppTitleColor = "#9c27b0"

/// 内容颜色
public let AppContentColor = "#4fc3f7"

/// 苹果应用id
public let ApplicationId = "1474969735"
