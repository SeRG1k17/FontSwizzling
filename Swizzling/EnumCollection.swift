//
//  EnumCollection.swift
//  Swizzling
//
//  Created by Sergey Pugach on 12/8/17.
//  Copyright © 2017 Sergey Pugach. All rights reserved.
//

import Foundation

public protocol EnumCollection: Hashable {
    
    static var cases: AnySequence<Self> { get }
    static var values: [Self] { get }
}

public extension EnumCollection {
    
    public static var cases: AnySequence<Self> {
        return AnySequence { () -> AnyIterator<Self> in
            var raw = 0
            return AnyIterator {
                let current: Self = withUnsafePointer(to: &raw) { $0.withMemoryRebound(to: self, capacity: 1) { $0.pointee } }
                guard current.hashValue == raw else {
                    return nil
                }
                raw += 1
                return current
            }
        }
    }
    
    public static var values: [Self] {
        return Array(cases)
    }
}
