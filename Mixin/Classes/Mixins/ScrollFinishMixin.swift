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
    var scrollViewDelegate_ScrollFinishMixin: UIScrollViewDelegate { get }
}

public extension ScrollFinishMixin {
    private func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            scrollFinish(scrollView)
        }
    }
    private func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollFinish(scrollView)
    }
    private func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            self.scrollFinish(scrollView)
        }
    }
    public var scrollViewDelegate_ScrollFinishMixin: UIScrollViewDelegate {
        return BlockUIScrollViewDelegate(
            scrollViewDidEndDragging: scrollViewDidEndDragging,
            scrollViewDidEndDecelerating: scrollViewDidEndDecelerating,
            scrollViewDidEndScrollingAnimation: scrollViewDidEndScrollingAnimation
        )
    }
}
