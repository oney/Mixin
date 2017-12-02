//
//  Util.swift
//  Mixin
//
//  Created by one on 30/11/2017.
//  Copyright © 2017 one. All rights reserved.
//

import UIKit

extension UIScrollView {
    func scrollOver(offset: CGFloat, isVertical: Bool = true) -> Bool {
        return isVertical ?
            contentOffset.y + frame.height + offset > contentSize.height :
            contentOffset.x + frame.width + offset > contentSize.width
    }
}

extension UIControl {
    func addAction(for controlEvents: UIControlEvents, action: @escaping () -> ()) {
        let sleeve = ClosureSleeve(attachTo: self, closure: action)
        addTarget(sleeve, action: #selector(ClosureSleeve.invoke), for: controlEvents)
    }
}

// https://stackoverflow.com/a/44917661/2790103
class ClosureSleeve {
    let closure: () -> ()
    
    init(attachTo: AnyObject, closure: @escaping () -> ()) {
        self.closure = closure
        objc_setAssociatedObject(attachTo, "[\(arc4random())]", self, .OBJC_ASSOCIATION_RETAIN)
    }
    
    @objc func invoke() {
        closure()
    }
}
