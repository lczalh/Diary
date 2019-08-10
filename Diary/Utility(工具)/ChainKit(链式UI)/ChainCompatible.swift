

public protocol LCZChainCompatible {
    // 占位符  空间命名
    associatedtype LCZChainCompatibleType
    
    var chain: LCZChainCompatibleType { get }
}

public extension LCZChainCompatible {
    
    var chain: Chain<Self> {
        return Chain(self)
    }
}

extension NSObject: LCZChainCompatible {}
