//
//  Coordinator.swift
//  Marathon
//
//  Created by Andy Kim on 10/2/19.
//  Copyright © 2019 Hoodles. All rights reserved.
//

import UIKit

enum TransitionStyle {
    case modal(presentingViewController: UIViewController)
    case push(navigationController: UINavigationController)
    
    func start(viewController: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        switch self {
        case .modal(let presentingViewController):
            presentingViewController.present(viewController, animated: animated, completion: completion)
        case .push(let navigationController):
            navigationController.pushViewController(viewController, animated: animated)
            // [TODO] maybe we can use navigationController delegate to call completion block
        }
    }
}

protocol Coordinator {
    func start()
}

protocol TabCoordinator: Coordinator {
    var rootViewController: UIViewController { get }
}
