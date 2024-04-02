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
    private lazy var dataValue = CurrentValueSubject<[WifiDataModel], Never>([])
    
    private let dataManager: DataManager = MockedDataManager()
    
    func getData() {
        let data = dataManager.getData()
        self.dataValue.send(data)
    }
}
