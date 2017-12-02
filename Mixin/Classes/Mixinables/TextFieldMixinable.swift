//
//  TextFieldMixinable.swift
//  Mixin
//
//  Created by one on 30/11/2017.
//  Copyright © 2017 one. All rights reserved.
//

import UIKit

public class MixinableTextFieldDelegate<T: TextFieldDelegateMixinable>: NSObject, UITextFieldDelegate {
    let mixin: T
    init(mixin: T) {
        self.mixin = mixin
        super.init()
    }
}

public protocol TextFieldDelegateMixinable: class {
    var textFieldDelegates: [UITextFieldDelegate?] { get }
}
