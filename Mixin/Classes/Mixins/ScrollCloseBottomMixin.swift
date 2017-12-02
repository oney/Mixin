//
//  ScrollCloseBottomMixin.swift
//  Mixin
//
//  Created by one on 30/11/2017.
//  Copyright © 2017 one. All rights reserved.
//

import UIKit

public protocol ScrollCloseBottomMixin: ScrollViewMixinable {
    var scrollCloseBottomThreshold: CGFloat { get }
    func closeBottom()
    var scrollViewDelegate: UIScrollViewDelegate? { get }
}

public extension ScrollCloseBottomMixin {
    fileprivate func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("ScrollCloseBottomMixin scrollViewDidScroll")
        if scrollView.scrollOver(offset: scrollCloseBottomThreshold) {
            closeBottom()
        }
    }
}


/////////////////////////// Binding \\\\\\\\\\\\\\\\\\\\\\\\\\\

public extension ScrollCloseBottomMixin {
    public var scrollViewDelegate: UIScrollViewDelegate? {
        return ScrollViewDelegate(mixin: self)
    }
}

private var scrollViewDelegateKey: Void?
private class ScrollViewDelegate<T: ScrollCloseBottomMixin>: MixinableScrollViewDelegate<T> {
    @objc func scrollViewDidScroll(_ scrollView: UIScrollView) {
        mixin.scrollViewDidScroll(scrollView)
    }
}
