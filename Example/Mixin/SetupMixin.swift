//
//  SetupMixin.swift
//  Mixin_Example
//
//  Created by one on 03/12/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import Mixin

extension ViewControllerMixinable {
    var viewControllerLifeCycles: [LifeCycle?] {
        return [
            (self as? StandardTableMixin)?.viewControllerLifeCycle,
            (self as? KeyboardMixin)?.viewControllerLifeCycle,
        ]
    }
}

extension ScrollViewMixinable {
    var scrollViewDelegates: [UIScrollViewDelegate?] {
        return [
            (self as? ScrollCloseBottomMixin)?.scrollViewDelegate,
            (self as? ScrollFinishMixin)?.scrollViewDelegate2,
        ]
    }
}

extension TableViewDelegateMixinable {
    var tableViewDelegates: [ExtendTableViewDelegate?] {
        return [
            (self as? StandardTableMixin)?.tableViewDelegate,
        ]
    }
}

extension TextFieldDelegateMixinable {
    var textFieldDelegates: [UITextFieldDelegate?] {
        return [
            (self as? TextFieldReturnMixin)?.textFieldDelegate,
        ]
    }
}
