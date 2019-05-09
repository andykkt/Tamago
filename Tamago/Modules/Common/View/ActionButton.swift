//
//  ActionButton.swift
//  Marathon
//
//  Created by Andy Kim on 9/1/19.
//  Copyright © 2019 Hoodles. All rights reserved.
//

import UIKit

@IBDesignable
class ActionButton: UIButton {
    static let buttonHeight: CGFloat = 48.0
    static let buttonCornerRadius: CGFloat = buttonHeight * 0.5
    static let buttonDisabledBackgroundColor: UIColor = UIColor(hexString: "#EBECF1")
    static let buttonDisabledTextColor: UIColor = .white
    
    enum ButtonStyle: Int {
        case normal
        case secondary
        case actionPrimary
        case actionSecondary
        
        var textColor: UIColor {
            switch self {
            case .normal: return .white
            case .secondary: return UIColor(hexString: "#001C32")
            case .actionPrimary: return .white
            case .actionSecondary: return .white
            }
        }
        
        var backgroundColor: UIColor {
            switch self {
            case .normal: return .black
            case .secondary: return .white
            case .actionPrimary: return UIColor(hexString: "#9B51E0")
            case .actionSecondary: return UIColor(hexString: "#2F80ED")
            }
        }
        
    }
    
    var buttonStyle: ButtonStyle = .normal { didSet { setNeedsUpdateColor() }}
    
    @IBInspectable open var _buttonStyle: Int {
        get {
            return buttonStyle.rawValue
        }
        set {
            buttonStyle = ActionButton.ButtonStyle(rawValue: newValue) ?? .normal
        }
    }
    
    // MARK: - UIButton
    
    override var isEnabled: Bool {
        get {
            return super.isEnabled
        }
        set {
            super.isEnabled = newValue
            setNeedsUpdateColor()
        }
    }
    
    // MARK: - Private Functions
    
    fileprivate func setNeedsUpdateColor() {
        if isEnabled {
            backgroundColor = buttonStyle.backgroundColor
            setTitleColor(buttonStyle.textColor, for: .normal)
        } else {
            backgroundColor = ActionButton.buttonDisabledBackgroundColor
            setTitleColor(ActionButton.buttonDisabledTextColor, for: .normal)
        }
        setNeedsDisplay()
    }
    
    // MARK: - UIView
    
    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        var size = super.intrinsicContentSize
        size.height = ActionButton.buttonHeight
        return size
    }
    
    open override var intrinsicContentSize: CGSize {
        var size = super.intrinsicContentSize
        size.height = ActionButton.buttonHeight
        return size
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        layer.cornerRadius = ActionButton.buttonCornerRadius
        layer.masksToBounds = true
    }
}

