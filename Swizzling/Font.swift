//
//  Font.swift
//  Swizzling
//
//  Created by Sergey Pugach on 10/6/17.
//  Copyright © 2017 Sergey Pugach. All rights reserved.
//

import UIKit

let DefaultFontFamily = "San Francisco Display"
let Separator = ""

extension UIFont {
    
    var fontFamilyWithoutSpaces: String {
        return DefaultFontFamily.trimmingCharacters(in: .whitespaces)
    }
    
    static let classInit: Void = {
        classMethodSwizzling(UIFont.self, #selector(systemFont(ofSize:)), #selector(swizzledSystemFont(ofSize:)))
        classMethodSwizzling(UIFont.self, #selector(systemFont(ofSize:weight:)), #selector(swizzledSystemFont(ofSize:weight:)))
    }()
    
    
    @objc class func swizzledSystemFont(ofSize fontSize: CGFloat) -> UIFont {
        //string.trimmingCharacters(in: .whitespaces)
        //UIFont.familyNames.forEach { print($0)}
        let fonts = UIFont.fontNames(forFamilyName: DefaultFontFamily)
        
        print(fonts)
        return UIFont(name: "\(DefaultFontFamily)\(Separator)\(FontWeight.regular.string)", size: fontSize)!
    }

    @objc class func swizzledSystemFont(ofSize fontSize: CGFloat, weight: UIFont.Weight) -> UIFont {
        
        let fontName = DefaultFontFamily + Separator + FontWeight.weight(for: weight)
        return UIFont(name: fontName, size: fontSize)!
    }

    
    convenience init?(from font: UIFont) {
        
        var fontName = font.fontName
        if font == UIFont.systemFont(ofSize: font.pointSize) {
            fontName = DefaultFontFamily + Separator + UIFont.weight(for: font)
        }
        
        self.init(name: fontName, size: font.pointSize)
    }
    
    static func weight(for font: UIFont) -> String {
        
        print(font.fontName)
        var fontWeigth: String!
        
        if let match = font.fontName.range(of: "\(Separator)[\\w]+$", options: .regularExpression){
            fontWeigth = String(font.fontName[match])
            fontWeigth.removeFirst()
            
        } else {
            fontWeigth = FontWeight.regular.string
        }
        
        return fontWeigth
    }
}

enum FontWeight {
    
    case ultraLight, thin, light, regular, medium, semibold, bold, heavy, black
    var string: String {
        return String(describing: self).capitalized
    }
    
    var weight: UIFont.Weight {
        
        switch self {
        case .ultraLight: return UIFont.Weight.ultraLight
        case .thin: return UIFont.Weight.thin
        case .light: return UIFont.Weight.light
        case .regular: return UIFont.Weight.regular
        case .medium: return UIFont.Weight.medium
        case .semibold: return UIFont.Weight.semibold
        case .bold: return UIFont.Weight.bold
        case .heavy: return UIFont.Weight.heavy
        case .black: return UIFont.Weight.black
        }
    }
    
    static func weight(for fontWeight: UIFont.Weight) -> String {
        
        var result = FontWeight.regular.string
        
        for w in iterateEnum(FontWeight.self) {
            
            if w.weight == fontWeight {
                result =  w.string
            }
        }
        
        return result
    }
}

func iterateEnum<T: Hashable>(_: T.Type) -> AnyIterator<T> {
    var i = 0
    return AnyIterator {
        let next = withUnsafeBytes(of: &i) { $0.load(as: T.self) }
        if next.hashValue != i { return nil }
        i += 1
        return next
    }
}

