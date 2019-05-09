//
//  NibCollectionViewCell.swift
//  AKControls
//
//  Created by Andy Kim on 21/7/18.
//  Copyright © 2018 Hoodles. All rights reserved.
//

import UIKit

@IBDesignable open class NibCollectionViewCell: AKNibCollectionViewCell {
    
    // TODO: Move to NibReplaceable:
    
    @objc open func replacedByNibView() -> UIView {
        return replacedByNibView(fromNibNamed: type(of: self).nibName)
    }
}
