//
//  UIFont.swift
//  DesignKit
//
//  Created by Christian Adiputra on 28/02/23.
//

import UIKit

public extension UIFont {
    
    class func italicSystemFont(ofSize size: CGFloat, weight: UIFont.Weight = .regular)-> UIFont {
        let font = UIFont.systemFont(ofSize: size, weight: weight)
        switch weight {
        case .ultraLight, .light, .thin, .regular:
            return font.withTraits(.traitItalic, ofSize: size)
        case .medium, .semibold, .bold, .heavy, .black:
            return font.withTraits(.traitBold, .traitItalic, ofSize: size)
        default:
            return UIFont.italicSystemFont(ofSize: size)
        }
     }
    
    private func withTraits(_ traits: UIFontDescriptor.SymbolicTraits..., ofSize size: CGFloat) -> UIFont {
            let descriptor = self.fontDescriptor
                .withSymbolicTraits(UIFontDescriptor.SymbolicTraits(traits))
            return UIFont(descriptor: descriptor!, size: size)
         }
    
    static func bodySystem() -> UIFont {
        return UIFont.systemFont(ofSize: 16, weight: .regular)
    }
    
    static func boldSystem() -> UIFont {
        return UIFont.systemFont(ofSize: 20, weight: .bold)
    }
    
    static func title() -> UIFont {
        return UIFont.systemFont(ofSize: 28, weight: .bold)
    }
    
    static func italicSystem() -> UIFont {
        return UIFont.italicSystemFont(ofSize: 16, weight: .regular)
    }
    
}
