//
//  FontWeight.swift
//  Swizzling
//
//  Created by Sergey Pugach on 12/8/17.
//  Copyright © 2017 Sergey Pugach. All rights reserved.
//

import UIKit


enum FontWeight: EnumCollection {
    
    case ultraLight, thin, light, regular, medium, semibold, bold, heavy, black
    
    var description: String {
        return String(describing: self).capitalized
    }
    
    private var weight: UIFont.Weight {
        
        switch self {
        case .ultraLight: return .ultraLight
        case .thin: return .thin
        case .light: return .light
        case .regular: return .regular
        case .medium: return .medium
        case .semibold: return .semibold
        case .bold: return .bold
        case .heavy: return .heavy
        case .black: return .black
        }
    }
    
    static func weightName(for fontWeight: UIFont.Weight) -> String {
        
        var name: String!
        
        for w in FontWeight.cases {
            
            if w.weight == fontWeight {
                name = w.description
                break
            }
        }
        
        return name
    }
}
