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
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
//            .throttle(for: .milliseconds(500), scheduler: DispatchQueue.main, latest: true)
            .sink { [weak self] action in
                switch action {
                case .measureMagnetism:
                    self?.model.measureMagnetism()

                    self?.timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { _ in
                        let vc = WifiViewController()
                        self?.navigationController?.pushViewController(vc, animated: true)
                    }
                case .stopMeasuring:
                    self?.timer?.invalidate()
                    self?.timer = nil
                    self?.magneticView.counterClockwise()
                }
            }
            .store(in: &cancellables)

        model
            .dataPublisher
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .receive(on: DispatchQueue.main)
            .dropFirst()
            .sink { [weak self] value in
                self?.magneticView.rotateArrow(angle: value)
            }
            .store(in: &cancellables)
    }
}
