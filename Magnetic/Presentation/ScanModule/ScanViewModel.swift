//
//  ScanViewModel.swift
//  Magnetic
//
//  Created by Andrew Kasilov on 14.04.2024.
//

import Combine
import Foundation

final class ScanViewModel {
    // - MARK: Private properties
    private(set) lazy var percentPublisher = percentValue.eraseToAnyPublisher()
    private lazy var percentValue = CurrentValueSubject<Int, Never>(0)

    private(set) lazy var transitionPublisher = transitionSubject.eraseToAnyPublisher()
    private lazy var transitionSubject = PassthroughSubject<Bool, Never>()
    private var cancellables = Set<AnyCancellable>()

    private let dataManager: DataManager = MockedDataManager()

    // - MARK: Lifecycle
    init() {
        setupBinding()
    }

    func setPercentValue() {
        dataManager.scanNetwork()
            .sink { [weak self] percent in
                self?.percentValue.value = percent
            }
            .store(in: &cancellables)
    }
}

// - MARK: private extension
private extension ScanViewModel {
    func setupBinding() {
        percentValue
            .sink { [weak self] value in
                if value == 100 {
                    self?.transitionSubject.send(true)
                }
            }
            .store(in: &cancellables)
    }
}
