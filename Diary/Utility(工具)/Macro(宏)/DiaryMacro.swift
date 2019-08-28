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

/// 校验用户
public func diaryUser() -> Bool {
    let account = UserDefaults.standard.object(forKey: "account") as? String
    if account?.isEmpty == true || account == nil {
        return true
    } else {
        if UserDefaults.standard.object(forKey: "account") as! String == diaryAccount && UserDefaults.standard.object(forKey: "password") as! String == diaryPassword {
            return true
        } else {
            return false
        }
    }
}

/// 邮箱
public let diaryEmail = "123456789@qq.com"

/// 账号
public let diaryAccount = "15666666666"

/// 密码
public let diaryPassword = "123456"

/// 标题颜色
public let AppTitleColor = "#FFC0CB"

/// 内容颜色
public let AppContentColor = "#8B4513"

/// 苹果应用id
public let ApplicationId = "1477734500"
