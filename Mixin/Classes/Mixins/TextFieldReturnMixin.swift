//
//  TextFieldReturnMixin.swift
//  Mixin
//
//  Created by one on 30/11/2017.
//  Copyright © 2017 one. All rights reserved.
//

import UIKit

public protocol TextFieldReturnMixin: TextFieldDelegateMixinable {
    var endEditingViews: [UIView]? { get }
    func TextFieldReturnMixin_textFieldShouldReturn(_ textField: UITextField) -> Bool
    var textFieldDelegate: UITextFieldDelegate? { get }
}

public extension TextFieldReturnMixin {
    fileprivate func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    fileprivate func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
}

public extension TextFieldReturnMixin where Self: Any {
    public func TextFieldReturnMixin_textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let views = endEditingViews {
            views.forEach{$0.endEditing(true)}
        }
        return true
    }
}

public extension TextFieldReturnMixin where Self: UIViewController {
    public var endEditingViews: [UIView]? { return nil }
    public func TextFieldReturnMixin_textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}


/////////////////////////// Binding \\\\\\\\\\\\\\\\\\\\\\\\\\\

public extension TextFieldReturnMixin {
    public var textFieldDelegate: UITextFieldDelegate? {
        return TextFieldDelegate(mixin: self)
    }
}

private class TextFieldDelegate<T: TextFieldReturnMixin>: MixinableTextFieldDelegate<T> {
    @objc func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return mixin.TextFieldReturnMixin_textFieldShouldReturn(textField)
    }
}
