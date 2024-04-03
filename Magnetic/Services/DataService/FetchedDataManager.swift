//
//  FetchedDataManager.swift
//  Magnetic
//
//  Created by Andrew Kasilov on 02.04.2024.
//

import Foundation

final class FetchedDataManager: DataManager {
    func getData() -> [WifiDataModel] {
        return [WifiDataModel]()
    }

    func getMagnetism() -> CGFloat {
        return CGFloat.random(in: 0 ... 1)
    }
}
