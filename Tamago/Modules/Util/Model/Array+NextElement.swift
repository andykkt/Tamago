//
//  Array+NextElement.swift
//  Emote
//
//  Created by Andy Kim on 15/1/19.
//  Copyright © 2019 Hoodles. All rights reserved.
//

import Foundation

extension Array where Element: Equatable {
    func next(item: Element) -> Element? {
        if let index = self.firstIndex(of: item), index + 1 < self.count {
            return self[index + 1]
        }
        return nil
    }
    
    func prev(item: Element) -> Element? {
        if let index = self.firstIndex(of: item), index >= 0 {
            return index == 0 ? self.last : self[index - 1]
        }
        return nil
    }
}
