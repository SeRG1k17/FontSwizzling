////////////////////////////////////////////////////////////////////////////////
// COPYRIGHT:       Tandem Diabetes Care 2017.  All rights reserved.
// FILE:            FontSwizzling.swift
// FILE THEME:      Replace default system font
// ORIGINAL AUTHOR: Barefoot Solutions
////////////////////////////////////////////////////////////////////////////////

import UIKit


extension UIFont {
    
    static let classInit: Void = {
        
        let type = UIFont.self
        exchangeSwizzling(class_getClassMethod(type, #selector(systemFont(ofSize:))),
                          class_getClassMethod(type, #selector(swizzledSystemFont(ofSize:))))
        
        exchangeSwizzling(class_getClassMethod(type, #selector(systemFont(ofSize:weight:))),
                          class_getClassMethod(type, #selector(swizzledSystemFont(ofSize:weight:))))
        
        exchangeSwizzling(class_getClassMethod(type, #selector(boldSystemFont(ofSize:))),
                          class_getClassMethod(type, #selector(swizzledBoldSystemFont(ofSize:))))
    }()
    
    static var newFontFamily: String {
        return FontReplacer.shared.fontFamily
    }
    
    static var fontSeparator: String {
        return FontReplacer.shared.separator
    }
    
    
    @objc private class func swizzledSystemFont(ofSize fontSize: CGFloat) -> UIFont {
        
        var fontName = newFontFamily.removeWhitespaces + fontSeparator + FontWeight.regular.description
        
        if let font = UIFont(name: fontName, size: fontSize) {
            return font
            
        } else {
            
            fontName = newFontFamily
            if let firstFontName = UIFont.fontNames(forFamilyName: newFontFamily).first {
                fontName = firstFontName
            }
            
            return UIFont.font(fontName, ofSize: fontSize, defaultMethod: UIFont.systemFont(ofSize:))
        }
    }
    
    @objc private class func swizzledSystemFont(ofSize fontSize: CGFloat, weight: UIFont.Weight) -> UIFont {
        
        let fontName = newFontFamily.removeWhitespaces + fontSeparator + FontWeight.weightName(for: weight)
        return UIFont.font(fontName, ofSize: fontSize, defaultMethod: UIFont.systemFont)
    }
    
    @objc private class func swizzledBoldSystemFont(ofSize fontSize: CGFloat) -> UIFont {
        
        let fontName = newFontFamily.removeWhitespaces + fontSeparator + FontWeight.bold.description
        return UIFont.font(fontName, ofSize: fontSize, defaultMethod: UIFont.boldSystemFont)
    }
    
    static func font(_ fontName: String, ofSize fontSize: CGFloat, defaultMethod: (CGFloat) -> (UIFont) ) -> UIFont {
        
        if let font = UIFont(name: fontName, size: fontSize) {
            return font
            
        } else {
            return defaultMethod(fontSize)
        }
    }
    
    
    convenience init?(from font: UIFont) {
        
        var fontName = font.fontName
        
        print(fontName)
        if font.familyName == UIFont.swizzledSystemFont(ofSize: font.pointSize).familyName {
            fontName = UIFont.newFontFamily.removeWhitespaces
            
            if let weightName = font.weightName {
                fontName += weightName
            }
        }
        
        print(fontName)
        self.init(name: fontName, size: font.pointSize)
    }
    
    var weightName: String? {
        
        guard let match = fontName.range(of: "\(UIFont.fontSeparator)[\\w]+$", options: .regularExpression) else {
            return nil }
        return String(fontName[match])
    }
}

