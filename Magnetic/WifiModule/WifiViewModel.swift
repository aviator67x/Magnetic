//
//  WifiViewModel.swift
//  Magnetic
//
//  Created by Andrew Kasilov on 02.04.2024.
//

import Foundation
import Combine

final class WifiViewModel {
    private(set) lazy var networkDataPublisher = networkDataSubject.eraseToAnyPublisher()
    private lazy var networkDataSubject = CurrentValueSubject<[WifiDataModel], Never>([])
    
    private let dataManager: DataManager = MockedDataManager()
    
    func getNetData() {
        let data = dataManager.getData()
        networkDataSubject.value = data
    }
}
