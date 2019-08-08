//
//  UITextField+LCZChain.swift
//  Diary
//
//  Created by glgl on 2019/8/7.
//  Copyright © 2019 lcz. All rights reserved.
//

public extension LCZChain where Base: UITextField {
    
    @discardableResult
    func delegate(_ delegate: UITextFieldDelegate?) -> LCZChain {
        base.delegate = delegate
        return self
    }
    
    @discardableResult
    func placeholder(_ placeholder: String?) -> LCZChain {
        base.placeholder = placeholder
        return self
    }
    
    @discardableResult
    func attributedPlaceholder(_ attributedPlaceholder: NSAttributedString?) -> LCZChain {
        base.attributedPlaceholder = attributedPlaceholder
        return self
    }
    
    @discardableResult
    func borderStyle(_ borderStyle: UITextField.BorderStyle) -> LCZChain {
        base.borderStyle = borderStyle
        return self
    }
    
    @discardableResult
    func text(_ text: String?) -> LCZChain {
        base.text = text
        return self
    }
    
    @discardableResult
    func textColor(_ textColor: UIColor) -> LCZChain {
        base.textColor = textColor
        return self
    }
    
    @discardableResult
    func font(_ font: UIFont) -> LCZChain {
        base.font = font
        return self
    }
    
    @discardableResult
    func backgroundColor(_ backgroundColor: UIColor) -> LCZChain {
        base.backgroundColor = backgroundColor
        return self
    }
    
    @discardableResult
    func frame(_ frame: CGRect) -> LCZChain {
        base.frame = frame
        return self
    }
    
    /// 是否显示清除按钮
    @discardableResult
    func clearButtonMode(_ clearButtonMode: UITextField.ViewMode) -> LCZChain {
        base.clearButtonMode  = clearButtonMode
        return self
    }
    
    /// 是否显示密文输入
    @discardableResult
    func isSecureTextEntry(_ isSecureTextEntry: Bool) -> LCZChain {
        base.isSecureTextEntry = isSecureTextEntry
        return self
    }
    
    /// 是否自动纠错
    @discardableResult
    func autocorrectionType(_ autocorrectionType: UITextAutocorrectionType) -> LCZChain {
        base.autocorrectionType = autocorrectionType
        return self
    }
    
    /// 是否再次编辑就清空
    @discardableResult
    func clearsOnBeginEditing(_ clearsOnBeginEditing: Bool) -> LCZChain {
        base.clearsOnBeginEditing = clearsOnBeginEditing
        return self
    }
    
    /// 内容对齐方式
    @discardableResult
    func textAlignment(_ textAlignment: NSTextAlignment) -> LCZChain {
        base.textAlignment = textAlignment
        return self
    }
    
    /// 是否自动缩小以适应文本窗口大小
    @discardableResult
    func adjustsFontSizeToFitWidth(_ adjustsFontSizeToFitWidth: Bool) -> LCZChain {
        base.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth
        return self
    }
    
    /// 设置自动缩小显示的最小字体大小
    @discardableResult
    func minimumFontSize(_ minimumFontSize: CGFloat) -> LCZChain {
        base.minimumFontSize = minimumFontSize
        return self
    }
    
    /// 键盘类型
    @discardableResult
    func keyboardType(_ keyboardType: UIKeyboardType) -> LCZChain {
        base.keyboardType = keyboardType
        return self
    }
    
    /// 首字母是否自动大写
    @discardableResult
    func autocapitalizationType(_ autocapitalizationType: UITextAutocapitalizationType) -> LCZChain {
        base.autocapitalizationType = autocapitalizationType
        return self
    }
    
    /// return键样式
    @discardableResult
    func returnKeyType(_ returnKeyType: UIReturnKeyType) -> LCZChain {
        base.returnKeyType = returnKeyType
        return self
    }
    
    /// 键盘外观
    @discardableResult
    func keyboardAppearance(_ keyboardAppearance: UIKeyboardAppearance) -> LCZChain {
        base.keyboardAppearance = keyboardAppearance
        return self
    }
    
    /// 左视图
    @discardableResult
    func leftView(_ leftView: UIView, _ leftViewMode: UITextField.ViewMode) -> LCZChain {
        base.leftView = leftView
        base.leftViewMode = leftViewMode
        return self
    }
    
    /// 右视图
    @discardableResult
    func rightView(_ rightView: UIView, _ rightViewMode: UITextField.ViewMode) -> LCZChain {
        base.rightView = rightView
        base.rightViewMode = rightViewMode
        return self
    }
    
    
    
 
}
