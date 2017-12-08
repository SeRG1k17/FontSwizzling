//
//  FontReplacer.swift
//  Swizzling
//
//  Created by Sergey Pugach on 12/8/17.
//  Copyright © 2017 Sergey Pugach. All rights reserved.
//

import UIKit

class FontReplacer {
    
    static let shared = FontReplacer()
    
    var fontFamily: String!
    var separator: String!
    
    private init() {}
    
    func replaceSystemFontsFamily(to fontFamily: String, separator: String = "-") {
        self.fontFamily = fontFamily
        self.separator = separator
        
        UIView.classInit
        UIFont.classInit
    }
}
