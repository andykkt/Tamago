//
//  CanvasUserView.swift
//  Tamago
//
//  Created by Andy Kim on 8/5/19.
//  Copyright © 2019 Hoodles. All rights reserved.
//

import UIKit

class CanvasUserView: UIImageView {
    
    var lastPoint = CGPoint.zero
    var color = UIColor.black
    var brushWidth: CGFloat = 2.0
    var opacity: CGFloat = 1.0
    var swiped = false
    var tempImageView: UIImageView!
    var mainImageView: UIImageView!
    
    func begin(_ point: CGPoint) {
        swiped = false
        lastPoint = point
    }
    
    func move(_ point: CGPoint) {
        swiped = true
        drawLine(from: lastPoint, to: point)
        lastPoint = point
    }
    
    func end() {
        if !swiped {
            drawLine(from: lastPoint, to: lastPoint)
        }
        
        // Merge tempImageView into mainImageView
        UIGraphicsBeginImageContext(mainImageView.frame.size)
        mainImageView.image?.draw(in: bounds, blendMode: .normal, alpha: 1.0)
        image?.draw(in: bounds, blendMode: .normal, alpha: opacity)
        mainImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        image = nil
    }
    
    private func drawLine(from fromPoint: CGPoint, to toPoint: CGPoint) {
        UIGraphicsBeginImageContext(frame.size)
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        image?.draw(in: bounds)
        
        context.move(to: fromPoint)
        context.addLine(to: toPoint)
        
        context.setLineCap(.round)
        context.setBlendMode(.normal)
        context.setLineWidth(brushWidth)
        context.setStrokeColor(color.cgColor)
        context.strokePath()
        
        image = UIGraphicsGetImageFromCurrentImageContext()
        alpha = opacity
        UIGraphicsEndImageContext()
    }
    
}
