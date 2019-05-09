//
//  UITextField+PlaceholderColor.swift
//  Emote
//
//  Created by Andy Kim on 16/1/19.
//  Copyright © 2019 Hoodles. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    @IBInspectable var placeholderColor: UIColor {
        get {
            guard let currentAttributedPlaceholderColor = attributedPlaceholder?.attribute(kCTForegroundColorAttributeName as NSAttributedString.Key, at: 0, effectiveRange: nil) as? UIColor else { return UIColor.clear }
            return currentAttributedPlaceholderColor
        }
        set {
            guard let currentAttributedString = attributedPlaceholder else { return }
            let attributes = [kCTForegroundColorAttributeName : newValue]
            attributedPlaceholder = NSAttributedString(string: currentAttributedString.string, attributes: attributes as [NSAttributedString.Key : Any])
        }
    }
}
