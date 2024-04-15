//
//  DeviceDataModel.swift
//  Magnetic
//
//  Created by Andrew Kasilov on 15.04.2024.
//

import Foundation


struct DeviceDataModel: Decodable {
    let connectionType: String
    let ipAddress: String
    let macAddress: String
    let hostName: String
}
