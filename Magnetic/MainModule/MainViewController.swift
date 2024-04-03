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

    private var cancellables = Set<AnyCancellable>()

    // - MARK: Lifecycle
    override func loadView() {
        super.loadView()
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupBinding()
    }
}

// - MARK: private extension
private extension MainViewController {
    func setupNavigation() {
        title = "Main"
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: UIImageView(image: UIImage(named: "filter")))
    }

    func setupBinding() {
        mainView.actionPublisher
            .sink { [weak self] _ in
                let viewConroller = MagneticViewController()
                self?.navigationController?.pushViewController(viewConroller, animated: true)
            }
            .store(in: &cancellables)
    }
}
