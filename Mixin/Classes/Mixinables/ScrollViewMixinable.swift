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

public protocol ScrollViewMixinable: class, UIScrollViewDelegate {
    var scrollViewDelegates: [UIScrollViewDelegate?] { get }
}
