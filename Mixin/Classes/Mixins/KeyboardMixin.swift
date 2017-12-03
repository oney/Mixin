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
    var viewControllerLifeCycle_KeyboardMixin: UIViewControllerLifeCycle { get }
}

public extension KeyboardMixin {
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
    private func viewWillAppear(_ animated: Bool) {
        print("KeyboardMixin viewWillAppear")
        registerKeyboard()
    }
    private func viewWillDisappear(_ animated: Bool) {
        deregisterKeyboard()
    }
    public var viewControllerLifeCycle_KeyboardMixin: UIViewControllerLifeCycle {
        return BlockViewControllerLifeCycle(
            viewWillAppear: viewWillAppear,
            viewWillDisappear: viewWillDisappear
        )
    }
}
