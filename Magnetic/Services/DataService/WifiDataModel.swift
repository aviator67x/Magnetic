//
//  WifiDataModel.swift
//  MagneticDetection
//
//  Created by Andrew Kasilov on 02.04.2024.
//

import Foundation

struct WifiDataModel: Decodable {
    let name: String
    let address: String
    let isAvailable: Bool
}
