//
//  FetchedDataManager.swift
//  Magnetic
//
//  Created by Andrew Kasilov on 02.04.2024.
//

import Foundation
import Combine

final class FetchedDataManager: DataManager {
    func getData() -> [WifiDataModel] {
        return [WifiDataModel]()
    }

    func getMagnetism() -> CGFloat {
        return CGFloat.random(in: 0 ... 1)
    }
    
    func scanNetwork() -> AnyPublisher<Int, Never> {
        var subject = PassthroughSubject<Int, Never>()
        var publisher = subject.eraseToAnyPublisher()
        subject.send(0)
        return publisher
    }
}
