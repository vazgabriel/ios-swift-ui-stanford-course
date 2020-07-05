//
//  Array+Identifiable.swift
//  Memorize
//
//  Created by Gabriel de Carvalho on 6/30/20.
//  Copyright © 2020 Gabriel de Carvalho. All rights reserved.
//

import Foundation

extension Array where Element: Identifiable { // Util function to get first Index of identifiable element
    func firstIndex(matching element: Element) -> Int? {
        for i in self.indices {
            if (element.id == self[i].id) {
                return i
            }
        }
        return nil
    }
}
