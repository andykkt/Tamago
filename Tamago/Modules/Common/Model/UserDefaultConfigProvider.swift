//
//  UserDefaultConfigProvider.swift
//  Marathon
//
//  Created by Andy Kim on 17/2/19.
//  Copyright © 2019 Hoodles. All rights reserved.
//

import Foundation
import AKControls

struct UserDefaultConfigProvider: ConfigProvidable, DefaultsHandlerType {
    // MARK: - DefaultHandlerType
    
    enum Key: String {
        case isOnboardingFinished
        case user
    }
    
    static var defaults: UserDefaults {
        return UserDefaults.standard
    }
    
    var isOnboardingFinished: Bool {
        get {
            return UserDefaultConfigProvider.bool(for: .isOnboardingFinished)
        }
        set {
            UserDefaultConfigProvider.setValue(newValue, for: .isOnboardingFinished)
        }
    }
}
