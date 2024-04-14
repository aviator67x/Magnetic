//
//  ScanViewModel.swift
//  Magnetic
//
//  Created by Andrew Kasilov on 14.04.2024.
//

import Combine
import Foundation

final class ScanViewModel {
    private(set) lazy var percentPublisher = percentValue.eraseToAnyPublisher()
    private lazy var percentValue = CurrentValueSubject<Int, Never>(0)
    
    private(set) lazy var transitionPublisher = transitionSubject.eraseToAnyPublisher()
    private lazy var transitionSubject = PassthroughSubject<Bool, Never>()
    
    @Published var showDetails: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    private var timer: Timer?

    init() {
//        setPercentValue()
        setupBinding()
    }
    
    func setPercentValue() {
        let array = Array(0 ... 100)
        var index = 0
        timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { _ in
            self.percentValue.send(array[index])
            if index < 100 {
                index += 1
            } else {
                self.timer?.invalidate()
                self.timer = nil
            }
        }
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
