

public extension Chain where Base: UIImageView {
    
    @discardableResult
    func image(_ image: UIImage?) -> Chain {
        base.image = image
        return self
    }
    
    @discardableResult
    func isHighlighted(_ isHighlighted: Bool) -> Chain {
        base.isHighlighted = isHighlighted
        return self
    }
}
