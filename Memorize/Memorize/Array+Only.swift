//
//  Array+Only.swift
//  Memorize
//
//  Created by Gabriel de Carvalho on 7/1/20.
//  Copyright © 2020 Gabriel de Carvalho. All rights reserved.
//

import Foundation

extension Array {
    var only: Element? { // Util function to get only element in array
        count == 1 ? first : nil
    }
}
