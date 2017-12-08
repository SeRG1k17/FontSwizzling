//
//  String.swift
//  Swizzling
//
//  Created by Sergey Pugach on 12/8/17.
//  Copyright © 2017 Sergey Pugach. All rights reserved.
//

import Foundation

extension String {
    var removeWhitespaces: String {
        return components(separatedBy: .whitespaces).joined()
    }
}
