//
//  ColorOptionView.swift
//  Tamago
//
//  Created by Andy Kim on 1/5/19.
//  Copyright © 2019 Hoodles. All rights reserved.
//

import UIKit

@IBDesignable
class ColorOptionView: UIView {

    @IBInspectable var isSelected: Bool = false {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var color: UIColor = UIColor(hexString: "#000000") {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        drawColorOption(rect, selected: isSelected)
    }
 
    func drawColorOption(_ frame: CGRect, selected: Bool = true) {
        //// General Declarations
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        if (selected) {
            //// Oval Drawing
            let ovalPath = UIBezierPath(ovalIn: CGRect(x: frame.minX + 1, y: frame.minY + 1, width: 26, height: 26))
            color.setStroke()
            ovalPath.lineWidth = 2
            ovalPath.stroke()
        }
        
        
        //// Oval 2 Drawing
        context.saveGState()
        context.translateBy(x: frame.minX + 14, y: frame.minY + 14)
        context.rotate(by: -179.11 * CGFloat(Double.pi) / 180)
        
        let oval2Path = UIBezierPath(ovalIn: CGRect(x: -11.07, y: -10.68, width: 22.13, height: 21.36))
        color.setFill()
        oval2Path.fill()
        
        context.restoreGState()
    }

}
