//
//  ViewModel.swift
//  MagneticDetection
//
//  Created by Andrew Kasilov on 02.04.2024.
//

import Combine
import Foundation

final class MagneticViewModel {
    // - MARK: Private properties
    private(set) lazy var dataPublisher = dataValue.eraseToAnyPublisher()
    private lazy var dataValue = CurrentValueSubject<CGFloat, Never>(0)

    private let dataManager: DataManager = MockedDataManager()

    func measureMagnetism() {
        let data = dataManager.getMagnetism()
        dataValue.send(data)
    }
}
