//
//  UIButton+VerticalLayout.swift
//  Emote
//
//  Created by Andy Kim on 16/1/19.
//  Copyright © 2019 Hoodles. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    
    func bottomAlignText (spacing: CGFloat = 15.0) {
        // lower the text and push it left so it appears centered
        //  below the image
        if let image = self.imageView!.image {
            let imageSize = image.size
            self.titleEdgeInsets = UIEdgeInsets(top: 0, left: -imageSize.width, bottom: -(imageSize.height + spacing), right: 0.0)
        }
        
        // raise the image and push it right so it appears centered
        // above the text
        if let titleLabel = self.titleLabel,
            let text = titleLabel.text {
            let titleSize: CGSize = text.size(withAttributes: [NSAttributedString.Key.font: titleLabel.font])
            self.imageEdgeInsets = UIEdgeInsets(top: -(titleSize.height + spacing), left: 0.0, bottom: 0.0, right: -titleSize.width)
        }
    }
    
    func bottomAlignImage () {
        if let image = self.imageView!.image,
            let titleLabel = self.titleLabel,
            let text = titleLabel.text {
            let imageSize = image.size
            self.titleEdgeInsets = UIEdgeInsets(top: 0, left: -imageSize.width, bottom: 0.0, right: 0.0)
            let titleSize: CGSize = text.size(withAttributes: [NSAttributedString.Key.font: titleLabel.font])
            self.imageEdgeInsets = UIEdgeInsets(top: self.frame.height-imageSize.height, left: 0.0, bottom: 0.0, right: -titleSize.width)
        }
    }
}
