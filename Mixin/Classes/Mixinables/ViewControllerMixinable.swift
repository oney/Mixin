//
//  ViewControllerMixinable.swift
//  Mixin
//
//  Created by one on 30/11/2017.
//  Copyright © 2017 one. All rights reserved.
//

import UIKit

@objc public protocol UIViewControllerLifeCycle: class {
    @objc optional func loadView()
    @objc optional func loadViewIfNeeded()
    @objc optional func viewDidLoad()
    @objc optional func prepare(for segue: UIStoryboardSegue, sender: Any?)
    @objc optional func viewWillAppear(_ animated: Bool)
    @objc optional func viewDidAppear(_ animated: Bool)
    @objc optional func viewWillDisappear(_ animated: Bool)
    @objc optional func viewDidDisappear(_ animated: Bool)
    @objc optional func viewWillLayoutSubviews()
    @objc optional func viewDidLayoutSubviews()
    @objc optional func didReceiveMemoryWarning()
}

public protocol ViewControllerMixinable: class {
    typealias LifeCycle = UIViewControllerLifeCycle
    var viewControllerLifeCycles: [LifeCycle?] { get }
}

public class MixinableViewControllerLifeCycle<T: ViewControllerMixinable>: NSObject, UIViewControllerLifeCycle {
    unowned let mixin: T
    init(mixin: T) {
        self.mixin = mixin
        super.init()
    }
}

public class BlockViewControllerLifeCycle: NSObject, UIViewControllerLifeCycle {
    typealias LoadView = () -> Void
    typealias LoadViewIfNeeded = () -> Void
    typealias ViewDidLoad = () -> Void
    typealias Prepare = (_ segue: UIStoryboardSegue, _ sender: Any?) -> Void
    typealias ViewWillAppear = (_ animated: Bool) -> Void
    typealias ViewDidAppear = (_ animated: Bool) -> Void
    typealias ViewWillDisappear = (_ animated: Bool) -> Void
    typealias ViewDidDisappear = (_ animated: Bool) -> Void
    typealias ViewWillLayoutSubviews = () -> Void
    typealias ViewDidLayoutSubviews = () -> Void
    typealias DidReceiveMemoryWarning = () -> Void
    
    private let _loadView: LoadView?
    private let _loadViewIfNeeded: LoadViewIfNeeded?
    private let _viewDidLoad: ViewDidLoad?
    private let _prepare: Prepare?
    private let _viewWillAppear: ViewWillAppear?
    private let _viewDidAppear: ViewDidAppear?
    private let _viewWillDisappear: ViewWillDisappear?
    private let _viewDidDisappear: ViewDidDisappear?
    private let _viewWillLayoutSubviews: ViewWillLayoutSubviews?
    private let _viewDidLayoutSubviews: ViewDidLayoutSubviews?
    private let _didReceiveMemoryWarning: DidReceiveMemoryWarning?
    
    init(
        loadView: LoadView? = nil,
        loadViewIfNeeded: LoadViewIfNeeded? = nil,
        viewDidLoad: ViewDidLoad? = nil,
        prepare: Prepare? = nil,
        viewWillAppear: ViewWillAppear? = nil,
        viewDidAppear: ViewDidAppear? = nil,
        viewWillDisappear: ViewWillDisappear? = nil,
        viewDidDisappear: ViewDidDisappear? = nil,
        viewWillLayoutSubviews: ViewWillLayoutSubviews? = nil,
        viewDidLayoutSubviews: ViewDidLayoutSubviews? = nil,
        didReceiveMemoryWarning: DidReceiveMemoryWarning? = nil
        ) {
        _loadView = loadView
        _loadViewIfNeeded = loadViewIfNeeded
        _viewDidLoad = viewDidLoad
        _prepare = prepare
        _viewWillAppear = viewWillAppear
        _viewDidAppear = viewDidAppear
        _viewWillDisappear = viewWillDisappear
        _viewDidDisappear = viewDidDisappear
        _viewWillLayoutSubviews = viewWillLayoutSubviews
        _viewDidLayoutSubviews = viewDidLayoutSubviews
        _didReceiveMemoryWarning = didReceiveMemoryWarning
        super.init()
    }
    public func loadView() {
        _loadView?()
    }
    public func loadViewIfNeeded() {
        _loadViewIfNeeded?()
    }
    public func viewDidLoad() {
        _viewDidLoad?()
    }
    public func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        _prepare?(segue, sender)
    }
    public func viewWillAppear(_ animated: Bool) {
        _viewWillAppear?(animated)
    }
    public func viewDidAppear(_ animated: Bool) {
        _viewDidAppear?(animated)
    }
    public func viewWillDisappear(_ animated: Bool) {
        _viewWillDisappear?(animated)
    }
    public func viewDidDisappear(_ animated: Bool) {
        _viewDidDisappear?(animated)
    }
    public func viewWillLayoutSubviews() {
        _viewWillLayoutSubviews?()
    }
    public func viewDidLayoutSubviews() {
        _viewDidLayoutSubviews?()
    }
    public func didReceiveMemoryWarning() {
        _didReceiveMemoryWarning?()
    }
}
