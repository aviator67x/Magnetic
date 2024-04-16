//
//  ViewController.swift
//  Magnetic
//
//  Created by Andrew Kasilov on 02.04.2024.
//

import Combine
import UIKit

final class MagneticViewController: UIViewController {
    // - MARK: Private properties
    private let magneticView = MagneticView()
    private let model = MagneticViewModel()

    private var cancellables = Set<AnyCancellable>()

    private var timer: Timer?

    // - MARK: Lifecycle
    override func loadView() {
        super.loadView()
        view = magneticView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupBinding()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
}

// - MARK: private extension
private extension MagneticViewController {
    func setupNavigationBar() {
        title = "Magnetic Detection"
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }

    func setupBinding() {
        magneticView
            .actionPublisher
            .sink { [weak self] action in
                switch action {
                case .measureMagnetism:
                    self?.model.measureMagnetism()

                case .stopMeasuring:
                    self?.magneticView.counterClockwise()
                }
            }
            .store(in: &cancellables)

        model
            .dataPublisher
            .receive(on: DispatchQueue.main)
            .dropFirst()
            .sink { [weak self] value in
                self?.magneticView.rotateArrow(angle: value)
            }
            .store(in: &cancellables)
    }
}
