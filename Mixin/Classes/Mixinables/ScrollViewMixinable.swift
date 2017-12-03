//
//  ScrollViewMixinable.swift
//  Mixin
//
//  Created by one on 30/11/2017.
//  Copyright © 2017 one. All rights reserved.
//

import UIKit

public class MixinableScrollViewDelegate<T: ScrollViewMixinable>: NSObject, UIScrollViewDelegate {
    unowned var mixin: T
    init(mixin: T) {
        self.mixin = mixin
        super.init()
    }
}

public protocol ScrollViewMixinable: class {
    var scrollViewDelegates: [UIScrollViewDelegate?] { get }
}


public class BlockUIScrollViewDelegate: NSObject, UIScrollViewDelegate {
    typealias ScrollViewDidScroll = (_ scrollView: UIScrollView) -> Void
    typealias ScrollViewDidZoom = (_ scrollView: UIScrollView) -> Void
    typealias ScrollViewWillBeginDragging = (_ scrollView: UIScrollView) -> Void
    typealias ScrollViewDidEndDragging = (_ scrollView: UIScrollView, _ decelerate: Bool) -> Void
    typealias ScrollViewWillBeginDecelerating = (_ scrollView: UIScrollView) -> Void
    typealias ScrollViewDidEndDecelerating = (_ scrollView: UIScrollView) -> Void
    typealias ScrollViewDidEndScrollingAnimation = (_ scrollView: UIScrollView) -> Void
    typealias ScrollViewWillBeginZooming = (_ scrollView: UIScrollView, _ view: UIView?) -> Void
    typealias ScrollViewDidEndZooming = (_ scrollView: UIScrollView, _ view: UIView?, _ scale: CGFloat) -> Void
    typealias ScrollViewDidScrollToTop = (_ scrollView: UIScrollView) -> Void
    
    private let _scrollViewDidScroll: ScrollViewDidScroll?
    private let _scrollViewDidZoom: ScrollViewDidZoom?
    private let _scrollViewWillBeginDragging: ScrollViewWillBeginDragging?
    private let _scrollViewDidEndDragging: ScrollViewDidEndDragging?
    private let _scrollViewWillBeginDecelerating: ScrollViewWillBeginDecelerating?
    private let _scrollViewDidEndDecelerating: ScrollViewDidEndDecelerating?
    private let _scrollViewDidEndScrollingAnimation: ScrollViewDidEndScrollingAnimation?
    private let _scrollViewWillBeginZooming: ScrollViewWillBeginZooming?
    private let _scrollViewDidEndZooming: ScrollViewDidEndZooming?
    private let _scrollViewDidScrollToTop: ScrollViewDidScrollToTop?

    init(
        scrollViewDidScroll: ScrollViewDidScroll? = nil,
        scrollViewDidZoom: ScrollViewDidZoom? = nil,
        scrollViewWillBeginDragging: ScrollViewWillBeginDragging? = nil,
        scrollViewDidEndDragging: ScrollViewDidEndDragging? = nil,
        scrollViewWillBeginDecelerating: ScrollViewWillBeginDecelerating? = nil,
        scrollViewDidEndDecelerating: ScrollViewDidEndDecelerating? = nil,
        scrollViewDidEndScrollingAnimation: ScrollViewDidEndScrollingAnimation? = nil,
        scrollViewWillBeginZooming: ScrollViewWillBeginZooming? = nil,
        scrollViewDidEndZooming: ScrollViewDidEndZooming? = nil,
        scrollViewDidScrollToTop: ScrollViewDidScrollToTop? = nil
        ) {
        _scrollViewDidScroll = scrollViewDidScroll
        _scrollViewDidZoom = scrollViewDidZoom
        _scrollViewWillBeginDragging = scrollViewWillBeginDragging
        _scrollViewDidEndDragging = scrollViewDidEndDragging
        _scrollViewWillBeginDecelerating = scrollViewWillBeginDecelerating
        _scrollViewDidEndDecelerating = scrollViewDidEndDecelerating
        _scrollViewDidEndScrollingAnimation = scrollViewDidEndScrollingAnimation
        _scrollViewWillBeginZooming = scrollViewWillBeginZooming
        _scrollViewDidEndZooming = scrollViewDidEndZooming
        _scrollViewDidScrollToTop = scrollViewDidScrollToTop
        super.init()
    }
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        _scrollViewDidScroll?(scrollView)
    }
    public func scrollViewDidZoom(_ scrollView: UIScrollView) {
        _scrollViewDidZoom?(scrollView)
    }
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        _scrollViewWillBeginDragging?(scrollView)
    }
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        _scrollViewDidEndDragging?(scrollView, decelerate)
    }
    public func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        _scrollViewWillBeginDecelerating?(scrollView)
    }
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        _scrollViewDidEndDecelerating?(scrollView)
    }
    public func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        _scrollViewDidEndScrollingAnimation?(scrollView)
    }
    public func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        _scrollViewWillBeginZooming?(scrollView, view)
    }
    public func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        _scrollViewDidEndZooming?(scrollView, view, scale)
    }
    public func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        _scrollViewDidScrollToTop?(scrollView)
    }
}
