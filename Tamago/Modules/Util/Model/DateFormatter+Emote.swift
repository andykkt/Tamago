//
//  DateFormatter+Emote.swift
//  Emote
//
//  Created by Andy Kim on 26/1/19.
//  Copyright © 2019 Hoodles. All rights reserved.
//

import Foundation

extension DateFormatter {
    static let dayNameMonthDayNumberYearFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.amSymbol = "am"
        dateFormatter.pmSymbol = "pm"
        dateFormatter.dateFormat = "E, MMM dd yyyy \u{2022} hh:mma"
        return dateFormatter
    }()
    
    static let dateOfBirthFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd yyyy"
        return dateFormatter
    }()
    
    static let dayNumberYearFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.amSymbol = "am"
        dateFormatter.pmSymbol = "pm"
        dateFormatter.dateFormat = "MMM dd yyyy \u{2022} hh:mma"
        return dateFormatter
    }()
    
    static let UTCFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        return dateFormatter
    }()
    
    static let iso8601Formatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        return dateFormatter
    }()
}

