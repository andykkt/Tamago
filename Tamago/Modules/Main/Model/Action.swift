//
//  Action.swift
//  Tamago
//
//  Created by Andy Kim on 9/5/19.
//  Copyright © 2019 Hoodles. All rights reserved.
//
import UIKit

struct Color : Codable {
    var red : CGFloat = 0.0, green: CGFloat = 0.0, blue: CGFloat = 0.0, alpha: CGFloat = 0.0
    
    var uiColor : UIColor {
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    init(uiColor : UIColor) {
        uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
    }
}

struct ActionParameter: Codable {
    var point: CGPoint
    var brushWidth: CGFloat
    var opacity: CGFloat
    var color: UIColor
    
    private enum CodingKeys: String, CodingKey {
        case point, brushWidth, opacity, color
    }
    
    init(point: CGPoint, brushWidth: CGFloat, opacity: CGFloat, color: UIColor) {
        self.point = point
        self.brushWidth = brushWidth
        self.opacity = opacity
        self.color = color
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        point = try container.decode(CGPoint.self, forKey: .point)
        brushWidth = try container.decode(CGFloat.self, forKey: .brushWidth)
        opacity = try container.decode(CGFloat.self, forKey: .opacity)
        color = try container.decode(Color.self, forKey: .color).uiColor
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(point, forKey: .point)
        try container.encode(brushWidth, forKey: .brushWidth)
        try container.encode(opacity, forKey: .opacity)
        try container.encode(Color(uiColor: color), forKey: .color)
    }
}

enum Action: Codable {
    case begin(param: ActionParameter)
    case move(point: CGPoint)
    case end(point: CGPoint)
    
    enum CodingKeys: String, CodingKey {
        case begin, move, end
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .begin(let point): try container.encode(point, forKey: .begin)
        case .move(let point): try container.encode(point, forKey: .move)
        case .end(let point): try container.encode(point, forKey: .end)
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let param = try container.decodeIfPresent(ActionParameter.self, forKey: .begin) {
            self = .begin(param: param)
        } else if let point = try container.decodeIfPresent(CGPoint.self, forKey: .move) {
            self = .move(point: point)
        } else {
            self = .end(point: try container.decode(CGPoint.self, forKey: .end))
        }
    }
}
