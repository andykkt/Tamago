//
//  BottomTextButton.swift
//  Marathon
//
//  Created by Andy Kim on 16/1/19.
//  Copyright © 2019 Hoodles. All rights reserved.
//

import UIKit

@IBDesignable
class BottomTextButton: UIButton {
    
    @IBInspectable var spacing: CGFloat = 15.0
    
    override func layoutSubviews() {
        super.layoutSubviews()
        bottomAlignText(spacing: spacing)
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        bottomAlignText(spacing: spacing)
    }
}
