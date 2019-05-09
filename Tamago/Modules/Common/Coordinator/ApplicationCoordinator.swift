//
//  ApplicationCoordinator.swift
//  Marathon
//
//  Created by Andy Kim on 10/2/19.
//  Copyright © 2019 Hoodles. All rights reserved.
//

import UIKit

class ApplicationCoordinator: Coordinator {
    let window: UIWindow
    let rootViewController: UINavigationController
    var canvasCoordinator: CanvasCoordinator!
    
    init(window: UIWindow) {
        self.window = window
        rootViewController = UINavigationController()
        self.window.rootViewController = rootViewController
        self.window.makeKeyAndVisible()
    }
    
    func start() {
        canvasCoordinator = CanvasCoordinator(transitionStyle: .modal(presentingViewController: rootViewController))
        canvasCoordinator.start()
    }
}
