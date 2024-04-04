//
//  Array+swift.swift
//  Magnetic
//
//  Created by Andrew Kasilov on 04.04.2024.
//

import Foundation

extension Array {
    func getElement(at index: Int) -> Element? {
        let isValidIndex = index >= 0 && index < count
        
        return isValidIndex ? self[index] : nil
    }
    
    @discardableResult
    mutating func removeSafe(at index: Int) -> Element? {
        let isValidIndex = index >= 0 && index < count
        
        return remove(at: index)
    }

    subscript(safe index: Index) -> Element? {
        let isValidIndex = index >= 0 && index < count

        return isValidIndex ? self[index] : nil
    }
}
