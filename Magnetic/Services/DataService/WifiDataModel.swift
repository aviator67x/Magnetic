//
//  WifiDataModel.swift
//  MagneticDetection
//
//  Created by Andrew Kasilov on 02.04.2024.
//

import Foundation

struct WifiDataModel: Decodable {
    let name: String
    let type: String
    let address: String
    let macAddress: String
    let hostName: String
    let isAvailable: Bool
}
