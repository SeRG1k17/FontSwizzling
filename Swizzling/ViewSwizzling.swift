////////////////////////////////////////////////////////////////////////////////
// COPYRIGHT:       Tandem Diabetes Care 2017.  All rights reserved.
// FILE:            ViewSwizzling.swift
// FILE THEME:      Replace default system font
// ORIGINAL AUTHOR: Barefoot Solutions
////////////////////////////////////////////////////////////////////////////////
import UIKit

extension UIView {
    
    static let classInit: Void = {
        
        let type = UIView.self
        
        swizzling(type,
                  class_getInstanceMethod(type, #selector(UIView.init(frame:))),
                  class_getInstanceMethod(type, #selector(UIView.swizzledInit(frame:))))
        
        swizzling(type,
                  class_getInstanceMethod(type, #selector(UIView.init(coder:))),
                  class_getInstanceMethod(type, #selector(UIView.swizzledInit(coder:))))
    }()
    
    @objc private func swizzledInit(frame: CGRect) -> UIView {
        
        let view = swizzledInit(frame: frame)
        view.setDefaultFontFamily(includingSubViews: true)
        
        return view
    }
    
    @objc private func swizzledInit(coder aDecoder: NSCoder) -> UIView? {
        
        guard let view = swizzledInit(coder: aDecoder) else { return nil }
        view.setDefaultFontFamily(includingSubViews: true)
        
        return view
    }
    
    func setDefaultFontFamily(includingSubViews: Bool) {
        
        if let label = self as? UILabel {
            label.font = UIFont(from: label.font)
            
        } else if let button = self as? UIButton, let titleLabel = button.titleLabel {
            button.titleLabel?.font = UIFont(from: titleLabel.font)
            
        }
        //        else if let textfield = self as? UITextField, let font = textfield.font {
        //            textfield.font = UIFont(from: font)
        //        }
        
        if includingSubViews {
            let _ = subviews.map { $0.setDefaultFontFamily(includingSubViews: includingSubViews) }
        }
    }
}

