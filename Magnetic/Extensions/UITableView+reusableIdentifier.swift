//
//  UITableView+reusableIdentifier.swift
//  Magnetic
//
//  Created by Andrew Kasilov on 03.04.2024.
//

import UIKit

extension UITableViewCell {
    static var reusableIdentifier: String {
        return String (describing: self)
    }
}
