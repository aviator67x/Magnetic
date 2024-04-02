//
//  ViewModel.swift
//  MagneticDetection
//
//  Created by Andrew Kasilov on 02.04.2024.
//

import Foundation
import Combine

final class MagneticViewModel{
    private(set) lazy var dataPublisher = dataValue.eraseToAnyPublisher()
    private lazy var dataValue = CurrentValueSubject<CGFloat, Never>(0)
    
    private let dataManager: DataManager = MockedDataManager()
    
    func measureMagnetism() {
        let data = dataManager.getMagnetism()
        self.dataValue.send(data)
    }
}
