//
//  Swizzling.swift
//  Swizzling
//
//  Created by Sergey Pugach on 10/6/17.
//  Copyright © 2017 Sergey Pugach. All rights reserved.
//

import Foundation

let classMethodSwizzling: (AnyClass, Selector, Selector) -> () = { forClass, originalSelector, swizzledSelector in
    
    guard
        let originalMethod = class_getClassMethod(forClass, originalSelector),
        let swizzledMethod = class_getClassMethod(forClass, swizzledSelector) else { return }
    
    method_exchangeImplementations(originalMethod, swizzledMethod)
}

let instanceMethodSwizzling: (AnyClass, Selector, Selector) -> () = { forClass, originalSelector, swizzledSelector in
    
    guard
        let originalMethod = class_getInstanceMethod(forClass, originalSelector),
        let swizzledMethod = class_getInstanceMethod(forClass, swizzledSelector) else { return }
    
//    let didAddMethod = class_addMethod(forClass, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))
//
//    if didAddMethod {
//        class_replaceMethod(forClass, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
//    } else {
//        method_exchangeImplementations(originalMethod, swizzledMethod)
//    }
    
    method_exchangeImplementations(originalMethod, swizzledMethod)
}
