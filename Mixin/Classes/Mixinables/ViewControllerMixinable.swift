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

public class MixinableViewControllerLifeCycle<T: ViewControllerMixinable>: NSObject, UIViewControllerLifeCycle {
    unowned let mixin: T
    init(mixin: T) {
        self.mixin = mixin
        super.init()
    }
}

public protocol ViewControllerMixinable: class {
    typealias LifeCycle = UIViewControllerLifeCycle
    var viewControllerLifeCycles: [LifeCycle?] { get }
}

