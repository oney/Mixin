//
//  StandardTableMixin.swift
//  Mixin
//
//  Created by one on 30/11/2017.
//  Copyright © 2017 one. All rights reserved.
//

import UIKit

public protocol StandardTableMixin: ScrollCloseBottomMixin, ViewControllerMixinable, TableViewDelegateMixinable {
    var findTableView: UITableView? { get }
    var addRefreshControl: Bool { get }
    func refresh()
    func loadMore()
    func showPagingSpinner() -> Bool
    var viewControllerLifeCycle_StandardTableMixin: UIViewControllerLifeCycle { get }
    var tableViewDelegate: ExtendTableViewDelegate? { get }
}

public extension StandardTableMixin {
    var addRefreshControl: Bool { return true }
    var scrollCloseBottomThreshold: CGFloat { return 200 }
    func closeBottom() {
        loadMore()
    }
    fileprivate func viewWillAppear(_ animated: Bool) {
        print("StandardTableMixin viewWillAppear")
    }
    fileprivate func viewDidLoad() {
        print("StandardTableMixin viewDidLoad")
        configure()
    }
    fileprivate func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("StandardTableMixin didSelectRowAt")
    }
    private func configure() {
        if let tableView = findTableView {
            if addRefreshControl {
                if #available(iOS 10.0, *) {
                    tableView.refreshControl = {
                        $0.tintColor = .gray
                        $0.addAction(for: .valueChanged) { [weak self] in
                            self?.refresh()
                        }
                        return $0
                    }(UIRefreshControl())
                } else {
                    // FIXME: add refreshControl by yourself
                }
            }
        }
    }
    fileprivate func afterReloadData() {
        guard let tableView = findTableView else { return }
        tableView.tableFooterView = {
            if showPagingSpinner() {
                let v = UIActivityIndicatorView(activityIndicatorStyle: .gray)
                v.hidesWhenStopped = true
                v.startAnimating()
                return v
            } else {
                return nil
            }
        }()
    }
}


/////////////////////////// Binding \\\\\\\\\\\\\\\\\\\\\\\\\\\

class TableViewDelegate: NSObject, ExtendTableViewDelegate {
    unowned let mixin: StandardTableMixin
    init(mixin: StandardTableMixin) {
        self.mixin = mixin
        super.init()
    }
    @objc func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        mixin.tableView(tableView, didSelectRowAt: indexPath)
    }
    @objc func afterReloadData() {
        mixin.afterReloadData()
    }
}

public extension StandardTableMixin {
    public var viewControllerLifeCycle_StandardTableMixin: UIViewControllerLifeCycle {
        return BlockViewControllerLifeCycle(
            viewDidLoad: viewDidLoad,
            viewWillAppear: viewWillAppear
        )
    }
    public var tableViewDelegate: ExtendTableViewDelegate? {
        return TableViewDelegate(mixin: self)
    }
}
