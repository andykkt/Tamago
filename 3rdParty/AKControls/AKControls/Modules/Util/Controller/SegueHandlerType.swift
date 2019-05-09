//
//  SegueHandlerType.swift
//  AKControls
//
//  Created by Andy Kim on 23/7/18.
//  Copyright © 2018 Hoodles. All rights reserved.
//

import UIKit

public protocol SegueHandlerType {
    associatedtype SegueIdentifier: RawRepresentable
}

public extension SegueHandlerType where Self: UIViewController, SegueIdentifier.RawValue == String {
    
    func performSegue(_ segueIdentifier: SegueIdentifier, sender: Any?) {
        performSegue(withIdentifier: segueIdentifier.rawValue, sender: sender)
    }
    
    /// To perform the segue after already queued UI actions. For instance, use in an unwind segue to perform a forward segue after viewDidAppear has finished.
    func performOnMainQueueSegue(_ segueIdentifier: SegueIdentifier, sender: Any?) {
        DispatchQueue.main.async { [weak self] in
            self?.performSegue(segueIdentifier, sender: sender)
        }
    }
    
    func segueIdentifier(forIdentifier identifier: String?) -> SegueIdentifier? {
        return identifier.flatMap { SegueIdentifier(rawValue: $0) }
    }
    
}
