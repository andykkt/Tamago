//
//  UIViewLoading+Xib.swift
//  Marathon
//
//  Created by Andy Kim on 10/2/19.
//  Copyright © 2019 Hoodles. All rights reserved.
//

import UIKit

extension UIView {
    class func instanceFromNib() -> UIView? {
        let nibName = String(describing: self)
        return UINib(nibName: nibName, bundle: nil)
            .instantiate(withOwner: self, options: nil)[0] as? UIView
    }
}
