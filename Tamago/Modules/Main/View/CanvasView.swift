//
//  CanvasView.swift
//  Tamago
//
//  Created by Andy Kim on 1/5/19.
//  Copyright © 2019 Hoodles. All rights reserved.
//

import UIKit

protocol CanvasViewDelegate {
    func began(_ point: CGPoint)
    func move(_ point: CGPoint)
    func end(_ point: CGPoint)
}

class CanvasView: UIView {
    
    var delegate: CanvasViewDelegate?
    var color = UIColor.black {
        didSet {
            tempImageView.color = color
        }
    }
    var brushWidth: CGFloat = 2.0
    var opacity: CGFloat = 1.0
    var swiped = false
    var mainImageView: UIImageView!
    var tempImageView: CanvasUserView!
    var userImageViewDict = [String: CanvasUserView]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        mainImageView = UIImageView(frame: bounds)
        addSubview(mainImageView)
        mainImageView.pinToSuperviewEdges()
        tempImageView = CanvasUserView(frame: bounds)
        tempImageView.mainImageView = mainImageView
        addSubview(tempImageView)
        tempImageView.pinToSuperviewEdges()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let point = touch.location(in: self)
        tempImageView.begin(point)
        delegate?.began(point)
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let point = touch.location(in: self)
        tempImageView.move(point)
        delegate?.move(point)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let point = touch.location(in: self)
        tempImageView.end()
        delegate?.end(point)
    }
    
    func beginUserView(_ name: String) -> CanvasUserView {
        let userImageView: CanvasUserView
        if let imageView = userImageViewDict[name] {
            userImageView = imageView
        } else {
            userImageView = CanvasUserView(frame: bounds)
            userImageView.mainImageView = mainImageView
            addSubview(userImageView)
            userImageViewDict[name] = userImageView
        }
        
        bringSubviewToFront(userImageView)
        return userImageView
    }
    
    func receivedAction(_ name:String, actionType: Action) {
        switch actionType {
        case .begin(let param): begin(name, param: param)
        case .move(let point): move(name, point: point)
        case .end(_): end(name)
        }
    }
    
    private func begin(_ name: String, param: ActionParameter) {
        let userView = beginUserView(name)
        userView.color = param.color
        userView.brushWidth = param.brushWidth
        userView.opacity = param.opacity
        userView.begin(param.point)
    }
    
    private func move(_ name: String, point: CGPoint) {
        guard let userView = userImageViewDict[name] else { return }
        userView.move(point)
    }
    
    private func end(_ name: String) {
        guard let userView = userImageViewDict[name] else { return }
        userView.end()
    }
}

