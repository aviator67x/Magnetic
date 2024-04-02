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
        setupBinding()
        model.getData()
    }
}

// - MARK: private extension
private extension ViewController {
    func setupBinding() {
        magneticView.actionPublisher
            .sink { [weak self] action in
                switch action {
                case .didPressButton:
                    print("Hi")
                }
            }
            .store(in: &cancellables)

        model.dataPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
//                self?.magneticView.updateDash()
            }
            .store(in: &cancellables)
    }
}
