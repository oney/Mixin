//
//  TableViewMixinable.swift
//  Mixin
//
//  Created by one on 30/11/2017.
//  Copyright © 2017 one. All rights reserved.
//

import UIKit

@objc public protocol ExtendTableViewDelegate: UITableViewDelegate {
    @objc optional func afterReloadData()
}

public class MixinableTableViewDelegate<T: TableViewDelegateMixinable>: NSObject, ExtendTableViewDelegate {
    unowned let mixin: T
    init(mixin: T) {
        self.mixin = mixin
        super.init()
    }
}

public protocol TableViewDelegateMixinable: class {
    var tableViewDelegates: [ExtendTableViewDelegate?] { get }
}
