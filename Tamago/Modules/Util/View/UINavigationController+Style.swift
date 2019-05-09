//
//  UINavigationController+Style.swift
//  Marathon
//
//  Created by Andy Kim on 4/3/19.
//  Copyright © 2019 Hoodles. All rights reserved.
//

import UIKit

extension UINavigationController {
    
    func darkStyle() {
        // Update navigation appearance
        let image = UIImage()
        navigationBar.setBackgroundImage(image, for: UIBarMetrics.default)
        navigationBar.shadowImage = image
        navigationBar.isTranslucent = false
        navigationBar.backgroundColor = UIColor(hexString: "#001C32")
        navigationBar.tintColor = .white
        navigationBar.barTintColor = UIColor(hexString: "#001C32")
        navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationBar.barStyle = .black
    }
    
    func lightStyle() {
        let image = UIImage()
        navigationBar.setBackgroundImage(image, for: UIBarMetrics.default)
        navigationBar.shadowImage = image
        navigationBar.isTranslucent = false
        navigationBar.titleTextAttributes = [.foregroundColor: UIColor(hexString: "#9E36FF")]
        navigationBar.tintColor = UIColor(hexString: "#9E36FF")
    }
}
