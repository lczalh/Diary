

public extension Chain where Base: UIBarItem {
    
    @discardableResult
    func isEnabled(_ isEnabled: Bool) -> Chain {
        base.isEnabled = isEnabled
        return self
    }
    
    @discardableResult
    func titleTextAttributes(_ titleTextAttributes: [NSAttributedString.Key: Any]?,
                             for state: UIControl.State...) -> Chain {
        state.forEach { base.setTitleTextAttributes(titleTextAttributes, for: $0) }
        return self
    }
}
