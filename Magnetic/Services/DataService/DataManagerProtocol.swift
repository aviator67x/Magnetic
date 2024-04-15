//
//  DataManagerProtocol.swift
//  Magnetic
//
//  Created by Andrew Kasilov on 02.04.2024.
//

import Foundation
import Combine

protocol DataManager {
    func getData() -> [WifiDataModel]
    func getMagnetism() -> CGFloat
    func scanNetwork() -> AnyPublisher<Int, Never>
}
