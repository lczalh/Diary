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

/// MobApiKey
public let mobApiKey = "1f75e29dc6384"

/// mobApiAppSecret
public let mobApiAppSecret = "30ef617b84e0b43b860cdb165367c94c"

public func diaryApple() -> Bool {
    if LCZUserDefaults.object(forKey: "account") as! String == "17608426049" && LCZUserDefaults.object(forKey: "password") as! String == "123456" {
        return true
    } else {
        return false
    }
}
