//
//  View.swift
//  Swizzling
//
//  Created by Sergey Pugach on 10/6/17.
//  Copyright © 2017 Sergey Pugach. All rights reserved.
//

import UIKit

extension UIView {
    
    static let classInit: Void = {
        instanceMethodSwizzling(UIView.self, #selector(UIView.init(frame:)), #selector(swizzledInit(frame:)))
        instanceMethodSwizzling(UIView.self, #selector(UIView.init(coder:)), #selector(swizzledInit(coder:)))
    }()
    
    
    @objc func swizzledInit(frame: CGRect) -> UIView {
        
        let view = swizzledInit(frame: frame)
        view.setDefaultFontFamily(includingSubViews: true)
        
        return view
    }
    
    @objc func swizzledInit(coder aDecoder: NSCoder) -> UIView? {
        
        guard let view = swizzledInit(coder: aDecoder) else { return nil }
        view.setDefaultFontFamily(includingSubViews: true)
        
        return view
    }
    
    func setDefaultFontFamily(includingSubViews: Bool) {
        
        if let label = self as? UILabel {
            label.font = UIFont(from: label.font)
        }
        
//        else if let button = self as? UIButton, let titleLabel = button.titleLabel, let newFont = UIFont(from: titleLabel.font) {
//            titleLabel.font = newFont
//
//        } else if let textfield = self as? UITextField, var font = textfield.font, let newFont = UIFont(from: font) {
//            font = newFont
//        }
        
        if includingSubViews {
            let _ = subviews.map { $0.setDefaultFontFamily(includingSubViews: includingSubViews) }
        }
    }
}
