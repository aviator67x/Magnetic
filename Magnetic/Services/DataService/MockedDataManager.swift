//
//  MockedDataManager.swift
//  MagneticDetection
//
//  Created by Andrew Kasilov on 02.04.2024.
//

import Combine
import Foundation

final class MockedDataManager: DataManager {
    private var timer: Timer?

    func getData() -> [WifiDataModel] {
        if let url = Bundle.main.url(forResource: "WiFiData", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([WifiDataModel].self, from: data)
                return jsonData
            } catch {
                print("Can't decode Json, error:\(error)")
            }
        }
        return []
    }

    func getMagnetism() -> CGFloat {
        return CGFloat.random(in: 0 ... CGFloat.pi)
    }

    func scanNetwork() -> AnyPublisher<Int, Never> {
        var subject = PassthroughSubject<Int, Never>()
        var publisher = subject.eraseToAnyPublisher()
        let array = Array(0 ... 100)
        var index = 0
        timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { _ in
            subject.send(array[index])

            if index < 100 {
                index += 1
            } else {
                self.timer?.invalidate()
                self.timer = nil
            }
        }
        return publisher
    }
}
