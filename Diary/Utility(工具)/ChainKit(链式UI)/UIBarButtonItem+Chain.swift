

public extension Chain where Base: UIBarButtonItem {
    
    @discardableResult
    func width(_ width: CGFloat) -> Chain {
        base.width = width
        return self
    }
    
    @discardableResult
    func tintColor(_ tintColor: UIColor?) -> Chain {
        base.tintColor = tintColor
        return self
    }
}
