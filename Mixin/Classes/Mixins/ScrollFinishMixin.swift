//
//  ScrollFinishMixin.swift
//  Mixin
//
//  Created by one on 30/11/2017.
//  Copyright © 2017 one. All rights reserved.
//

import UIKit

public protocol ScrollFinishMixin: ScrollViewMixinable {
    func scrollFinish(_ scrollView: UIScrollView)
    var scrollViewDelegate2: UIScrollViewDelegate? { get }
}

public extension ScrollFinishMixin {
    fileprivate func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            scrollFinish(scrollView)
        }
    }
    fileprivate func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollFinish(scrollView)
    }
    fileprivate func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            self.scrollFinish(scrollView)
        }
    }
}


/////////////////////////// Binding \\\\\\\\\\\\\\\\\\\\\\\\\\\

public extension ScrollFinishMixin {
    public var scrollViewDelegate2: UIScrollViewDelegate? {
        return ScrollViewDelegate(mixin: self)
    }
}

private var scrollViewDelegateKey: Void?
private class ScrollViewDelegate<T: ScrollFinishMixin>: MixinableScrollViewDelegate<T> {
    @objc func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        mixin.scrollViewDidEndDragging(scrollView, willDecelerate: decelerate)
    }
    @objc func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        mixin.scrollViewDidEndDecelerating(scrollView)
    }
    @objc func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        mixin.scrollViewDidEndScrollingAnimation(scrollView)
    }
}

