//
//  MockedDataManager.swift
//  MagneticDetection
//
//  Created by Andrew Kasilov on 02.04.2024.
//

import Foundation

final class MockedDataManager: DataManager {
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
}
