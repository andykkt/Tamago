//
//  InputTextFieldView.swift
//  Marathon
//
//  Created by Andy Kim on 15/1/19.
//  Copyright © 2019 Hoodles. All rights reserved.
//

import UIKit
import AKControls

@IBDesignable
class InputTextFieldView: NibView {

    static let height: CGFloat = 48.0
    static let cornerRadius: CGFloat = 10.0
    
    @IBOutlet weak var textField: UITextField!
    
    @IBInspectable var text: String? {
        get {
            return textField.text
        }
        set {
            textField.text = newValue
        }
    }
    
    @IBInspectable var placeholder: String? {
        get {
            return textField?.placeholder
        }
        set {
            textField?.placeholder = newValue
        }
    }
    
    // MARK: - UIView
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var size = super.intrinsicContentSize
        size.height = InputTextFieldView.height
        return size
    }
    
    override var intrinsicContentSize: CGSize {
        var size = super.intrinsicContentSize
        size.height = InputTextFieldView.height
        return size
    }
    
    override func commonInit() {
        layer.cornerRadius = InputTextFieldView.cornerRadius
        layer.masksToBounds = true
    }

}
