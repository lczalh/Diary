//
//  LCZChainCompatible.swift
//  Diary
//
//  Created by glgl on 2019/8/7.
//  Copyright © 2019 lcz. All rights reserved.
//

public protocol LCZChainCompatible {
    // 占位符  空间命名
    associatedtype T
    
    var lcz: T { get }
}

public extension LCZChainCompatible {
    
    var lcz: LCZChain<Self> {
        return LCZChain(self)
    }
}

extension NSObject: LCZChainCompatible {}
