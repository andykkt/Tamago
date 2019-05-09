//
//  Date+DateFormatter.swift
//  Marathon
//
//  Created by Andy Kim on 11/3/19.
//  Copyright © 2019 Hoodles. All rights reserved.
//

import Foundation

extension Date {
    func stringWithFormatter(_ dateFormatter: DateFormatter) -> String {
        return dateFormatter.string(from: self)
    }
}
