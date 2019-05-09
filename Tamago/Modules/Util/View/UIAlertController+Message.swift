//
//  UIAlertController+Message.swift
//  Marathon
//
//  Created by Andy Kim on 28/2/19.
//  Copyright © 2019 Hoodles. All rights reserved.
//

import UIKit

extension UIAlertController {
    class func show(_ message: String, from controller: UIViewController) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default))
        controller.show(alert, sender: nil)
    }
}
