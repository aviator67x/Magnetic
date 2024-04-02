//
//  MainViewController.swift
//  Magnetic
//
//  Created by Andrew Kasilov on 02.04.2024.
//

import Foundation
import UIKit

final class MainViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        title = "Main"
        
        let viewConroller = ViewController()
        navigationController?.pushViewController(viewConroller, animated: true)
    }
}
