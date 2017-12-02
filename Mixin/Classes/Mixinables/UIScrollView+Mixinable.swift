//
//  UIScrollView+Mixinable.swift
//  Mixin
//
//  Created by one on 30/11/2017.
//  Copyright © 2017 one. All rights reserved.
//

import UIKit

extension UIScrollView: SelfAware {
    typealias Mixinable = ScrollViewMixinable
    static func awake() {
        UIScrollView.classInit()
    }
    private static func classInit() {
        swizzleMethod
    }
    private static let swizzleMethod: Void = {
        mxx_swizzlingClass(UIScrollView.self, originalSelector: #selector(setter: UIScrollView.delegate), swizzledSelector: #selector(mxx_set(delegate:)))
    }()
    @objc func mxx_set(delegate: UIScrollViewDelegate?) {
        if let delegate = delegate {
            mxx_swizzlingDelegate(type(of: delegate), UIScrollView.self, #selector(delegate.scrollViewDidScroll(_:)), #selector(mxx_scrollViewDidScroll(_:)), emptySelector: #selector(e_mxx_scrollViewDidScroll(_:)))
            mxx_swizzlingDelegate(type(of: delegate), UIScrollView.self, #selector(delegate.scrollViewDidZoom(_:)), #selector(mxx_scrollViewDidZoom(_:)), emptySelector: #selector(e_mxx_scrollViewDidZoom(_:)))
            mxx_swizzlingDelegate(type(of: delegate), UIScrollView.self, #selector(delegate.scrollViewWillBeginDragging(_:)), #selector(mxx_scrollViewWillBeginDragging(_:)), emptySelector: #selector(e_mxx_scrollViewWillBeginDragging(_:)))
            mxx_swizzlingDelegate(type(of: delegate), UIScrollView.self, #selector(delegate.scrollViewDidEndDragging(_:willDecelerate:)), #selector(mxx_scrollViewDidEndDragging(_:willDecelerate:)), emptySelector: #selector(e_mxx_scrollViewDidEndDragging(_:willDecelerate:)))
            mxx_swizzlingDelegate(type(of: delegate), UIScrollView.self, #selector(delegate.scrollViewWillBeginDecelerating(_:)), #selector(mxx_scrollViewWillBeginDecelerating(_:)), emptySelector: #selector(e_mxx_scrollViewWillBeginDecelerating(_:)))
            mxx_swizzlingDelegate(type(of: delegate), UIScrollView.self, #selector(delegate.scrollViewDidEndDecelerating(_:)), #selector(mxx_scrollViewDidEndDecelerating(_:)), emptySelector: #selector(e_mxx_scrollViewDidEndDecelerating(_:)))
            mxx_swizzlingDelegate(type(of: delegate), UIScrollView.self, #selector(delegate.scrollViewDidEndScrollingAnimation(_:)), #selector(mxx_scrollViewDidEndScrollingAnimation(_:)), emptySelector: #selector(e_mxx_scrollViewDidEndScrollingAnimation(_:)))
            mxx_swizzlingDelegate(type(of: delegate), UIScrollView.self, #selector(delegate.scrollViewWillBeginZooming(_:with:)), #selector(mxx_scrollViewWillBeginZooming(_:with:)), emptySelector: #selector(e_mxx_scrollViewWillBeginZooming(_:with:)))
            mxx_swizzlingDelegate(type(of: delegate), UIScrollView.self, #selector(delegate.scrollViewDidEndZooming(_:with:atScale:)), #selector(mxx_scrollViewDidEndZooming(_:with:atScale:)), emptySelector: #selector(e_mxx_scrollViewDidEndZooming(_:with:atScale:)))
            mxx_swizzlingDelegate(type(of: delegate), UIScrollView.self, #selector(delegate.scrollViewDidScrollToTop(_:)), #selector(mxx_scrollViewDidScrollToTop(_:)), emptySelector: #selector(e_mxx_scrollViewDidScrollToTop(_:)))
        }
        
        mxx_set(delegate: delegate)
    }
    @objc func e_mxx_scrollViewDidScroll(_ scrollView: UIScrollView) {}
    @objc func mxx_scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let s = self as? Mixinable {
            s.scrollViewDelegates.forEach{$0?.scrollViewDidScroll?(scrollView)}
        }
        mxx_scrollViewDidScroll(scrollView)
    }
    @objc func e_mxx_scrollViewDidZoom(_ scrollView: UIScrollView) {}
    @objc func mxx_scrollViewDidZoom(_ scrollView: UIScrollView) {
        if let s = self as? Mixinable {
            s.scrollViewDelegates.forEach{$0?.scrollViewDidZoom?(scrollView)}
        }
        mxx_scrollViewDidZoom(scrollView)
    }
    @objc func e_mxx_scrollViewWillBeginDragging(_ scrollView: UIScrollView) {}
    @objc func mxx_scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if let s = self as? Mixinable {
            s.scrollViewDelegates.forEach{$0?.scrollViewWillBeginDragging?(scrollView)}
        }
        mxx_scrollViewWillBeginDragging(scrollView)
    }
    @objc func e_mxx_scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {}
    @objc func mxx_scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if let s = self as? Mixinable {
            s.scrollViewDelegates.forEach{$0?.scrollViewDidEndDragging?(scrollView, willDecelerate: decelerate)}
        }
        mxx_scrollViewDidEndDragging(scrollView, willDecelerate: decelerate)
    }
    @objc func e_mxx_scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {}
    @objc func mxx_scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        if let s = self as? Mixinable {
            s.scrollViewDelegates.forEach{$0?.scrollViewWillBeginDecelerating?(scrollView)}
        }
        mxx_scrollViewWillBeginDecelerating(scrollView)
    }
    @objc func e_mxx_scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {}
    @objc func mxx_scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if let s = self as? Mixinable {
            s.scrollViewDelegates.forEach{$0?.scrollViewDidEndDecelerating?(scrollView)}
        }
        mxx_scrollViewDidEndDecelerating(scrollView)
    }
    @objc func e_mxx_scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {}
    @objc func mxx_scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        if let s = self as? Mixinable {
            s.scrollViewDelegates.forEach{$0?.scrollViewDidEndScrollingAnimation?(scrollView)}
        }
        mxx_scrollViewDidEndScrollingAnimation(scrollView)
    }
    @objc func e_mxx_scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {}
    @objc func mxx_scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        if let s = self as? Mixinable {
            s.scrollViewDelegates.forEach{$0?.scrollViewWillBeginZooming?(scrollView, with: view)}
        }
        mxx_scrollViewWillBeginZooming(scrollView, with: view)
    }
    @objc func e_mxx_scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {}
    @objc func mxx_scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        if let s = self as? Mixinable {
            s.scrollViewDelegates.forEach{$0?.scrollViewDidEndZooming?(scrollView, with: view, atScale: scale)}
        }
        mxx_scrollViewDidEndZooming(scrollView, with: view, atScale: scale)
    }
    @objc func e_mxx_scrollViewDidScrollToTop(_ scrollView: UIScrollView) {}
    @objc func mxx_scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        if let s = self as? Mixinable {
            s.scrollViewDelegates.forEach{$0?.scrollViewDidScrollToTop?(scrollView)}
        }
        mxx_scrollViewDidScrollToTop(scrollView)
    }
}
