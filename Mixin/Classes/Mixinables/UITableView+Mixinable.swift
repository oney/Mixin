//
//  UITableView+Mixinable.swift
//  Mixin
//
//  Created by one on 30/11/2017.
//  Copyright © 2017 one. All rights reserved.
//

import UIKit

extension UITableView: SelfAware2 {
    typealias SelfMixinable = TableViewDelegateMixinable
    static func awake2() {
        UITableView.classInit()
    }
    private static func classInit() {
        swizzleMethod
    }
    private static let swizzleMethod: Void = {
        mxx_swizzlingClass(UITableView.self, originalSelector: #selector(setter: UITableView.delegate), swizzledSelector: #selector(mxx_setTableViewDelegate(delegate:)))
        mxx_swizzlingClass(UITableView.self, originalSelector: #selector(reloadData), swizzledSelector: #selector(mxx_reloadData))
    }()
    
    @objc func mxx_setTableViewDelegate(delegate: UITableViewDelegate?) {
        if let delegate = delegate {
            mxx_swizzlingDelegate(type(of: delegate), UITableView.self, #selector(delegate.tableView(_:didSelectRowAt:)), #selector(mxx_tableView(_:didSelectRowAt:)), emptySelector: #selector(e_mxx_tableView(_:didSelectRowAt:)))
        }
        
        mxx_setTableViewDelegate(delegate: delegate)
    }
    
    @objc func mxx_reloadData() {
        mxx_reloadData()
        if let s = self.delegate as? SelfMixinable {
            s.tableViewDelegates.forEach{$0?.afterReloadData?()}
        }
    }
    
    @objc func e_mxx_tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    @objc func mxx_tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let s = self as? SelfMixinable {
            s.tableViewDelegates.forEach{$0?.tableView?(tableView, didSelectRowAt: indexPath)}
        }
        mxx_tableView(tableView, didSelectRowAt: indexPath)
    }
    
}
