//
//  Font.swift
//  Swizzling
//
//  Created by Sergey Pugach on 10/6/17.
//  Copyright © 2017 Sergey Pugach. All rights reserved.
//

import UIKit

let DefaultFontFamily = "San Francisco Display" // "Sweet Sensations Personal Use"//
let Separator = "-"

extension String {
    var removeWhitespaces: String {
        return components(separatedBy: .whitespaces).joined()
    }
}

extension UIFont {
    
    var fontFamilyWithoutSpaces: String {
        return DefaultFontFamily.trimmingCharacters(in: .whitespaces)
    }
    
    static let classInit: Void = {
        classMethodSwizzling(UIFont.self, #selector(systemFont(ofSize:)), #selector(swizzledSystemFont(ofSize:)))
        classMethodSwizzling(UIFont.self, #selector(systemFont(ofSize:weight:)), #selector(swizzledSystemFont(ofSize:weight:)))
        classMethodSwizzling(UIFont.self, #selector(boldSystemFont(ofSize:)), #selector(swizzledBoldSystemFont(ofSize:)))
    }()
    
    
    @objc class func swizzledSystemFont(ofSize fontSize: CGFloat) -> UIFont {
        
        if let font = UIFont(name: DefaultFontFamily, size: fontSize) {
            return font
            
        } else if
            let firstFontName = UIFont.fontNames(forFamilyName: DefaultFontFamily).first,
            let font = UIFont(name: firstFontName, size: fontSize) {
            
            return font
            
        } else {
            return UIFont.swizzledSystemFont(ofSize: fontSize)
        }
    }

    @objc class func swizzledSystemFont(ofSize fontSize: CGFloat, weight: UIFont.Weight) -> UIFont {
        
        let fontName = DefaultFontFamily.removeWhitespaces + Separator + FontWeight.weightName(for: weight)
        
        if let font = UIFont(name: fontName, size: fontSize) {
            return font
            
        } else {
            return UIFont.swizzledSystemFont(ofSize: fontSize)
        }
    }
    
    @objc class func swizzledBoldSystemFont(ofSize fontSize: CGFloat) -> UIFont {
        
        let fontName = DefaultFontFamily.removeWhitespaces + Separator + FontWeight.bold.description
        
        if let font = UIFont(name: fontName, size: fontSize) {
            return font
            
        } else {
            return UIFont.swizzledBoldSystemFont(ofSize: fontSize)
        }
    }

    
    convenience init?(from font: UIFont) {
        
        var fontName = font.fontName
        
        if font.familyName == UIFont.swizzledSystemFont(ofSize: font.pointSize).familyName {
            
            fontName = DefaultFontFamily.removeWhitespaces
            
            if let weightName = font.weightName {
                fontName += Separator + weightName
            }
        }
        
        print(fontName)
        if UIFont(name: fontName, size: font.pointSize) == nil {
            fontName = font.fontName
        }
        
        self.init(name: fontName, size: font.pointSize)
    }
    
    var weightName: String? {

        guard let match = fontName.range(of: "[A-z][a-z]+$", options: .regularExpression) else { return nil }
        return String(fontName[match])
    }

}

enum FontWeight {
    
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
        
        for w in iterateEnum(FontWeight.self) {
            
            if w.weight == fontWeight {
                name = w.description
                break
            }
        }
        
        return name
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

