//
//  Result.swift
//  AKControls
//
//  Created by Andy Kim on 24/7/18.
//  Copyright © 2018 Hoodles. All rights reserved.
//

import Foundation

/// An enum representing either a failure with an explanatory error, or a success with a result value.
enum Result<V, E: Error> {
    case success(V)
    case failure(E)
}
