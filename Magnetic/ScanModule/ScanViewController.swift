//
//  ScanViewController.swift
//  Magnetic
//
//  Created by Andrew Kasilov on 14.04.2024.
//

import Combine
import UIKit

final class ScanViewController: UIViewController {
    // - MARK: Private properties
    private let scanView = ScanView()
    private let model = ScanViewModel()

    private var cancellables = Set<AnyCancellable>()

//    private var timer: Timer?

    // - MARK: Lifecycle
    override func loadView() {
        super.loadView()
        view = scanView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupBinding()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        model.setPercentValue()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}

// - MARK: private extension
private extension ScanViewController {
    func setupNavigationBar() {
        navigationItem.setHidesBackButton(true, animated: true)
    }

    func setupBinding() {
        scanView.actionPublisher
            .sink { [weak self] value in
                if value == .stopScanning {
                    self?.navigationController?.popViewController(animated: true)
                }
            }
            .store(in: &cancellables)
        
        model
            .percentPublisher
            .receive(on: DispatchQueue.main)
            .dropFirst()
            .sink { [weak self] value in
                self?.scanView.updatePercents(value)
            }
            .store(in: &cancellables)

        model.transitionPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] someValue in
                if someValue {
                    let vc = WifiViewController()
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
            }
            .store(in: &cancellables)
    }
}
