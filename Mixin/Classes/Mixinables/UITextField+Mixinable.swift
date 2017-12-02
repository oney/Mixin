//
//  UITextField+Mixinable.swift
//  Mixin
//
//  Created by one on 30/11/2017.
//  Copyright © 2017 one. All rights reserved.
//

import UIKit

extension UITextField: SelfAware {
    typealias Mixinable = TextFieldDelegateMixinable
    static func awake() {
        UITextField.classInit()
    }
    private static func classInit() {
        swizzleMethod
    }
    private static let swizzleMethod: Void = {
        mxx_swizzlingClass(UITextField.self, originalSelector: #selector(setter: UITextField.delegate), swizzledSelector: #selector(mxx_set(delegate:)))
    }()
    
    @objc func mxx_set(delegate: UITextFieldDelegate?) {
        if let delegate = delegate {
            mxx_swizzlingDelegate(type(of: delegate), UITextField.self, #selector(delegate.textFieldShouldReturn(_:)), #selector(mxx_textFieldShouldReturn(_:)), emptySelector: #selector(e_mxx_textFieldShouldReturn(_:)))
        }
        mxx_set(delegate: delegate)
    }
    
    @objc func e_mxx_textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return false
    }
    @objc func mxx_textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let prev = mxx_textFieldShouldReturn(textField)
        if let s = self as? Mixinable {
            return s.textFieldDelegates.reduce(prev) { (prev, delegate) in
                if let res = delegate?.textFieldShouldReturn?(textField) {
                    return (prev || res)
                } else {
                    return prev
                }
            }
        }
        return prev
    }
}
