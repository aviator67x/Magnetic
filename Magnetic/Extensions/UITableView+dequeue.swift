//
//  UITableView+dequeue.swift
//  Magnetic
//
//  Created by Andrew Kasilov on 03.04.2024.
//

import UIKit

extension UITableView {
    func register(_ cellClass: UITableViewCell.Type) {
        let identifier = cellClass.reusableIdentifier
        register(cellClass, forCellReuseIdentifier: identifier)
    }

    func dequeueReusableCell<Cell: UITableViewCell>(for indexPath: IndexPath) -> Cell {
        let identifier = Cell.reusableIdentifier
        guard let cell = dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? Cell else {
            fatalError("\(Cell.self) should be a \(UITableViewCell.self)")
        }

        return cell
    }
}
