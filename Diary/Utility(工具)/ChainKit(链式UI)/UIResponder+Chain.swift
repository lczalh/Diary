

public extension Chain where Base: UIResponder {
    
    @discardableResult
    func becomeFirstResponder() -> Chain {
        base.becomeFirstResponder()
        return self
    }
    
    @discardableResult
    func resignFirstResponder() -> Chain {
        base.resignFirstResponder()
        return self
    }
}
