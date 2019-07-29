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
public let highSpeedDataAppKey = "ac0f7297750aa010"

/// 校验用户
public func diaryApple() -> Bool {
    let account = LCZUserDefaults.object(forKey: "account") as? String
    if account?.isEmpty == true || account == nil {
        return true
    } else {
        if LCZUserDefaults.object(forKey: "account") as! String == AppAccount && LCZUserDefaults.object(forKey: "password") as! String == AppPassword {
            return true
        } else {
            return false
        }
    }
}

/// 邮箱
public let AppEmail = "824092805@qq.com"

/// 账号
public let AppAccount = "123456"

/// 密码
public let AppPassword = "123456"

/// 标题颜色
public let AppTitleColor = "#57310C"

/// 内容颜色
public let AppContentColor = "#FECE1D"

public let AppStoreId = "1472107585"
