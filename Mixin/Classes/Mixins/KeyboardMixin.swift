//
//  KeyboardMixin.swift
//  Mixin
//
//  Created by one on 30/11/2017.
//  Copyright © 2017 one. All rights reserved.
//

import UIKit

public protocol KeyboardMixin: ViewControllerMixinable {
    var keyboardHeight: CGFloat? { set get }
    var viewControllerLifeCycle: UIViewControllerLifeCycle? { get }
}

public extension KeyboardMixin {
    var endEditingViews: [UIView]? { return nil }
    private func registerKeyboard() {
        NotificationCenter.default.addObserver(forName: NSNotification.Name.UIKeyboardWillHide, object: nil, queue: nil) { [weak self] notification in
            self?.keyboardHeight = nil
        }
        NotificationCenter.default.addObserver(forName: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil, queue: nil) { [weak self] notification in
            if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                self?.keyboardHeight = keyboardSize.height
            }
        }
    }
    private func deregisterKeyboard() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    fileprivate func viewWillAppear(_ animated: Bool) {
        print("KeyboardMixin viewWillAppear")
        registerKeyboard()
    }
    fileprivate func viewDidDisappear(_ animated: Bool) {
        deregisterKeyboard()
    }
}


/////////////////////////// Binding \\\\\\\\\\\\\\\\\\\\\\\\\\\

public extension KeyboardMixin {
    public var viewControllerLifeCycle: UIViewControllerLifeCycle? {
        return ViewControllerLifeCycle(mixin: self)
    }
}

private class ViewControllerLifeCycle<T: KeyboardMixin>: MixinableViewControllerLifeCycle<T> {
    @objc func viewWillAppear(_ animated: Bool) {
        mixin.viewWillAppear(animated)
    }
    @objc func viewDidDisappear(_ animated: Bool) {
        mixin.viewDidDisappear(animated)
    }
}
