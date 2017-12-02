//
//  Runtime.swift
//  Mixin
//
//  Created by one on 30/11/2017.
//  Copyright © 2017 one. All rights reserved.
//

import Foundation

func mxx_swizzlingClass(_ forClass: AnyClass, originalSelector: Selector, swizzledSelector: Selector) {
    guard let originalMethod = class_getInstanceMethod(forClass, originalSelector), let swizzledMethod = class_getInstanceMethod(forClass, swizzledSelector) else {
        return
    }
    if class_addMethod(forClass, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod)) {
        class_replaceMethod(forClass, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod)
    }
}


func mxx_swizzlingDelegate(_ forClass: AnyClass, _ swizzledClass: AnyClass, _ originalSelector: Selector, _ swizzledSelector: Selector, emptySelector: Selector) {
    let swizzledMethod = class_getInstanceMethod(swizzledClass, swizzledSelector)!
    
    let originalMethod = class_getInstanceMethod(forClass, originalSelector)
    if originalMethod == nil {
        let addMethod = class_getInstanceMethod(swizzledClass, emptySelector)!
        class_addMethod(forClass, originalSelector, method_getImplementation(addMethod), method_getTypeEncoding(addMethod))
    }
    
    let didAddMethod = class_addMethod(forClass, swizzledSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))
    if didAddMethod {
        let didSelectOriginalMethod = class_getInstanceMethod(forClass, swizzledSelector)!
        let didSelectSwizzledMethod = class_getInstanceMethod(forClass, originalSelector)!
        method_exchangeImplementations(didSelectOriginalMethod, didSelectSwizzledMethod)
    }
}

protocol SelfAware: class {
    static func awake()
}
protocol SelfAware2: class {
    static func awake2()
}

class NothingToSeeHere {
    static func harmlessFunction() {
        let typeCount = Int(objc_getClassList(nil, 0))
        let types = UnsafeMutablePointer<AnyClass>.allocate(capacity: typeCount)
        let autoreleasingTypes = AutoreleasingUnsafeMutablePointer<AnyClass>(types)
        objc_getClassList(autoreleasingTypes, Int32(typeCount))
        for index in 0 ..< typeCount {
            (types[index] as? SelfAware.Type)?.awake()
            (types[index] as? SelfAware2.Type)?.awake2()
        }
        types.deallocate(capacity: typeCount)
    }
}
extension UIApplication {
    private static let runOnce: Void = {
        NothingToSeeHere.harmlessFunction()
    }()
    override open var next: UIResponder? {
        // Called before applicationDidFinishLaunching
        UIApplication.runOnce
        return super.next
    }
}

