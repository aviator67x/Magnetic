//
//  ViewController.swift
//  Magnetic
//
//  Created by Andrew Kasilov on 02.04.2024.
//

import Combine
import UIKit

class ViewController: UIViewController {
    // - MARK: Private properties
    private let magneticView = MagneticView()
    private let model = MagneticViewModel()

    private var cancellables = Set<AnyCancellable>()

    // - MARK: Lifecycle
    override func loadView() {
        super.loadView()
        view = magneticView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Magnetic Detection"
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        setupBinding()
    }
}

// - MARK: private extension
private extension ViewController {
    func setupBinding() {
        magneticView.actionPublisher
            .sink { [weak self] action in
                switch action {
                case .didPressButton:
                    self?.model.measureMagnetism()
                case .showWifi:
                    let vc = WifiViewController()
//                    self?.navigationController?.pushViewController(vc, animated: true)
                }
            }
            .store(in: &cancellables)

        model.dataPublisher
            .receive(on: DispatchQueue.main)
            .dropFirst()
            .sink { [weak self] value in
                self?.magneticView.rotateArrow(angle: value)
            }
            .store(in: &cancellables)
    }
}
