//
//  MainViewController.swift
//  Magnetic
//
//  Created by Andrew Kasilov on 02.04.2024.
//

import Combine
import UIKit

final class MainViewController: UIViewController {
    // - MARK: Private properties
    private let mainView = MainView()
    private let model = MagneticViewModel()

    private var cancellables = Set<AnyCancellable>()
    
    // - MARK: Lifecycle
    override func loadView() {
        super.loadView()
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let viewConroller = MagneticViewController()
//        navigationController?.pushViewController(viewConroller, animated: false)
    }
}
