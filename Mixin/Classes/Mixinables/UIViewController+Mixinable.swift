//
//  UIViewController+Mixinable.swift
//  Mixin
//
//  Created by one on 30/11/2017.
//  Copyright © 2017 one. All rights reserved.
//

import UIKit

extension UIViewController: SelfAware {
    typealias Mixinable = ViewControllerMixinable
    static func awake() {
        UIViewController.classInit()
    }
    private static func classInit() {
        swizzleMethod
    }
    private static let swizzleMethod: Void = {
        mxx_swizzlingClass(UIViewController.self, originalSelector: #selector(loadView), swizzledSelector: #selector(mxx_loadView))
        mxx_swizzlingClass(UIViewController.self, originalSelector: #selector(viewDidLoad), swizzledSelector: #selector(mxx_viewDidLoad))
        mxx_swizzlingClass(UIViewController.self, originalSelector: #selector(prepare(for:sender:)), swizzledSelector: #selector(mxx_prepare(for:sender:)))
        mxx_swizzlingClass(UIViewController.self, originalSelector: #selector(viewWillAppear(_:)), swizzledSelector: #selector(mxx_viewWillAppear(_:)))
        mxx_swizzlingClass(UIViewController.self, originalSelector: #selector(viewDidAppear(_:)), swizzledSelector: #selector(mxx_viewDidAppear(_:)))
        mxx_swizzlingClass(UIViewController.self, originalSelector: #selector(viewWillDisappear(_:)), swizzledSelector: #selector(mxx_viewWillDisappear(_:)))
        mxx_swizzlingClass(UIViewController.self, originalSelector: #selector(viewDidDisappear(_:)), swizzledSelector: #selector(mxx_viewDidDisappear(_:)))
        mxx_swizzlingClass(UIViewController.self, originalSelector: #selector(viewWillLayoutSubviews), swizzledSelector: #selector(mxx_viewWillLayoutSubviews))
        mxx_swizzlingClass(UIViewController.self, originalSelector: #selector(viewDidLayoutSubviews), swizzledSelector: #selector(mxx_viewDidLayoutSubviews))
        mxx_swizzlingClass(UIViewController.self, originalSelector: #selector(didReceiveMemoryWarning), swizzledSelector: #selector(mxx_didReceiveMemoryWarning))
    }()
    
    @objc func mxx_loadView() {
        if let s = self as? Mixinable {
            s.viewControllerLifeCycles.forEach{$0?.loadView?()}
        }
        mxx_loadView()
    }
    
    @objc func mxx_viewDidLoad() {
        if let s = self as? Mixinable {
            s.viewControllerLifeCycles.forEach{$0?.viewDidLoad?()}
        }
        mxx_viewDidLoad()
    }
    
    @objc func mxx_prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let s = self as? Mixinable {
            s.viewControllerLifeCycles.forEach{$0?.prepare?(for: segue, sender: sender)}
        }
        mxx_prepare(for: segue, sender: sender)
    }
    
    @objc func mxx_viewWillAppear(_ animated: Bool) {
        if let s = self as? Mixinable {
            s.viewControllerLifeCycles.forEach{$0?.viewWillAppear?(animated)}
        }
        mxx_viewWillAppear(animated)
    }
    
    @objc func mxx_viewDidAppear(_ animated: Bool) {
        if let s = self as? Mixinable {
            s.viewControllerLifeCycles.forEach{$0?.viewDidAppear?(animated)}
        }
        mxx_viewDidAppear(animated)
    }
    
    @objc func mxx_viewWillDisappear(_ animated: Bool) {
        if let s = self as? Mixinable {
            s.viewControllerLifeCycles.forEach{$0?.viewWillDisappear?(animated)}
        }
        mxx_viewWillDisappear(animated)
    }
    
    @objc func mxx_viewDidDisappear(_ animated: Bool) {
        if let s = self as? Mixinable {
            s.viewControllerLifeCycles.forEach{$0?.viewDidDisappear?(animated)}
        }
        mxx_viewDidDisappear(animated)
    }
    
    @objc func mxx_viewWillLayoutSubviews() {
        if let s = self as? Mixinable {
            s.viewControllerLifeCycles.forEach{$0?.viewWillLayoutSubviews?()}
        }
        mxx_viewWillLayoutSubviews()
    }
    
    @objc func mxx_viewDidLayoutSubviews() {
        if let s = self as? Mixinable {
            s.viewControllerLifeCycles.forEach{$0?.viewDidLayoutSubviews?()}
        }
        mxx_viewDidLayoutSubviews()
    }
    
    @objc func mxx_didReceiveMemoryWarning() {
        if let s = self as? Mixinable {
            s.viewControllerLifeCycles.forEach{$0?.didReceiveMemoryWarning?()}
        }
        mxx_didReceiveMemoryWarning()
    }
}
