//
//  Encodable+Dictionary.swift
//  Marathon
//
//  Created by Andy Kim on 10/3/19.
//  Copyright © 2019 Hoodles. All rights reserved.
//

import Foundation

extension Encodable {
    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}
