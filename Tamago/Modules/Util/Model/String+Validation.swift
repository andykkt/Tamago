//
//  String+Validation.swift
//  Marathon
//
//  Created by Andy Kim on 28/2/19.
//  Copyright © 2019 Hoodles. All rights reserved.
//

import Foundation

extension String {
    func isValidEmailAddress() -> Bool {
        let emailRegexString = "[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegexString).evaluate(with: self)
    }
}
