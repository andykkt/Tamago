//
//  CanvasCoordinator.swift
//  Tamago
//
//  Created by Andy Kim on 1/5/19.
//  Copyright © 2019 Hoodles. All rights reserved.
//

import UIKit

class CanvasCoordinator: NSObject, Coordinator {
    
    // MARK: - Definitions
    
    private enum StoryBoardIdentifier {
        static let main = "Main"
    }
    
    // MARK: - Dependencies
    
    var configProvider = UserDefaultConfigProvider()
    
    // MARK: - Private functions
    private let transitionStyle: TransitionStyle
    
    private lazy var rootView: CanvasViewController = {
        let storyboard = UIStoryboard(name: StoryBoardIdentifier.main, bundle: nil)
        guard let rootView = storyboard.instantiateViewController(withIdentifier: "canvasView") as? CanvasViewController
            else { fatalError("CanvasViewController not found") }
        return rootView
    }()
    
    // MARK: - Coordinator
    
    init(transitionStyle: TransitionStyle) {
        self.transitionStyle = transitionStyle
        super.init()
    }
    
    func start() {
        transitionStyle.start(viewController: rootView, animated: false)
    }
    
    // MARK: - Private Functions
    
}
