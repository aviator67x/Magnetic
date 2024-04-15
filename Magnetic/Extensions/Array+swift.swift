//
//  Array+swift.swift
//  Magnetic
//
//  Created by Andrew Kasilov on 04.04.2024.
//

import Foundation

extension Array {
    subscript(safe index: Index) -> Element? {
        let isValidIndex = index >= 0 && index < count

        return isValidIndex ? self[index] : nil
    }
}
